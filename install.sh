#!/usr/bin/env bash

# helpers
source lib/common.sh

printenv

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
