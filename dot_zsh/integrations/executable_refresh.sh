#!/usr/bin/env zsh
# Regenerate the static zoxide shell integration in this directory.
# If zoxide is not installed, leave any existing integration untouched.

set -euo pipefail
cd "${0:A:h}"   # this script's directory == ~/.zsh/integrations

(( $+commands[zoxide] )) || exit 0

tmp="$(mktemp "${PWD}/.zoxide.zsh.tmp.XXXXXX")"
trap 'rm -f -- "$tmp"' EXIT HUP INT TERM

command zoxide init zsh >| "$tmp"
if [[ ! -s "$tmp" ]]; then
  print -u2 -r -- "refresh-zoxide: generated integration is empty"
  exit 1
fi
zsh -n "$tmp"
chmod 0644 "$tmp"
mv -f -- "$tmp" zoxide.zsh
trap - EXIT HUP INT TERM

print -r -- "refreshed zoxide.zsh ($(wc -l < zoxide.zsh) lines)"
