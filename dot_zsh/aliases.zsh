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
alias gav="git add --verbose"
alias gam="git am"
alias gama="git am --abort"
alias gamc="git am --continue"
alias gams="git am --skip"
alias gamscp="git am --show-current-patch"
alias gap="git apply"
alias gapt="git apply --3way"
alias gb="git branch"
alias gba="git branch --all"
alias gbD="git branch --delete --force"
alias gbd="git branch --delete"
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -D'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '"'"'{print $1}'"'"' | xargs git branch -d'
alias gbl="git blame -w"
alias gbm="git branch --move"
alias gbnm="git branch --no-merged"
alias gbr="git branch --remote"
alias gbs="git bisect"
alias gbsb="git bisect bad"
alias gbsg="git bisect good"
alias gbsn="git bisect new"
alias gbso="git bisect old"
alias gbsr="git bisect reset"
alias gbss="git bisect start"
alias gst="git status"
alias gss="git status --short"
alias gsb="git status --short --branch"
alias gco="git checkout"
alias gcor="git checkout --recurse-submodules"
alias gcb="git checkout -b"
alias gcB="git checkout -B"
alias gc="git commit --verbose"
alias gc!="git commit --verbose --amend"
alias gca="git commit --verbose --all"
alias gca!="git commit --verbose --all --amend"
alias gcan!="git commit --verbose --all --no-edit --amend"
alias gcann!="git commit --verbose --all --date=now --no-edit --amend"
alias gcans!="git commit --verbose --all --signoff --no-edit --amend"
alias gcam="git commit --all --message"
alias gcas="git commit --all --signoff"
alias gcasm="git commit --all --signoff --message"
alias gcf="git config --list"
alias gcfu="git commit --fixup"
alias gcl="git clone --recurse-submodules"
alias gclf="git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules"
alias gclean="git clean --interactive -d"
alias gcn="git commit --verbose --no-edit"
alias gcn!="git commit --verbose --no-edit --amend"
alias gcount="git shortlog --summary --numbered"
alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"
alias gcmsg="git commit --message"
alias gcs="git commit --gpg-sign"
alias gcsm="git commit --signoff --message"
alias gcss="git commit --gpg-sign --signoff"
alias gcssm="git commit --gpg-sign --signoff --message"
alias gd="git diff"
alias gdca="git diff --cached"
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw="git diff --cached --word-diff"
alias gds="git diff --staged"
alias gdt="git diff-tree --no-commit-id --name-only -r"
alias gdup="git diff @{upstream}"
alias gdw="git diff --word-diff"
alias gf="git fetch"
alias gfa="git fetch --all --tags --prune"
alias gfg="git ls-files | grep"
alias gfo="git fetch origin"
alias gfp="git fetch --prune"
alias gg="git gui citool"
alias gga="git gui citool --amend"
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gignore="git update-index --assume-unchanged"
alias ghh="git help"
alias git-svn-dcommit-push='git svn dcommit && git push github $(_git_main_branch):svntrunk'
alias gk="\gitk --all --branches &!"
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'
alias gl="git pull"
alias glgg="git log --graph"
alias glgga="git log --graph --decorate --all"
alias glgm="git log --graph --max-count=10"
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glo="git log --oneline --decorate"
alias glog="git log --oneline --decorate --graph"
alias gloga="git log --oneline --decorate --graph --all"
alias glg="git log --stat"
alias glgp="git log --stat --patch"
alias gluc='git pull upstream $(_git_current_branch)'
alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gmff="git merge --ff-only"
alias gms="git merge --squash"
alias gmtl="git mergetool --no-prompt"
alias gmtlvim="git mergetool --no-prompt --tool=vimdiff"
alias gp="git push"
alias gpd="git push --dry-run"
alias gpf="git push --force-with-lease --force-if-includes"
alias gpf!="git push --force"
alias gpoat="git push origin --all && git push origin --tags"
alias gpod="git push origin --delete"
alias gpra="git pull --rebase --autostash"
alias gprav="git pull --rebase --autostash -v"
alias gpr="git pull --rebase"
alias gpristine="git reset --hard && git clean --force -dfx"
alias gprv="git pull --rebase -v"
alias gpv="git push --verbose"
alias gpu="git push upstream"
alias gr="git remote"
alias gra="git remote add"
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"
alias grbo="git rebase --onto"
alias grbom='git rebase origin/$(_git_main_branch)'
alias grbs="git rebase --skip"
alias grbum='git rebase upstream/$(_git_main_branch)'
alias grev="git revert"
alias greva="git revert --abort"
alias grevc="git revert --continue"
alias grf="git reflog"
alias grh="git reset"
alias grhh="git reset --hard"
alias grhk="git reset --keep"
alias grhs="git reset --soft"
alias grm="git rm"
alias grmc="git rm --cached"
alias grmv="git remote rename"
alias groh='git reset origin/$(_git_current_branch) --hard'
alias grrm="git remote remove"
alias grs="git restore"
alias grss="git restore --source"
alias grst="git restore --staged"
alias grset="git remote set-url"
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru="git reset --"
alias grup="git remote update"
alias grv="git remote --verbose"
alias gsd="git svn dcommit"
alias gsh="git show"
alias gsi="git submodule init"
alias gsps="git show --pretty=short --show-signature"
alias gsr="git svn rebase"
alias gsta="git stash push"
alias gstaa="git stash apply"
alias gstall="git stash --all"
alias gstc="git stash clear"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gsts="git stash show --patch"
alias gstu="gsta --include-untracked"
alias gsu="git submodule update"
alias gsw="git switch"
alias gswc="git switch --create"
alias gta="git tag --annotate"
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gts="git tag --sign"
alias gtv="git tag | sort -V"
alias gunignore="git update-index --no-assume-unchanged"
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gwch="git log --patch --abbrev-commit --pretty=medium --raw"
alias gwt="git worktree"
alias gwta="git worktree add"
alias gwtls="git worktree list"
alias gwtmv="git worktree move"
alias gwtrm="git worktree remove"
alias gwipe="git reset --hard && git clean --force -df"
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'

_git_log_prettily() {
  if [[ -n "$1" ]]; then
    command git log --pretty="$1"
  fi
}
(( $+functions[compdef] )) && compdef _git _git_log_prettily=git-log
alias glp="_git_log_prettily"

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
