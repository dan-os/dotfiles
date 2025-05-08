#!/usr/bin/env bash

export ROOT_DIR="$(git rev-parse --show-toplevel)"
source $ROOT_DIR/lib/common.sh

printenv

# get sudo
ohai "sudo is required..."
(
  if sudo -v; then
    trap 'sudo -k' EXIT
  fi
) || exit 1

ohai "Bootstrapping..."
(
  echo "doing something..."
) || exit 1

ohai "Installing devbox..."
(
  curl -fsSL https://get.jetify.com/devbox | bash
)

# install devbox
# devbox
# export DEVBOX_USE_VERSION=0.8.0
# curl -fsSL https://get.jetify.com/devbox | bash
