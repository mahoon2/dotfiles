# Personal aliases. OMZ plugin aliases are loaded from their original plugin files.

alias ls="eza -l --icons=\"auto\" --group-directories-first"
alias la="eza -l --icons=\"auto\" --group-directories-first -a"
alias vi="nvim"

# Directory shortcuts.
alias -g ...="../.."
alias -g ....="../../.."

# Python
alias py="python3"
alias python="python3"
alias pip="pip3"
alias pi="pip3 install"
alias pui="pip3 uninstall"

# Python virtualenv
alias va='source .venv/bin/activate'
alias vda='deactivate'

# Conda
alias ca="conda activate"
alias cda="conda deactivate"
alias ci="conda install"
alias cui="conda uninstall"
alias cls="conda list"
alias cels="conda env list"

# CLI tools
alias cc="claude"
alias ccu="ccusage"
alias gem="gemini"
alias co="codex"

# uv
alias uv="noglob uv"
alias uva="uv add"
alias uvexp="uv export --format requirements-txt --no-hashes --output-file requirements.txt --quiet"
alias uvi="uv init"
alias uvinw="uv init --no-workspace"
alias uvl="uv lock"
alias uvlr="uv lock --refresh"
alias uvlu="uv lock --upgrade"
alias uvp="uv pip"
alias uvpi="uv python install"
alias uvpl="uv python list"
alias uvpu="uv python uninstall"
alias uvpy="uv python"
alias uvpp="uv python pin"
alias uvr="uv run"
alias uvrm="uv remove"
alias uvs="uv sync"
alias uvsr="uv sync --refresh"
alias uvsu="uv sync --upgrade"
alias uvtr="uv tree"
alias uvup="uv self update"
alias uvv="uv venv"

# Git
alias gfp="git fetch --prune"
