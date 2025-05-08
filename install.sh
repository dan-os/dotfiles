#!/usr/bin/env bash

set -euo pipefail

export ROOT_DIR="$(git rev-parse --show-toplevel)"
source $ROOT_DIR/lib/common.sh

printenv

# get sudo
ohai "Acquiring sudo..."
(
  if sudo -v; then
    trap 'sudo -k' EXIT
  else
    abort "sudo is required."
  fi
)

ohai "Installing devbox..."
(
  curl -fsSL https://get.jetify.com/devbox | bash
) || exit 1

# install devbox
# devbox
# export DEVBOX_USE_VERSION=0.8.0
# curl -fsSL https://get.jetify.com/devbox | bash
