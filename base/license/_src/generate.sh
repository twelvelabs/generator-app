#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

# Updates:
# - The license templates in _src
# - The license options in ../generator.yaml
# NOTE: **This script must be run from the _src directory**.

rm -f licenses.yaml
touch licenses.yaml

# Grab all commonly used licenses from GitHub.
# See:
# - https://docs.github.com/en/rest/licenses?apiVersion=2022-11-28#get-all-commonly-used-licenses
# - https://docs.github.com/en/rest/licenses?apiVersion=2022-11-28#get-a-license
for license in $(gh api /licenses --jq .[].key); do
    echo "[generate] Fetching ${license}"

    # Fetch and replace '[]' placeholders w/ text/template ones.
    # See: https://github.com/github/choosealicense.com#auto-populated-fields
    gh api "/licenses/${license}" --jq .body |
        sed 's/\[year\]/{{ .CopyrightYear }}/' |
        sed 's/\[fullname\]/{{ .CopyrightName }}/' >"${license}.txt"

    echo "- ${license}" >>"licenses.yaml"
done

# Unfortunately there doesn't appear to be a way
# to get `yq` to preserve whitespace :disappointed:
echo "[generate] Updating generator.yaml"
yq -i '(.values | filter(.key == "License") | .[]).options = load("licenses.yaml")' ../generator.yaml
