#!/bin/sh

# exit fast if 1pass CLI is already in $PATH
type op >/dev/null 2>&1 && exit

case "$(uname -s)" in
Darwin)
    # commands to install password-manager-binary on Darwin
    echo "installing darwin"
    ;;
Linux)
    # commands to install password-manager-binary on Linux
    echo "installing linux"
    ;;
*)
    echo "unsupported OS"
    exit 1
    ;;
esac
