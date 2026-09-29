# ai

My setup for Claude Code and Codex: Claude Code settings, my own skills, and the third-party skills I use in some projects.

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

Skills for a specific technology go in the project that uses it, not here. [CATALOG.md](CATALOG.md) lists the ones worth adding.

## Settings

- `model` and `effortLevel` set the defaults for new sessions. `opus` always means the latest Opus. In the Claude app, the model and effort you pick in the prompt box win over these.
- `attribution` leaves no Claude trailer in commits or pull requests.
- The notification and workflow keys turn on/off features that are on/off by default.

Codex settings aren't kept here: the ChatGPT app writes its own config file.

## License

[MIT](LICENSE)
