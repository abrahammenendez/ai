#!/usr/bin/env bash
# Applies the settings of a public open-source repo to a GitHub repository,
# then reads them back and reports any that differ.
#
#   configure.sh <owner/repo>             apply, then check
#   configure.sh --dry-run <owner/repo>   print the API calls, change nothing
#   configure.sh --check <owner/repo>     check only
#
# Safe to re-run: rulesets are matched by name and updated, and every other
# call sets a value rather than adding one. Run it after the first push:
# the main ruleset blocks direct pushes to the default branch.
set -euo pipefail

mode=apply
case "${1:-}" in
  --dry-run) mode=dry-run; shift ;;
  --check) mode=check; shift ;;
esac
repo=${1:?usage: configure.sh [--dry-run|--check] <owner/repo>}
api="repos/$repo"

# GitHub Actions' app id, so the Verify check must come from a workflow.
actions_app=15368
# Repository role id 5 is admin.
admin_role=5

call() { # method path [- to send the JSON on stdin]
  local method=$1 path=$2 body=""
  [ "${3:-}" != - ] || body=$(cat)
  if [ "$mode" = dry-run ]; then
    echo "$method $path"
    [ -z "$body" ] || echo "$body"
    return
  fi
  if [ -n "$body" ]; then
    gh api -X "$method" "$path" --input - > /dev/null <<< "$body"
  else
    gh api -X "$method" "$path" > /dev/null
  fi
}

ruleset() { # name, json from stdin
  local name=$1 body id=""
  body=$(cat)
  [ "$mode" = dry-run ] ||
    id=$(gh api "$api/rulesets" --jq ".[] | select(.name == \"$name\") | .id")
  if [ -n "$id" ]; then
    call PUT "$api/rulesets/$id" - <<< "$body"
  else
    call POST "$api/rulesets" - <<< "$body"
  fi
}

apply() {
  # General and merging: squash only, the PR title becomes the commit.
  call PATCH "$api" - <<'EOF'
{
  "has_issues": true, "has_wiki": false, "has_projects": false, "has_discussions": false,
  "allow_squash_merge": true, "allow_merge_commit": false, "allow_rebase_merge": false,
  "squash_merge_commit_title": "PR_TITLE", "squash_merge_commit_message": "BLANK",
  "allow_auto_merge": true, "delete_branch_on_merge": true, "allow_update_branch": true
}
EOF

  # Security.
  call PUT "$api/vulnerability-alerts"
  call PUT "$api/automated-security-fixes"
  call PUT "$api/private-vulnerability-reporting"
  call PATCH "$api" - <<'EOF'
{"security_and_analysis": {
  "secret_scanning": {"status": "enabled"},
  "secret_scanning_push_protection": {"status": "enabled"}
}}
EOF
  # CodeQL waits for code: it starts on the first push with a language it reads.
  call PATCH "$api/code-scanning/default-setup" - <<< '{"state": "configured"}'
  call PUT "$api/immutable-releases"

  # Actions: pinned actions only, a read-only token, and no workflow runs on
  # an outside contributor's PR until a maintainer approves it.
  call PUT "$api/actions/permissions" - \
    <<< '{"enabled": true, "allowed_actions": "all", "sha_pinning_required": true}'
  call PUT "$api/actions/permissions/workflow" - \
    <<< '{"default_workflow_permissions": "read", "can_approve_pull_request_reviews": false}'
  call PUT "$api/actions/permissions/fork-pr-contributor-approval" - \
    <<< '{"approval_policy": "all_external_contributors"}'

  # The default branch. Every change goes through a PR approved by a code
  # owner and passing Verify; admins may bypass on a PR, never by pushing.
  ruleset main <<EOF
{
  "name": "main", "target": "branch", "enforcement": "active",
  "conditions": {"ref_name": {"include": ["~DEFAULT_BRANCH"], "exclude": []}},
  "bypass_actors": [{"actor_id": $admin_role, "actor_type": "RepositoryRole", "bypass_mode": "pull_request"}],
  "rules": [
    {"type": "deletion"},
    {"type": "non_fast_forward"},
    {"type": "pull_request", "parameters": {
      "required_approving_review_count": 1,
      "require_code_owner_review": true,
      "require_last_push_approval": true,
      "dismiss_stale_reviews_on_push": true,
      "required_review_thread_resolution": true,
      "allowed_merge_methods": ["squash"]
    }},
    {"type": "required_status_checks", "parameters": {
      "strict_required_status_checks_policy": false,
      "required_status_checks": [{"context": "Verify", "integration_id": $actions_app}]
    }}
  ]
}
EOF

  # Every tag: none can be deleted or moved. Creating tags stays open, so
  # release workflows work.
  ruleset tags <<EOF
{
  "name": "tags", "target": "tag", "enforcement": "active",
  "conditions": {"ref_name": {"include": ["~ALL"], "exclude": []}},
  "bypass_actors": [{"actor_id": $admin_role, "actor_type": "RepositoryRole", "bypass_mode": "always"}],
  "rules": [{"type": "deletion"}, {"type": "non_fast_forward"}, {"type": "update"}]
}
EOF
}

failures=0
expect() { # path jq-filter expected
  local got
  got=$(gh api "$1" --jq "$2" 2>/dev/null || echo "<error>")
  if [ "$got" = "$3" ]; then
    echo "ok        $1 $2"
  else
    echo "DIFFERENT $1 $2: expected $3, got $got"
    failures=$((failures + 1))
  fi
}

check() {
  expect "$api" '.visibility' public
  expect "$api" '[.has_issues, .has_wiki, .has_projects, .has_discussions] | @csv' 'true,false,false,false'
  expect "$api" '[.allow_squash_merge, .allow_merge_commit, .allow_rebase_merge] | @csv' 'true,false,false'
  expect "$api" '[.squash_merge_commit_title, .squash_merge_commit_message] | @csv' '"PR_TITLE","BLANK"'
  expect "$api" '[.allow_auto_merge, .delete_branch_on_merge, .allow_update_branch] | @csv' 'true,true,true'
  expect "$api" '.security_and_analysis.secret_scanning.status' enabled
  expect "$api" '.security_and_analysis.secret_scanning_push_protection.status' enabled
  expect "$api" '.security_and_analysis.dependabot_security_updates.status' enabled
  expect "$api/automated-security-fixes" '.enabled' true
  expect "$api/private-vulnerability-reporting" '.enabled' true
  expect "$api/code-scanning/default-setup" '.state' configured
  expect "$api/immutable-releases" '.enabled' true
  expect "$api/actions/permissions" '.sha_pinning_required' true
  expect "$api/actions/permissions/workflow" '[.default_workflow_permissions, .can_approve_pull_request_reviews] | @csv' '"read",false'
  expect "$api/actions/permissions/fork-pr-contributor-approval" '.approval_policy' all_external_contributors
  expect "$api/rulesets" '[.[] | select(.enforcement == "active") | .name] | sort | join(",")' 'main,tags'
  if gh api "$api/vulnerability-alerts" --silent 2>/dev/null; then
    echo "ok        $api/vulnerability-alerts"
  else
    echo "DIFFERENT $api/vulnerability-alerts: expected enabled"
    failures=$((failures + 1))
  fi
}

case $mode in
  dry-run) apply ;;
  check) check ;;
  apply) apply; check ;;
esac

if [ "$failures" -gt 0 ]; then
  echo "$failures setting(s) differ." >&2
  exit 1
fi
