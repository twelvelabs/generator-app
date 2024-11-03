#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
CURRENT_VERSION=$(convco version --print-prefix)
NEXT_VERSION=$(convco version --print-prefix --bump)

if [[ "${CURRENT_VERSION}" != "v0.0.0" ]]; then
    COMMITS_REF="$CURRENT_VERSION..HEAD"
else
    COMMITS_REF="HEAD"
fi
COMMITS=$(git log --color=always --format=" - %C(yellow)%h%Creset %s" "$COMMITS_REF") # cspell: disable-line

echo ""
echo "Current branch: $CURRENT_BRANCH"
echo -n "Unreleased commits:"
if [[ "$COMMITS" != "" ]]; then
    echo ""
    echo "$COMMITS"
else
    echo " <none>"
fi

echo ""
echo "Versions:"
echo " - Current: $CURRENT_VERSION"
if [[ "$CURRENT_VERSION" != "$NEXT_VERSION" ]]; then
    echo " - Next:    $NEXT_VERSION"
else
    echo " - Next:    <none>"
fi
echo ""
