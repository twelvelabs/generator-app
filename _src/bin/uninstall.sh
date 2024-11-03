#!/usr/bin/env bash
set -o errexit -o errtrace -o nounset -o pipefail

source "${BASH_SOURCE%/*}/build.sh"

rm -fv "${BIN_INSTALL_PATH}"
rm -fv "${CMP_INSTALL_PATH}"
rm -fv "${MAN_INSTALL_PATH}"

echo "[uninstall] ✅"
