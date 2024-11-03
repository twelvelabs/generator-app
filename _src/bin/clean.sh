#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

rm -Rf build
rm -Rf dist
rm -f .cspellcache
rm -f coverage.out

echo "[clean] ✅"
