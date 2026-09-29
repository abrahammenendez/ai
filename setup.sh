#!/usr/bin/env bash
# Installs or removes this repo's Claude Code settings and the skills listed below.
#
#   ./setup.sh install     safe to re-run; also the way to update
#   ./setup.sh uninstall   removes exactly what install added
set -euo pipefail

# Third-party skills installed from mattpocock/skills. This repo's own skills
# are every folder in skills/.
matt_skills=(grill-me grilling handoff teach wait-what writing-for-agents)

repo=$(cd "$(dirname "$0")" && pwd)
own_skills=()
for dir in "$repo"/skills/*/; do own_skills+=("$(basename "$dir")"); done

settings="$HOME/.claude/settings.json"
backup="$settings.before-ai"      # your settings from before the first install
marker="$settings.added-by-ai"    # present when install created settings.json

skills() { npx -y skills@latest "$@"; }

install_settings() {
  mkdir -p "$(dirname "$settings")"
  if [ ! -e "$settings" ]; then
    cp "$repo/claude/settings.json" "$settings"
    touch "$marker"
    echo "Created $settings"
  elif cmp -s "$settings" "$repo/claude/settings.json"; then
    echo "Settings already match."
  else
    diff -u "$settings" "$repo/claude/settings.json" || true
    read -r -p "Replace $settings with the repo version shown above? [y/N] " answer
    if [ "$answer" != y ]; then
      echo "Settings left unchanged."
      return
    fi
    [ -e "$backup" ] || [ -e "$marker" ] || cp "$settings" "$backup"
    cp "$repo/claude/settings.json" "$settings"
    echo "Replaced $settings"
  fi
}

uninstall_settings() {
  if [ -e "$backup" ]; then
    mv "$backup" "$settings"
    echo "Restored your previous $settings"
  elif [ -e "$marker" ]; then
    rm -f "$settings" "$marker"
    echo "Removed $settings"
  fi
}

case "${1:-}" in
  install)
    command -v npx >/dev/null || { echo "Needs Node.js (npx)." >&2; exit 1; }
    install_settings
    # With both agents, npx skills keeps one copy of each skill in
    # ~/.agents/skills, which Codex reads, and links it into ~/.claude/skills.
    # With Claude Code alone it would copy into ~/.claude/skills only.
    skills add "$repo" -g -a claude-code codex -y
    skills add mattpocock/skills -g -a claude-code codex -y -s "${matt_skills[@]}"
    ;;
  uninstall)
    command -v npx >/dev/null || { echo "Needs Node.js (npx)." >&2; exit 1; }
    skills remove -g -y "${own_skills[@]}" "${matt_skills[@]}"
    # Leave no empty npx skills state behind.
    lock="$HOME/.agents/.skill-lock.json"
    if [ -f "$lock" ] && grep -q '"skills": {}' "$lock"; then rm "$lock"; fi
    rmdir "$HOME/.agents/skills" "$HOME/.agents" 2>/dev/null || true
    uninstall_settings
    ;;
  *)
    echo "usage: $0 install|uninstall" >&2
    exit 2
    ;;
esac
