#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

echo "Ensuring dependencies."

if ! command -v "brew" >/dev/null 2>&1; then
    echo "Unable to locate Homebrew!"
    echo "Please follow the instructions at: https://brew.sh"
    exit 1
fi
if ! command -v "depctl" >/dev/null 2>&1; then
    brew install twelvelabs/tap/depctl
fi

depctl up

if [[ "${CI:-}" == "true" ]]; then
    depctl up ci
else
    depctl up local

    if command -v "code" >/dev/null 2>&1; then
        echo "Ensuring VS Code extensions."
        installed="$(code --list-extensions)"
        recommended="$(jq -r '.recommendations[]' .vscode/extensions.json)"
        for extension in $recommended; do
            if echo "${installed}" | grep -i -q "${extension}"; then
                echo "✓ Found extension: ${extension}"
            else
                echo "• Installing extension: ${extension}"
                code --install-extension "${extension}"
            fi
        done
    else
        echo ""
        echo "VS Code CLI not found!"
        echo "To ensure VS Code extensions, open the command palette (Shift+Cmd+P) and run:"
        echo ""
        echo "  Install code command in PATH"
        echo ""
        echo "Then re-run this task."
        echo ""
    fi

    if [[ -f bin/setup-repo.sh ]]; then
        bin/setup-repo.sh
    fi

    if [[ -d .git ]]; then
        echo "Updating .git/hooks."
        mkdir -p .git/hooks
        rm -f .git/hooks/*.sample
        cp -f bin/githooks/* .git/hooks/
        chmod +x .git/hooks/*
    fi
fi

echo "[setup] ✅"
