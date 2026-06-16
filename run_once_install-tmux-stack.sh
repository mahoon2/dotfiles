#!/usr/bin/env sh
# Bootstrap script: install tmux plugins on a fresh host.
#
# Catppuccin recommends manual installation because TPM has repository-name
# conflicts for catppuccin/tmux. This script clones Catppuccin and status
# modules into the exact paths loaded by ~/.tmux.conf, and keeps TPM available
# for the remaining @plugin entries.

set -eu

TPM_DIR="$HOME/.tmux/plugins/tpm"
TMUX_PLUGIN_DIR="${TMUX_PLUGIN_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins}"

log() { printf '[install-tmux-stack] %s\n' "$*"; }

clone_or_pull() {
  url=$1
  dest=$2
  branch=${3:-}

  if [ -d "$dest/.git" ]; then
    log "$(basename "$dest") already present at $dest - pulling latest"
    git -C "$dest" pull --quiet --ff-only || true
  elif [ -e "$dest" ]; then
    log "$(basename "$dest") already present at $dest"
  else
    log "cloning $(basename "$dest") into $dest"
    mkdir -p "$(dirname "$dest")"
    if [ -n "$branch" ]; then
      git clone --branch "$branch" --depth=1 --quiet "$url" "$dest"
    else
      git clone --depth=1 --quiet "$url" "$dest"
    fi
  fi
}

clone_or_pull https://github.com/tmux-plugins/tpm "$TPM_DIR"
clone_or_pull https://github.com/catppuccin/tmux.git "$TMUX_PLUGIN_DIR/catppuccin/tmux" v2.3.0
clone_or_pull https://github.com/tmux-plugins/tmux-cpu "$TMUX_PLUGIN_DIR/tmux-plugins/tmux-cpu"
clone_or_pull https://github.com/tmux-plugins/tmux-battery "$TMUX_PLUGIN_DIR/tmux-plugins/tmux-battery"

log "done. Next steps:"
log "  1. Open tmux (or run 'tmux source ~/.tmux.conf' in an existing session)"
log "  2. Press 'prefix + I' (capital I) to install any TPM @plugin entries"
