#!/usr/bin/env bash
# Writes the files every new public repo starts with into the current folder:
# LICENSE (the AGPL-3.0 text, from GitHub's license API) and the .github
# folder from ../assets/repo, with {{owner}} and {{repo}} filled in.
#
#   scaffold.sh <owner> <repo>
#
# Refuses to overwrite a file that already exists.
set -euo pipefail

owner=${1:?usage: scaffold.sh <owner> <repo>}
repo=${2:?usage: scaffold.sh <owner> <repo>}
assets="$(cd "$(dirname "$0")/../assets/repo" && pwd)"

(cd "$assets" && find . -type f) | sort | while read -r f; do
  dest=${f#./}
  if [ -e "$dest" ]; then
    echo "$dest already exists; left as it is" >&2
    continue
  fi
  mkdir -p "$(dirname "$dest")"
  sed -e "s/{{owner}}/$owner/g" -e "s/{{repo}}/$repo/g" "$assets/$f" > "$dest"
  echo "wrote $dest"
done

if [ -e LICENSE ]; then
  echo "LICENSE already exists; left as it is" >&2
else
  gh api licenses/agpl-3.0 --jq .body > LICENSE
  echo "wrote LICENSE"
fi
