#!/usr/bin/env sh
# One-time cleanup after analysis.md and manuscript.md moved from
# ~/.claude/rules/ to ~/.claude/guides/ (commit 90ec227).
#
# Runs once per host, unlike .chezmoiremove, so these paths stay reusable.
# A rule copy is removed only if it matches a version this repo deployed
# (git blob id); a Codex symlink only if it still points into
# ~/.claude/rules/. Anything else is kept and reported.

set -eu

log() { printf '[remove-moved-claude-rules] %s\n' "$*"; }

remove_if_deployed() {
  path=$1
  shift
  [ -f "$path" ] || return 0
  if ! command -v git >/dev/null; then
    log "kept $path: git not found"
    return 0
  fi
  blob=$(git hash-object "$path")
  for known in "$@"; do
    if [ "$blob" = "$known" ]; then
      rm "$path"
      log "removed $path"
      return 0
    fi
  done
  log "kept $path: differs from every deployed version"
}

remove_if_rules_link() {
  path=$1
  [ -L "$path" ] || return 0
  case $(readlink "$path") in
    "$HOME"/.claude/rules/*)
      rm "$path"
      log "removed $path"
      ;;
    *) log "kept $path: points outside ~/.claude/rules/" ;;
  esac
}

remove_if_deployed "$HOME/.claude/rules/analysis.md" \
  419f52835620191f3879361dc3075c515396c5cf \
  8f1583e3cfb2f3a96c25f022c328a9836ecc27cf
remove_if_deployed "$HOME/.claude/rules/manuscript.md" \
  e7a63d5dcfcc1ff2a806a71ce97fb3f47662d0fc

for name in analysis code manuscript; do
  remove_if_rules_link "$HOME/.codex/rules/$name.md"
done
