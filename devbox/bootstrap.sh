#!/bin/sh

if test ! $(which devbox); then
  curl -fsSL https://get.jetify.com/devbox | bash
  DEVBOX_VERSION=$(devbox version)
  echo "Installed devbox version: ${DEVBOX_VERSION}"
fi

exit 0
