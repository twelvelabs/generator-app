#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

stylist check
echo "[lint] ✅"
