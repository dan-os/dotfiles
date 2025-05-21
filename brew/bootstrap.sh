#!/bin/sh

if test ! $(which brew); then
  if test "$(uname)" = "Darwin"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

exit 0
