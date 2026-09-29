---
name: agents-md
description: Creates and maintains a project's AGENTS.md and its identical copy CLAUDE.md, the instruction files coding agents load in every session. Use when starting a new project, when a repo has no AGENTS.md or only a CLAUDE.md, when adding a rule or command the agents should remember, when an agent keeps making the same mistake, or when asked to review, clean up, shorten or sync these files.
---

# AGENTS.md

AGENTS.md is loaded into every session, so each line costs attention on every task. It earns its place only if an agent would get something wrong or waste time without it, and could not find it by reading the repo. Overviews, directory tours, stack lists and anything a linter or config file already enforces fail that test: studies of these files found they add cost without improving results, while specific, non-obvious instructions do get followed.

Codex reads AGENTS.md. Claude Code reads CLAUDE.md. Keep both files byte-for-byte identical and write both on every change.

## Create

Use this for a new project, or a repo without AGENTS.md.

1. Copy [assets/AGENTS.md](assets/AGENTS.md).
2. Fill in the name and the one or two sentence description. On an empty project, ask the user for them. On an existing repo, take them from README.md and confirm.
3. If the repo already has a CLAUDE.md or other agent instructions, carry over only the lines that pass the test above, sorted into the template's sections (see Edit). List what you left out and why, so the user can object.
4. On an existing repo, fill **Commands** with the commands the build files, scripts and CI actually define, narrowest first. Run the cheap ones to confirm they work.
5. Keep the section comments. They guide whoever adds the next line, and Claude Code strips HTML comments before loading the file.
6. Write AGENTS.md and an identical CLAUDE.md.

Done when both files exist, are identical, and every command and path in them exists in the repo.

## Edit

Use this to add, remove or rewrite lines, or to clean up an existing file.

- **Add** a line when there is evidence: an agent got something wrong, a command turned out to be non-obvious, a gotcha cost time. Put it in the section it belongs to and write it in that section's shape:
  - **Commands**: the exact command with its flags, plus what it covers when that isn't obvious (for example that the default test run skips e2e).
  - **Rules**: a prohibition names the action, the reason and the alternative. A generated file names its source and the command that rebuilds it. A changing fact (versions, ports, lists) points to the file that owns it instead of copying the value.
  - **How we work**: team conventions for how work is done and written, not facts about the code.
- **Remove** lines that are stale, duplicate the README or config, or state what the agent does anyway.
- **Move** long material that is useful to humans but not needed in every session (architecture narratives, roadmaps, product descriptions) to README.md or a file under `docs/`, and leave a one-line pointer saying when to read it. Ask before moving large sections the user wrote.
- **Sync house rules** when asked: compare **How we work** with the template's and offer the differences. Keep project-specific edits the user made on purpose.

Write each line so it can be checked: "Run `./gradlew test --tests <Class>` for one class" rather than "test your changes". State what to do; when a line has to forbid something, give the alternative in the same line. One rule per bullet.

Show the user the diff before writing when you remove or move anything. Done when both files are identical and each line passes the test at the top.
