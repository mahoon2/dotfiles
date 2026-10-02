#!/usr/bin/env sh
# Expose the chezmoi-managed Claude instructions to Codex via symlinks.
#
# Runs after every `chezmoi apply` / `chezmoi update` so that newly added
# ~/.claude/rules/*.md files are linked too. Existing files or symlinks that
# point elsewhere are left untouched and reported instead of overwritten.
# ~/.codex/rules is shared with Codex's own *.rules files, so only individual
# Markdown files are linked rather than the whole directory.

set -eu

CLAUDE_DIR="$HOME/.claude"
CODEX_DIR="$HOME/.codex"

log() { printf '[link-codex-instructions] %s\n' "$*"; }

ensure_link() {
  src=$1
  dest=$2

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    return
  elif [ -e "$dest" ] || [ -L "$dest" ]; then
    log "skipping $dest: already exists and is not a symlink to $src"
  else
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    log "linked $dest -> $src"
  fi
}

ensure_link "$CLAUDE_DIR/CLAUDE.md" "$CODEX_DIR/AGENTS.md"

for src in "$CLAUDE_DIR"/rules/*.md; do
  [ -f "$src" ] || continue
  ensure_link "$src" "$CODEX_DIR/rules/$(basename "$src")"
done
