# ai

Most of my personal AI setup: my own skills, Claude Code settings, and the third-party skills and MCPs I use in some projects.

## Setup

Needs Node.js, for `npx`.

```bash
./setup.sh install
```

This does two things:

- Copies [claude/settings.json](claude/settings.json) to `~/.claude/settings.json`. When your file differs, it shows the difference and asks first. Your original is kept as `~/.claude/settings.json.before-ai`.
- Installs the skills below with [skills](https://github.com/vercel-labs/skills). Each skill is kept once in `~/.agents/skills`, which Codex reads, and linked into `~/.claude/skills` for Claude Code.

To update, run `git pull && ./setup.sh install`. To undo, run `./setup.sh uninstall`: it removes these skills and restores your original settings.

## Skills

Mine, in [skills/](skills):

| Skill | Use it to |
|---|---|
| `agents-md` | Create and maintain a project's AGENTS.md and its identical copy CLAUDE.md |
| `readme` | Write and update a README.md |
| `gitignore` | Write and update a .gitignore from the [github/gitignore](https://github.com/github/gitignore) templates |

From [mattpocock/skills](https://github.com/mattpocock/skills):

| Skill | Use it to |
|---|---|
| `grill-me` | Get interviewed about a plan until every decision is made. Uses `grilling` |
| `handoff` | Write a handoff note so another session or agent can continue the work |
| `teach` | Learn a topic over several sessions |
| `wait-what` | Get the last message explained again in plain words |
| `writing-for-agents` | Write skills and AGENTS.md files that agents follow |

Skills for a specific technology go in the project that uses it, not here. [CATALOG.md](CATALOG.md) lists the skills, plugins and MCP servers worth adding.

## MCP servers

`setup.sh` installs no MCP servers. Most of the ones I use are connectors on my claude.ai account. Claude Code gets them in every project when you sign in with a claude.ai account, and loads their tools only when a task needs them. Codex doesn't get them.

The last two rows come from the Claude desktop app, so only its sessions get them. Claude in Chrome needs the Claude extension in Chrome. Control Chrome is a desktop extension from Anthropic.

In the desktop app, the Connectors submenu of the prompt box's + menu turns a connector on or off. The change applies to the current session and becomes the default for new ones. For terminal and IDE sessions, set `"disableClaudeAiConnectors": true` in settings to turn off all claude.ai connectors. That setting doesn't reach the desktop app. See [how connectors reach Claude Code](https://code.claude.com/docs/en/mcp#how-connectors-reach-claude-code).

| Connector | Use it to |
|---|---|
| Claude Docs | Create and edit docs on claude.ai |
| Figma | Read designs and write to the canvas |
| Linear | Read and update issues and projects |
| Notion | Read and write Notion pages and databases |
| Sentry | Search errors, issues, traces and logs |
| Vercel | Check deployments, logs and projects |
| Cloudflare | Call the Cloudflare API and search its docs |
| Microsoft Learn | Search Microsoft and Azure docs |
| Superlogical Rex | Search the Rex beta's feedback, changelog and docs |
| Gmail, Google Calendar | Read and draft mail; read and change events |
| Google Drive, Docs, Sheets, Slides | Read and edit files in Google Drive |
| Spotify | Search music and manage the library |
| Claude in Chrome | Use my own Chrome, with my sign-ins |
| Control Chrome | Open, read and switch tabs in Chrome |

## Settings

- Claude Code: [claude/settings.json](claude/settings.json), which `setup.sh` installs.
- Codex: not kept here, because the ChatGPT app writes its own config file.

## License

[MIT](LICENSE)
