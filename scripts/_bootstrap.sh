#!/bin/sh

#
# @dan-os/dotfiles
# easy installation script
#
# Run the following one-liner to configure a new machine:
# => /bin/bash -c "$(curl -fsSL go.dan.sm/dotfiles)"
#

# exit on error
set -e

BIN_DIR="$HOME/.local/bin"
CHEZMOI="$BIN_DIR/chezmoi"

# prerequisites
case "$(uname -s)" in
Darwin)
    xcode-select -p &>/dev/null || xcode-select --install
    ;;
Linux)
    ;;
*)
    echo "[Warning] unknown OS"
    exit 1
    ;;
esac

# install chezmoi
if [ ! "$(command -v chezmoi)" ]; then
    if [ "$(command -v curl)" ]; then
        sh -c "$(curl -fsSL https://get.chezmoi.io)" -- -b "$BIN_DIR"
    elif [ "$(command -v wget)" ]; then
        sh -c "$(wget -qO- https://get.chezmoi.io)" -- -b "$BIN_DIR"
    else
        echo "[ERROR] CURL or WGET must be installed first!" >&2
        exit 1
    fi
else
    CHEZMOI=chezmoi
fi

# apply github@dan-os/dotfiles with chezmoi
exec "$CHEZMOI" init --apply dan-os/dotfiles
