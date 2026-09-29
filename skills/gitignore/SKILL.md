---
name: gitignore
description: Writes and updates a project's .gitignore from the maintained github/gitignore templates, trimmed to the tools the project actually uses. Use when starting a project, when a repo has no .gitignore, when build output, dependencies or secrets show up in git status, or when asked to create, review, clean up or update a .gitignore.
---

# .gitignore

A good .gitignore lists what this project generates or keeps local, grouped so a reader can see why each line is there. Template dumps of hundreds of lines for tools the project doesn't use hide the few lines that matter. Take patterns from github/gitignore, which GitHub maintains, so nothing important is missed, then keep only what applies.

## Steps

1. Find the stack from the build files: `pom.xml`, `build.gradle(.kts)`, `package.json` and its lockfile, `pyproject.toml`, `go.mod`, `Cargo.toml`, `*.tf`, `Dockerfile` and the like. On an empty project, ask which language, build tool and frameworks it will use.
2. Fetch the templates for the language, the build tool and any framework that has one:

   ```bash
   scripts/fetch-templates.sh --list          # names
   scripts/fetch-templates.sh Java Gradle     # contents
   ```

3. Write the file in groups with a short heading comment each, in this order when they apply: Build output, Dependencies, Environment, Logs, Test output, Generated, Editors, OS, Agents. From each template keep the lines for tools the project uses and drop the rest (a Python project without Django, Sphinx or PyInstaller doesn't need their sections).
4. Add these groups whatever the stack:
   - **Environment**: `.env` and `.env.*`, with `!.env.example` so the documented template stays tracked.
   - **Editors**: `.idea/`, `.vscode/`. **OS**: `.DS_Store`.
   - **Agents**: `.claude/settings.local.json`, `CLAUDE.local.md`, `.claude/worktrees/`.
5. Comment only the lines whose reason isn't obvious, above the line. Every `!` exception gets one, such as why `gradle-wrapper.jar` stays tracked.
6. When a .gitignore already exists, keep its project-specific lines and their comments, and replace the template dumps with the trimmed groups.
7. Check the result:

   ```bash
   git status --short --untracked-files=all   # nothing generated, downloaded or secret left untracked
   git ls-files -ci --exclude-standard        # tracked files the new rules would ignore
   ```

   Report tracked files that are now ignored and let the user decide whether to untrack them; `.gitignore` never removes a file that is already tracked.

Done when `git status` shows no build output, dependencies or secrets, and the user knows about any tracked file the new rules cover.
