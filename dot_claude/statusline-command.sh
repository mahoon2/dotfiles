#!/usr/bin/env bash
# Claude Code status line script
# Segments, in order: cwd, git branch/status, user@host (root or SSH only),
# time, active model, and context window usage.

input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# cwd segment (bold blue)
printf '\033[01;34m%s\033[00m' "$cwd"

# git branch segment ( green if clean, yellow if dirty)
branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "$branch" ]; then
    if [ -z "$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)" ]; then
        git_color='0;32'
    else
        git_color='0;33'
    fi
    printf ' \033[%sm %s\033[00m' "$git_color" "$branch"
fi

# user@host segment: shown only when root (red) or in an SSH session (yellow)
if [ "$(id -u)" -eq 0 ]; then
    printf ' \033[0;31m%s@%s\033[00m' "$(whoami)" "$(hostname -s)"
elif [ -n "${SSH_CONNECTION}${SSH_TTY}${SSH_CLIENT}" ]; then
    printf ' \033[0;33m%s@%s\033[00m' "$(whoami)" "$(hostname -s)"
fi

# time segment
printf ' %s' "$(date +%H:%M:%S)"

# model segment
if [ -n "$model" ]; then
    printf ' \033[0;33m[%s]\033[00m' "$model"
fi

# context usage segment
if [ -n "$used" ]; then
    printf ' \033[0;36mctx:%.0f%%\033[00m' "$used"
fi
