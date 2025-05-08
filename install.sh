#!/usr/bin/env bash

set -euo pipefail

export ROOT_DIR="$(git rev-parse --show-toplevel)"
source $ROOT_DIR/lib/common.sh

printenv

ohai "Acquiring sudo..."
(
  execute "sudo" "-v"
  trap 'sudo -k' EXIT
) || exit 1

ohai "Installing devbox..."
(
  curl -fsSL https://get.jetify.com/devbox | bash
  DEVBOX_VERSION=$(devbox version)
  echo "Installed devbox version: ${DEVBOX_VERSION}"
) || exit 1

# install devbox
# devbox
# export DEVBOX_USE_VERSION=0.8.0
# curl -fsSL https://get.jetify.com/devbox | bash
