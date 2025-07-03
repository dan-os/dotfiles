#!/bin/sh

# exit on error
set -e

BIN_DIR="$HOME/.local/bin"
CHEZMOI="$BIN_DIR/chezmoi"

# install chezmoi
if [ ! "$(command -v chezmoi)" ]; then
    if [ "$(command -v curl)" ]; then
        sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$BIN_DIR"
    elif [ "$(command -v wget)" ]; then
        sh -c "$(wget -qO- https://get.chezmoi.io)" -- -b "$BIN_DIR"
    else
        echo "CURL or WGET must be installed first!" >&2
        exit 1
    fi
else
    CHEZMOI=chezmoi
fi

# apply github@dan-os/dotfiles.git
exec "$CHEZMOI" init --apply dan-os/dotfiles
