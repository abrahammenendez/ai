---
name: readme
description: Writes and updates a project's README.md so a newcomer learns what the project is, whether it works yet, and how to run it. Use when starting a project, when a README is missing, thin or out of date, or when asked to write, rewrite, restructure, shorten or update any part of a README.
---

# README

The reader just landed on the repo: a developer, a reviewer, or the author months later. They need three answers fast: what is this, can I use it, how do I run it. Every section after that must earn its place with real content.

## Sections

Use this order and include a section only when the project has real content for it. A new project's README is often just the first three items.

1. `# Name` and one sentence on what it does and for whom.
2. Status, when it isn't ready for use: one line, such as "Early development, not usable yet."
3. Why it exists, in a short paragraph, when that isn't obvious from the sentence above.
4. **Getting started**: prerequisites, then the exact commands to install and run it.
5. **Usage**: the main ways to use it, each with one real example.
6. **Architecture**, for systems with more than one component: a Mermaid diagram of the components and how data flows between them, with a few sentences on the main decisions. Link to `docs/` for more.
7. **Development**: how to run the tests and checks.
8. **License**: one line naming it and linking the LICENSE file, when one exists.

Leave out sections that would be empty or generic: badges that carry no information, a table of contents under about 100 lines, Contributing or Code of Conduct when the repo has no such files, FAQ, acknowledgements, feature lists that restate the description.

## Rules

- Take every command, path, version, port, and name from the repo, and run the cheap commands to confirm them. When something can't be confirmed, ask or leave it out; an invented detail is worse than a missing one.
- Point to the file that owns a changing fact instead of copying it: "Node version: see `.nvmrc`", "Environment variables: see `.env.example`".
- When updating, keep the existing facts that are still true and the author's own explanations. Fix or remove what the code contradicts and list those removals for the user.
- Match length to the project. A small tool fits on one screen.
- Write plainly: short sentences, headings that name what follows, no marketing adjectives, no emoji.

Done when each section has real content and every command and path in it exists in the repo.
