#!/usr/bin/env zsh
# Bootstrap script: install Oh My Zsh and the three external plugin/theme
# repositories that ~/.zshrc depends on. Re-runs only when this file's hash
# changes (chezmoi run_once_* semantics).

set -euo pipefail

OMZ_DIR="${ZSH:-$HOME/.oh-my-zsh}"
CUSTOM="${ZSH_CUSTOM:-$OMZ_DIR/custom}"

log() { print -r -- "[install-zsh-stack] $*" }

# --- 1. Oh My Zsh ---
if [[ ! -d "$OMZ_DIR" ]]; then
  log "installing Oh My Zsh"
  RUNZSH=no KEEP_ZSHRC=yes sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "Oh My Zsh already present at $OMZ_DIR"
fi

# --- 2. External plugins & themes ---
clone_or_pull() {
  local url=$1 dest=$2
  if [[ -d "$dest/.git" ]]; then
    log "updating $(basename $dest)"
    git -C "$dest" pull --quiet --ff-only || true
  else
    log "cloning $(basename $dest)"
    git clone --depth=1 --quiet "$url" "$dest"
  fi
}

clone_or_pull https://github.com/zsh-users/zsh-autosuggestions.git \
  "$CUSTOM/plugins/zsh-autosuggestions"
clone_or_pull https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  "$CUSTOM/plugins/fast-syntax-highlighting"
clone_or_pull https://github.com/romkatv/powerlevel10k.git \
  "$CUSTOM/themes/powerlevel10k"

# --- 3. Cached completions ---
if [[ -x "$HOME/.zsh/completions/refresh.sh" ]]; then
  log "refreshing cached completions"
  "$HOME/.zsh/completions/refresh.sh" || true
fi

# --- 4. Invalidate stale compdumps so the new fpath/plugins are indexed ---
rm -f "$HOME"/.zcompdump* 2>/dev/null || true

log "done. Open a new shell or run 'exec zsh'."
log "Reminder: secrets and host-local paths live in ~/.zshrc.local (not managed by chezmoi)."
