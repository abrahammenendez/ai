#!/usr/bin/env bash
# Prints .gitignore templates from github/gitignore, the collection GitHub
# maintains and uses for its own template picker.
#
#   fetch-templates.sh --list          all template names
#   fetch-templates.sh Java Gradle     the named templates, case-insensitive
#
# Root templates win over Global/ and community/ ones with the same name.
set -euo pipefail

repo="github/gitignore"
raw="https://raw.githubusercontent.com/$repo/main"

paths() {
  curl -fsSL "https://api.github.com/repos/$repo/git/trees/main?recursive=1" |
    grep -oE '"path": ?"[^"]+\.gitignore"' |
    sed -E 's/"path": ?"//; s/"$//' |
    awk '{ print (/^Global\//) ? 1 : (/^community\//) ? 2 : 0, $0 }' |
    sort -n | cut -d' ' -f2-
}

if [ $# -eq 0 ]; then
  echo "usage: $0 --list | <template>..." >&2
  exit 2
fi

all=$(paths)

if [ "$1" = "--list" ]; then
  echo "$all" | sed -E 's#^(.*/)?([^/]+)\.gitignore$#\2#' | sort -uf
  exit 0
fi

status=0
for name in "$@"; do
  path=$(echo "$all" | awk -v n="$name" 'BEGIN { n = tolower(n) ".gitignore" }
    { f = $0; sub(/.*\//, "", f); if (tolower(f) == n) { print; exit } }')
  if [ -z "$path" ]; then
    echo "No template named '$name'. Run with --list to see the names." >&2
    status=1
    continue
  fi
  echo "### $(basename "$path" .gitignore): https://github.com/$repo/blob/main/$path"
  curl -fsSL "$raw/$path"
  echo
done
exit $status
