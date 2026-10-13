# Evals

One file per skill: `<skill>.json`, in skill-creator's `evals.json` format. After changing a skill, ask skill-creator to run its file with and without the skill. Each check should pass with the skill and fail without it; drop checks that pass both ways.

The files live here, not in `skills/<name>/evals/`, because `npx skills add` copies a skill's whole folder into every install.

## Running

Start the session outside this repo. Otherwise the baseline loads this repo's CLAUDE.md, which already holds the agents-md house rules.

A case lists the files it needs in `files`; they live in `evals/files/<case>/`. A case with `"files": []` starts from an empty git repo. To set one up, copy the listed files into an empty folder without the `evals/files/<case>/` prefix, rename `dot-gitignore` to `.gitignore` (so it doesn't apply inside this repo), then run `git init && git add -Af && git commit`. The add is forced because the `.gitignore` fixture ignores some of its own tracked files.
