# User-space tool paths, sourced by ~/.zshenv, ~/.zprofile, and the chezmoi
# install scripts. Every installer runs without sudo, so these directories go
# ahead of system and Homebrew paths. POSIX sh syntax so that bash scripts can
# source it too; zsh deduplicates it through `typeset -U path PATH`.
PATH="$HOME/.pixi/bin:$HOME/.cargo/bin:$HOME/.local/go/bin:${GOPATH:-$HOME/go}/bin:$HOME/.local/bin:$PATH"
export PATH
