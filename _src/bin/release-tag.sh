#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

source "${BASH_SOURCE%/*}/release-status.sh"

CURRENT_COMMIT_MSG=$(git log -1 --pretty=format:"%s")
if [[ $CURRENT_COMMIT_MSG =~ ^chore\(release\): ]]; then
    echo "Ignoring release commit."
    exit 0
fi

if [[ "$CURRENT_VERSION" == "$NEXT_VERSION" ]]; then
    echo "Nothing to tag."
    exit 0
fi

if [[ "${CI:-}" != "true" ]]; then
    # When running locally, prompt before creating the tag (Safety First™).
    if ! gum confirm --default=false "Create and push tag $NEXT_VERSION"; then
        echo "Aborting."
        exit 0
    fi
fi

# Regenerate the changelog.
convco changelog --unreleased="${NEXT_VERSION}" >CHANGELOG.md
git add CHANGELOG.md

# Push a release commit.
if [[ $(git status --porcelain 2>/dev/null) != "" ]]; then
    git commit --gpg-sign --message "chore(release): $NEXT_VERSION"
    git push origin main
fi

# Tag to trigger the release workflow.
git tag \
    --sign "$NEXT_VERSION" \
    --message "$NEXT_VERSION"
git push origin --tags

echo "[release-tag] ✅"
