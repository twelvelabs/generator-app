#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

stylist check

# Lint PR title if present.
if [[ "${PULL_REQUEST_TITLE:-}" != "" ]]; then
    if ! echo "${PULL_REQUEST_TITLE:-}" | convco check --from-stdin; then
        echo
        echo "[lint] 🔴 Pull request title does not follow conventional commit format: https://www.conventionalcommits.org/"
        echo
        exit 1
    fi
fi

echo "[lint] ✅"
