#!/usr/bin/env sh
# Expose the chezmoi-managed Claude instructions to Codex.
#
# Codex reads ~/.codex/AGENTS.md, so link it to ~/.claude/CLAUDE.md. Rule and
# guide files need no links because CLAUDE.md points to them by absolute path.
# An existing file or symlink that points elsewhere is left untouched and
# reported instead of overwritten. Runs after every `chezmoi apply`.

set -eu

src="$HOME/.claude/CLAUDE.md"
dest="$HOME/.codex/AGENTS.md"

log() { printf '[link-codex-instructions] %s\n' "$*"; }

if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
  exit 0
elif [ -e "$dest" ] || [ -L "$dest" ]; then
  log "skipping $dest: already exists and is not a symlink to $src"
else
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  log "linked $dest -> $src"
fi
