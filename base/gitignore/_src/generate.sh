#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

languages=$(yq '.values[] | select(.key == "Languages") | .options[]' ../generator.yaml)
for key in $languages; do
    echo "[generate] Fetching ${key}"

    filename="${key}.gitignore"
    # The files in the GitHub repo are title-cased.
    # Note: Using awk because every other solution requires GNU-based tools
    #       that don't (and never will) ship w/ macOS.
    title=$(echo "${key}" | awk '{$1=toupper(substr($1,0,1))substr($1,2)}1')

    echo "# Source: https://github.com/github/gitignore/blob/main/${title}.gitignore" >"${filename}"
    {
        echo ""
        curl -fsSL "https://raw.githubusercontent.com/github/gitignore/main/${title}.gitignore"
        echo ""
    } >>"${filename}"
done
