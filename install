#!/usr/bin/env bash

set -euo pipefail

export ROOT_DIR="$(git rev-parse --show-toplevel)"
source $ROOT_DIR/lib/common.sh

# acquire sudo
execute "sudo" "-v"
trap 'sudo -k' EXIT

for src in $(find -H "$DOTFILES_DIR" -maxdepth 2 -name 'bootstrap.sh' -not -path '*.git*'); do
  ohai "Installing $src"
  (
    execute "bash" "$src"
  ) || exit 1
done

# ohai "Installing devbox..."
# (
#   curl -fsSL https://get.jetify.com/devbox | bash
#   DEVBOX_VERSION=$(devbox version)
#   echo "Installed devbox version: ${DEVBOX_VERSION}"
# ) || exit 1
