#!/usr/bin/env zsh
# Bootstrap script: ensure the vendored zsh plugin/theme directories that
# ~/.zshrc loads are present. Re-runs only when this file's hash changes
# (chezmoi run_once_* semantics).

set -euo pipefail

ZSH_VENDOR="${ZSH_VENDOR:-$HOME/.zsh/vendor}"

log() { print -r -- "[install-zsh-stack] $*" }

clone_or_pull() {
  local url=$1 dest=$2
  if [[ -d "$dest/.git" ]]; then
    log "updating $(basename $dest)"
    git -C "$dest" pull --quiet --ff-only || true
  elif [[ -e "$dest" ]]; then
    log "$(basename $dest) already present at $dest"
  else
    log "cloning $(basename $dest)"
    mkdir -p -- "${dest:h}"
    git clone --depth=1 --quiet "$url" "$dest"
  fi
}

clone_or_pull https://github.com/zsh-users/zsh-autosuggestions.git \
  "$ZSH_VENDOR/plugins/zsh-autosuggestions"
clone_or_pull https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  "$ZSH_VENDOR/plugins/fast-syntax-highlighting"
clone_or_pull https://github.com/Aloxaf/fzf-tab.git \
  "$ZSH_VENDOR/plugins/fzf-tab"
clone_or_pull https://github.com/romkatv/powerlevel10k.git \
  "$ZSH_VENDOR/themes/powerlevel10k"

# The small OMZ subset used by ~/.zshrc is vendored by chezmoi. Do not install
# the OMZ framework or clone ~/.oh-my-zsh here.
if [[ ! -r "$ZSH_VENDOR/oh-my-zsh/plugins/tmux/tmux.plugin.zsh" ]]; then
  log "warning: vendored OMZ plugin subset is missing under $ZSH_VENDOR/oh-my-zsh"
fi

# --- Cached completions ---
if [[ -x "$HOME/.zsh/completions/refresh.sh" ]]; then
  log "refreshing cached completions"
  "$HOME/.zsh/completions/refresh.sh" || true
fi

# Invalidate stale compdumps so the new fpath/plugins are indexed.
rm -f "$HOME"/.zcompdump* 2>/dev/null || true

log "done. Open a new shell or run 'exec zsh'."
log "Reminder: secrets and host-local paths live in ~/.zshrc.local (not managed by chezmoi)."
