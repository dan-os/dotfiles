#!/usr/bin/env bash

abort() {
  printf "%s\n" "$@" >&2
  exit 1
}

tty_escape() { printf "\033[%sm" "$1"; }
tty_mkbold() { tty_escape "1;$1"; }
tty_underline="$(tty_escape "4;39")"
tty_blue="$(tty_mkbold 34)"
tty_red="$(tty_mkbold 31)"
tty_bold="$(tty_mkbold 39)"
tty_reset="$(tty_escape 0)"

shell_join() {
  if [[ $# -gt 0 ]]; then
    printf "%s" "$1"
    shift
    for arg in "$@"; do 
      printf " %s" "${arg// /\ }";
    done
  fi
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
  "$@" || abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
}

has() {
  command -v "$1" 1>/dev/null 2>&1
}
