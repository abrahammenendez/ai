---
name: create-public-gh-repo
description: Creates a new open-source GitHub repo from the current empty folder, with its license, settings and templates in place.
disable-model-invocation: true
---

# Create a public GitHub repo

Running this skill is the user's go-ahead to publish, so ask only for what you can't work out. The two scripts hold every fixed choice: `scripts/scaffold.sh` writes the files that are the same in every repo, and `scripts/configure.sh` applies and checks the GitHub settings. Paths to the scripts are relative to this skill's folder.

## Steps

1. **Check the folder.** It must hold no project files: only an empty git repo, `.claude/` or editor folders such as `.idea/` may be there, and they stay out of the commit. Otherwise stop and say this skill starts new projects only.

2. **Ask for the description.** The owner is the active `gh` account (`gh api user --jq .login`) and the repo name is the folder's name. In one message say "Creating `<owner>/<repo>` as a public repo" and ask for a one-sentence description. Skip the question when the user already gave one.

3. **Write the files.** Answer the other skills' questions from here, so the user gets no more of them.
   1. Run `git init -b main` unless the folder is already a git repo, then `scripts/scaffold.sh <owner> <repo>`.
   2. Use the `gitignore` skill. No stack is chosen yet.
   3. Use the `readme` skill with the name, the description, the status "Early development, not usable yet", and the license `AGPL-3.0-or-later`.
   4. Use the `agentsmd` skill with the name and the description, and put these two lines in its **Rules**:
      - CI checks go in the `Verify` job of `.github/workflows/verify.yaml`, which the `main` ruleset requires. Pin every action to a full commit SHA: the repo rejects tags.
      - When you add a build file, add its ecosystem to `.github/dependabot.yml`.

   Done when `LICENSE`, `README.md`, `AGENTS.md`, `.gitignore` and the `.github` folder exist.

4. **Publish.** The first commit must reach `main` before step 5, because the `main` ruleset blocks direct pushes.

   ```bash
   git add -A
   git commit -m "chore: initial commit"
   gh repo create <owner>/<repo> --public --description "<description>" --source . --remote origin --push
   ```

5. **Configure.** Run `scripts/configure.sh <owner>/<repo>`. It applies the settings, reads every one back, and prints `DIFFERENT` for any that GitHub didn't take. If one differs, run it once more; if it still differs, report it.

6. **Report.**
   - The repo's URL.
   - Any setting that differs.
   - Two steps no API covers: upload a social preview image (**Settings > General > Social preview**), and add topics once the stack is known.
   - How merging works now: the user's own pull requests merge with the bypass checkbox; Dependabot's merge once the user approves them.

Done when the repo is public, `scripts/configure.sh --check <owner>/<repo>` reports no differences, and the user has the URL.
