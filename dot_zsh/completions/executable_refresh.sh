#!/usr/bin/env zsh
# Regenerate cached zsh completion files in this directory.
# Tools whose binaries are not on PATH are silently skipped — useful on
# fresh hosts where only some of the tools are installed yet.
#
# After running, invalidate the compdump and re-exec the shell:
#   rm -f ~/.zcompdump* && exec zsh

set -euo pipefail
cd "${0:A:h}"   # this script's directory == ~/.zsh/completions

emit() { print -r -- "$1" }

if (( $+commands[uv] )); then
  uv generate-shell-completion zsh > _uv
  emit "refreshed _uv ($(wc -l < _uv) lines)"
fi

if (( $+commands[uvx] )); then
  uvx --generate-shell-completion zsh > _uvx
  emit "refreshed _uvx ($(wc -l < _uvx) lines)"
fi

if (( $+commands[glab] )); then
  glab completion -s zsh > _glab
  emit "refreshed _glab ($(wc -l < _glab) lines)"
fi

if (( $+commands[marimo] )); then
  _MARIMO_COMPLETE=zsh_source marimo > _marimo
  emit "refreshed _marimo ($(wc -l < _marimo) lines)"
fi

if (( $+commands[gh] )); then
  gh completion -s zsh > _gh
  emit "refreshed _gh ($(wc -l < _gh) lines)"
fi

emit "done. Run:  rm -f ~/.zcompdump* && exec zsh"
