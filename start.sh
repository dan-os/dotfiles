#!/usr/bin/env bash

# start.sh
#
# This script can be used to install everything from the git repository using one command.
# To install dotfiles from a local repository, run `install.sh`.
#
# Usage: 
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dan-os/dotfiles/HEAD/start.sh)"

set -u

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

getc() {
  local save_state
  save_state="$(/bin/stty -g)"
  /bin/stty raw -echo
  IFS='' read -r -n 1 -d '' "$@"
  /bin/stty "${save_state}"
}

tty_escape() { printf "\033[%sm" "$1"; }
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  local arg
  printf "%s" "$1"
  shift
  for arg in "$@"
  do
    printf " "
    printf "%s" "${arg// /\ }"
  done
}

chomp() {
  printf "%s" "${1/"$'\n'"/}"
}

ohai() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$(shell_join "$@")"
}

warn() {
  printf "${tty_red}Warning${tty_reset}: %s\n" "$(chomp "$1")" >&2
}

execute() {
  if ! "$@"
  then
    abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
  fi
}

retry() {
  local tries="$1" n="$1" pause=2
  shift
  if ! "$@"
  then
    while [[ $((--n)) -gt 0 ]]
    do
      warn "$(printf "Trying again in %d seconds: %s" "${pause}" "$(shell_join "$@")")"
      sleep "${pause}"
      ((pause *= 2))
      if "$@"
      then
        return
      fi
    done
    abort "$(printf "Failed %d times doing: %s" "${tries}" "$(shell_join "$@")")"
  fi
}

wait_for_user() {
  local c
  echo
  echo "Press ${tty_bold}RETURN${tty_reset}/${tty_bold}ENTER${tty_reset} to continue or any other key to abort:"
  getc c
  # we test for \r and \n because some stuff does \r instead
  if ! [[ "${c}" == $'\r' || "${c}" == $'\n' ]]
  then
    exit 1
  fi
}

cd $HOME || exit 1

################################################################

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_GIT_REMOTE="https://github.com/dan-os/dotfiles"

################################################################

echo
warn "This script will download and install dotfiles from ${DOTFILES_GIT_REMOTE}."
warn "It ${tty_bold}will overwrite${tty_reset} any existing dotfiles and the current machine configuration!"

wait_for_user
echo

ohai "Downloading latest dotfiles..."
(
    mkdir -p "${DOTFILES_DIR}" || return
    cd "${DOTFILES_DIR}" >/dev/null || return

    execute "git" "-c" "init.defaultBranch=main" "init" "--quiet"
    execute "git" "config" "remote.origin.url" "${DOTFILES_GIT_REMOTE}"
    execute "git" "config" "remote.origin.fetch" "+refs/heads/*:refs/remotes/origin/*"
    execute "git" "config" "--bool" "core.autocrlf" "false"
    execute "git" "config" "--bool" "core.symlinks" "true"

    retry 5 "git" "fetch" "--quiet" "--progress" "--force" "origin"
    retry 5 "git" "fetch" "--quiet" "--progress" "--force" "--tags" "origin"
    execute "git" "remote" "set-head" "origin" "--auto" >/dev/null

    LATEST_GIT_TAG="$(git tag --list --sort="-version:refname" | head -n1)"
    if [[ -z "${LATEST_GIT_TAG}" ]] then
      LATEST_GIT_TAG="origin/main"
    fi

    execute "git" "checkout" "--quiet" "--force" "-B" "main" "${LATEST_GIT_TAG}"
) || exit 1

ohai "Installing dotfiles..."
(
  execute "bash" "${DOTFILES_DIR}/install.sh"
) || exit 1

if [[ ":${PATH}:" != *":${DOTFILES_DIR}/bin:"* ]]
then
  warn "${DOTFILES_DIR}/bin is not in your PATH."
fi

ohai "Installation successful!"
echo
