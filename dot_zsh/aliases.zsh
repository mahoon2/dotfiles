# Personal aliases. Keep frequently used Git shortcuts here instead of sourcing
# OMZ Git plugins on every shell startup.

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
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gapa="git add --patch"
alias gau="git add --update"
alias gst="git status"
alias gss="git status --short"
alias gsb="git status --short --branch"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gc="git commit --verbose"
alias gc!="git commit --verbose --amend"
alias gca="git commit --verbose --all"
alias gcam="git commit --all --message"
alias gcmsg="git commit --message"
alias gd="git diff"
alias gdca="git diff --cached"
alias gds="git diff --staged"
alias gf="git fetch"
alias gfo="git fetch origin"
alias gfp="git fetch --prune"
alias gl="git pull"
alias gp="git push"
alias gpd="git push --dry-run"
alias gpf="git push --force-with-lease --force-if-includes"
alias gpu="git push upstream"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"
alias grs="git restore"
alias grst="git restore --staged"
alias gsw="git switch"
alias gswc="git switch --create"

_git_current_branch() {
  command git symbolic-ref --quiet --short HEAD 2>/dev/null ||
    command git rev-parse --short HEAD 2>/dev/null
}

_git_main_branch() {
  local remote ref

  command git rev-parse --git-dir &>/dev/null || return
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify "$ref"; then
      print -r -- "${ref:t}"
      return 0
    fi
  done

  for remote in origin upstream; do
    ref="$(command git rev-parse --abbrev-ref "$remote/HEAD" 2>/dev/null)"
    if [[ "$ref" == "$remote"/* ]]; then
      print -r -- "${ref#"$remote/"}"
      return 0
    fi
  done

  print -r -- master
  return 1
}

_git_develop_branch() {
  local branch

  command git rev-parse --git-dir &>/dev/null || return
  for branch in dev devel develop development; do
    if command git show-ref -q --verify "refs/heads/$branch"; then
      print -r -- "$branch"
      return 0
    fi
  done

  print -r -- develop
  return 1
}

gpsup() {
  local branch
  branch="$(_git_current_branch)" || return
  command git push --set-upstream origin "$branch"
}

gpsupf() {
  local branch
  branch="$(_git_current_branch)" || return
  command git push --set-upstream origin "$branch" --force-with-lease --force-if-includes
}

ggsup() {
  local branch
  branch="$(_git_current_branch)" || return
  command git branch --set-upstream-to="origin/$branch"
}

ggl() {
  local branch
  if (( $# == 0 )); then
    branch="$(_git_current_branch)" || return
    command git pull origin "$branch"
  elif (( $# == 1 )); then
    command git pull origin "$1"
  else
    command git pull origin "$@"
  fi
}

ggp() {
  local branch
  if (( $# == 0 )); then
    branch="$(_git_current_branch)" || return
    command git push origin "$branch"
  elif (( $# == 1 )); then
    command git push origin "$1"
  else
    command git push origin "$@"
  fi
}

ggpull() {
  local branch
  branch="$(_git_current_branch)" || return
  command git pull origin "$branch"
}

ggpush() {
  local branch
  branch="$(_git_current_branch)" || return
  command git push origin "$branch"
}

ggf() {
  local branch
  branch="${1:-$(_git_current_branch)}" || return
  command git push --force origin "$branch"
}

ggfl() {
  local branch
  branch="${1:-$(_git_current_branch)}" || return
  command git push --force-with-lease origin "$branch"
}

ggpnp() {
  if (( $# == 0 )); then
    ggl && ggp
  else
    ggl "$@" && ggp "$@"
  fi
}

gcm() {
  local branch
  branch="$(_git_main_branch)" || return
  command git checkout "$branch"
}

gcd() {
  local branch
  branch="$(_git_develop_branch)" || return
  command git checkout "$branch"
}

gswm() {
  local branch
  branch="$(_git_main_branch)" || return
  command git switch "$branch"
}

gswd() {
  local branch
  branch="$(_git_develop_branch)" || return
  command git switch "$branch"
}

grbm() {
  local branch
  branch="$(_git_main_branch)" || return
  command git rebase "$branch"
}

grbd() {
  local branch
  branch="$(_git_develop_branch)" || return
  command git rebase "$branch"
}

gprom() {
  local branch
  branch="$(_git_main_branch)" || return
  command git pull --rebase origin "$branch"
}

gpromi() {
  local branch
  branch="$(_git_main_branch)" || return
  command git pull --rebase=interactive origin "$branch"
}

glum() {
  local branch
  branch="$(_git_main_branch)" || return
  command git pull upstream "$branch"
}

gprum() {
  local branch
  branch="$(_git_main_branch)" || return
  command git pull --rebase upstream "$branch"
}

gprumi() {
  local branch
  branch="$(_git_main_branch)" || return
  command git pull --rebase=interactive upstream "$branch"
}

gmom() {
  local branch
  branch="$(_git_main_branch)" || return
  command git merge "origin/$branch"
}

gmum() {
  local branch
  branch="$(_git_main_branch)" || return
  command git merge "upstream/$branch"
}
