#!/usr/bin/env zsh
# Regenerate host-specific zsh files that chezmoi does not manage (zoxide
# integration, cached completions) after the tool scripts have run. The
# plugins, theme, and OMZ subset under ~/.zsh/vendor are vendored in this repo.

set -euo pipefail

ZSH_VENDOR="${ZSH_VENDOR:-$HOME/.zsh/vendor}"

log() { print -r -- "[install-zsh-stack] $*" }

source "$HOME/.zsh/path.sh"

if [[ ! -r "$ZSH_VENDOR/themes/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  log "warning: vendored zsh plugins are missing under $ZSH_VENDOR"
fi

# --- Generated shell integrations ---
if [[ -x "$HOME/.zsh/integrations/refresh.sh" ]]; then
  log "refreshing generated shell integrations"
  "$HOME/.zsh/integrations/refresh.sh"
fi

# --- Cached completions ---
if [[ -x "$HOME/.zsh/completions/refresh.sh" ]]; then
  log "refreshing cached completions"
  "$HOME/.zsh/completions/refresh.sh" || true
fi

# Invalidate stale compdumps so the new fpath/plugins are indexed.
rm -f -- "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh/zcompdump-*(N)

log "done. Open a new shell or run 'exec zsh'."
log "Reminder: secrets and host-local paths live in ~/.zshrc.local (not managed by chezmoi)."
