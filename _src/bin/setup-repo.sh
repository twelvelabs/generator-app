#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

# Ensure local repo.
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    if gum confirm "Create local git repo?"; then
        echo "Creating local repo."
        git init
        git add .
        git commit -m "feat: initial commit"
    else
        exit 0
    fi
fi

# Ensure remote repo.
if ! gh repo view --json "id" &>/dev/null; then
    if gum confirm "Create remote git repo?"; then
        echo "Creating remote repo."
        gh repo create

        sleep 2

        echo "Configuring remote repo."
        gh repo-config apply

        echo "Setting origin HEAD."
        git remote set-head origin --auto
    else
        exit 0
    fi
fi

# Cleanup this script now that everything has been setup.
rm -f bin/setup-repo.sh
