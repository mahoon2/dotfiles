#!/usr/bin/env sh
# Bootstrap script: install TPM (Tmux Plugin Manager) on a fresh host.
#
# Your ~/.tmux.conf ends with `run '~/.tmux/plugins/tpm/tpm'` and lists
# @plugin entries for catppuccin / tmux-cpu / tmux-battery. After this
# script clones TPM, launch tmux and press `prefix + I` (capital I) to
# install the listed plugins into ~/.config/tmux/plugins/.

set -eu

TPM_DIR="$HOME/.tmux/plugins/tpm"

log() { printf '[install-tmux-stack] %s\n' "$*"; }

if [ -d "$TPM_DIR/.git" ]; then
  log "TPM already present at $TPM_DIR — pulling latest"
  git -C "$TPM_DIR" pull --quiet --ff-only || true
else
  log "cloning TPM into $TPM_DIR"
  mkdir -p "$(dirname "$TPM_DIR")"
  git clone --depth=1 --quiet https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

log "done. Next steps:"
log "  1. Open tmux (or run 'tmux source ~/.tmux.conf' in an existing session)"
log "  2. Press 'prefix + I' (capital I) to install the @plugin entries"
log "     listed in ~/.tmux.conf (catppuccin, tmux-cpu, tmux-battery)"
