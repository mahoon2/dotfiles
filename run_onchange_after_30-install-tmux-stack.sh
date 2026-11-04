#!/usr/bin/env sh
# Install TPM and the @plugin entries in ~/.tmux.conf. Runs after the tool
# scripts so that tmux is already installed.

set -eu

TPM_DIR="$HOME/.tmux/plugins/tpm"
LEGACY_PLUGIN_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins"

log() { printf '[install-tmux-stack] %s\n' "$*"; }

. "$HOME/.zsh/path.sh"

if [ -d "$TPM_DIR/.git" ]; then
  log "updating tpm"
  git -C "$TPM_DIR" pull --quiet --ff-only || true
elif [ -e "$TPM_DIR" ]; then
  log "tpm already present at $TPM_DIR"
else
  log "cloning tpm into $TPM_DIR"
  mkdir -p "$(dirname "$TPM_DIR")"
  git clone --depth=1 --quiet https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

if command -v tmux >/dev/null 2>&1; then
  log "installing tmux plugins"
  "$TPM_DIR/bin/install_plugins" || log "warning: TPM plugin install failed"
else
  log "warning: tmux not found; skipped plugin install"
fi

# Earlier versions of this script cloned Catppuccin and standalone status
# modules here. ~/.tmux.conf no longer loads them, so remove those clones.
for dir in catppuccin/tmux tmux-plugins/tmux-cpu tmux-plugins/tmux-battery; do
  if [ -d "$LEGACY_PLUGIN_DIR/$dir/.git" ]; then
    rm -rf "${LEGACY_PLUGIN_DIR:?}/$dir"
    log "removed unused clone $LEGACY_PLUGIN_DIR/$dir"
  fi
done
rmdir "$LEGACY_PLUGIN_DIR/catppuccin" "$LEGACY_PLUGIN_DIR/tmux-plugins" 2>/dev/null || true
