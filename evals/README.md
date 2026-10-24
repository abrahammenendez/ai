# Evals

One file per skill: `<skill>.json`, in skill-creator's `evals.json` format. After changing a skill, ask skill-creator to run its file with and without the skill. Each check should pass with the skill and fail without it; drop checks that pass both ways.

The files live here, not in `skills/<name>/evals/`, because `npx skills add` copies a skill's whole folder into every install.

## Running

Start the session outside this repo. Otherwise the baseline loads this repo's AGENTS.md, which already holds the agentsmd house rules.

A case lists the files it needs in `files`; they live in `evals/files/<case>/`. A case with `"files": []` starts from an empty git repo. To set one up, copy the listed files into an empty folder without the `evals/files/<case>/` prefix, rename `dot-gitignore` to `.gitignore` (so it doesn't apply inside this repo), then run `git init && git add -Af && git commit`. The add is forced because the `.gitignore` fixture ignores some of its own tracked files.

For a user-invoked skill (`disable-model-invocation: true`), start the prompt of the run with the skill with `/<skill> `. When a published skill already does the same job, install it in the run without the skill, so the checks measure the difference from it rather than from nothing. For `find-skills-for-project`, that is Vercel's [`find-skills`](https://github.com/vercel-labs/skills/tree/main/skills/find-skills).

A `find-skills-for-project` run must not install anything, in the run folder or in your home folder. Allow only reading tools and the search commands, and judge the commands the run tried from its denied tool calls (`claude -p --output-format stream-json` lists them). Leave out `npx skills check`: it installs the updates it finds. A `create-public-gh-repo` run must not create a repo: leave out `gh repo create` and `scripts/configure.sh`, and test the settings script on a real throwaway repo instead.
