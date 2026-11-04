# Dotfiles (chezmoi-managed)

My dotfiles, managed by [chezmoi](https://www.chezmoi.io). Source files live in
`~/.local/share/chezmoi/` on every host; `chezmoi apply` materializes them into
`$HOME`.

## What this repo manages

| Tool        | Files                                                |
| ----------- | ---------------------------------------------------- |
| zsh         | `.zshrc`, `.zshenv`, `.zprofile`, `.profile`, `.p10k.zsh` |
| zsh helpers | `.zsh/path.sh`, `.zsh/completions/refresh.sh`, `.zsh/integrations/refresh.sh` |
| CLI tools   | `.pixi/manifests/pixi-global.toml` and the install scripts below |
| tmux        | `.tmux.conf`                                         |
| neovim      | `.config/nvim/` (LazyVim setup; `lazy-lock.json` is per-host, see `.chezmoiignore`) |
| matplotlib  | `.config/matplotlib/matplotlibrc`                    |
| conda       | `.condarc`                                           |
| Claude Code | `.claude/CLAUDE.md`, `.claude/rules/` (auto-loaded), `.claude/guides/` (read on demand), `.claude/themes/` |
| Codex       | `.codex/themes/` (Tokyo Night `.tmTheme` from tokyonight.nvim extras) |

## Tool installation

Tools are installed into `$HOME` without sudo, in this order of preference:
official installer, then a language package manager (cargo, uv, go), then
`pixi global` (conda-forge) for the rest. Homebrew and apt are not used.
`~/.zsh/path.sh` puts these locations ahead of system and Homebrew paths, and
`~/.zprofile` re-applies it after macOS `path_helper`.

`chezmoi apply` runs these scripts after deploying files, in name order. Each
reruns when its contents, or a file whose hash it embeds, change:

| Script | Installs |
| ------ | -------- |
| `run_onchange_after_10-install-toolchains.sh.tmpl` | uv, pixi, rustup (+ rust-analyzer), Go (pinned, `~/.local/go`), nvm and node LTS; each only if missing |
| `run_onchange_after_20-install-tools.sh.tmpl` | `pixi global sync`; eza, fd, ripgrep (cargo); ruff, ty, marimo, pre-commit (uv tool); zoxide (official script); fzf (`~/.fzf`); lazygit (`go install`) |
| `run_onchange_after_30-install-tmux-stack.sh` | TPM and the `@plugin` entries in `.tmux.conf` |
| `run_onchange_after_40-install-zsh-stack.sh` | zoxide integration and cached completions for the installed tools |
| `run_onchange_after_50-install-lazyvim.sh.tmpl` | lazy.nvim, LazyVim, and the plugins in `.config/nvim`; Mason tools install on the first interactive launch |

To add a tool, put it in the matching list in the `20` script or in the pixi
manifest. To upgrade a pinned version, edit it in the script. Fonts (Inter for
matplotlib, FiraCode Nerd Font for Ghostty) are not installed by these scripts.

Other scripts:

- `run_after_link-codex-instructions.sh` runs after every `chezmoi apply`:

  it symlinks `~/.codex/AGENTS.md` to `~/.claude/CLAUDE.md`. An existing
  non-matching file is reported, not overwritten.
- `run_once_after_remove-moved-claude-rules.sh` runs once per host: it removes the pre-move
  `~/.claude/rules/{analysis,manuscript}.md` copies (only if unmodified) and
  stale `~/.codex/rules/*.md` symlinks. Delete it once every host has run it.

## What this repo intentionally does NOT manage

See [`.chezmoiignore`](./.chezmoiignore) for the full list

## New machine setup

Prerequisites: `git`, `curl`, `tar`, and a C compiler (for `cargo install`).
One command pulls the binary, the repo, and runs the install scripts:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin init --apply mahoon2/dotfiles
```

This:

1. Downloads the chezmoi binary into `~/.local/bin/`.
2. Clones this repo into `~/.local/share/chezmoi/`.
3. Runs `chezmoi apply`, which materializes every managed file into `$HOME`
   and then runs the install scripts above. The first run takes a few minutes
   because cargo and go build some tools from source.

### One-time migration warning (existing dotfiles)

If `$HOME/.config` or any other managed path is currently a **directory
symlink** (e.g. `~/.config → /some/other/path`), the first `chezmoi apply`
will unlink it and create a fresh directory containing only the managed
subpaths. Unmanaged neighbors will disappear from the visible `$HOME`.

Safe sequence for that scenario:

```sh
rsync -a /old/path/.config/ ~/.config-real/
unlink ~/.config
mv ~/.config-real ~/.config
chezmoi apply
```

The same pattern applies to symlinked individual files; for those, `cp -p`
the target to a side file, `unlink` the symlink, then `mv` the side file
into place before `chezmoi apply`.

---

## Daily workflow

### Edit a managed file

Two equivalent flows:

```sh
# A. Edit in $HOME, then sync the change back into chezmoi's source.
nvim ~/.zshrc
chezmoi re-add ~/.zshrc

# B. Edit the source directly; chezmoi apply propagates to $HOME.
chezmoi edit ~/.zshrc           # opens dot_zshrc in $EDITOR
chezmoi apply ~/.zshrc          # only needed for files an open shell holds
```

### Add a new file to chezmoi

```sh
chezmoi add ~/.some-new-rc
# For symlinks whose content you want (not the link itself):
chezmoi add --follow ~/.linked-file
```

### Commit and push

```sh
chezmoi cd                      # subshell in the source dir
git status
git diff

git add dot_zshrc               # prefer naming files explicitly over `git add .`
git commit -m "feat(zsh): describe the change"
git push origin main
exit                            # leave the chezmoi cd subshell
```

Shorter form that doesn't change directory:

```sh
chezmoi git -- status
chezmoi git -- diff
chezmoi git -- add dot_zshrc
chezmoi git -- commit -m "..."
chezmoi git -- push
```

### Pull updates from another machine

```sh
chezmoi update                  # = git pull + chezmoi apply
```

Or step-by-step:

```sh
chezmoi git -- pull --ff-only
chezmoi diff                    # preview before applying
chezmoi apply
```

### Refresh cached completions

After upgrading `uv`, `glab`, `marimo`, `gh`, or `fd`:

```sh
~/.zsh/completions/refresh.sh
rm -f ~/.zcompdump* && exec zsh
```

The script silently skips any tool not on `$PATH`.

---

## Conventions for source filenames

chezmoi requires prefixes to map source files to dotfiles in `$HOME`:

| Source prefix    | Destination behavior              |
| ---------------- | --------------------------------- |
| `dot_X`          | `$HOME/.X`                        |
| `private_dot_X`  | `$HOME/.X` with mode `0600`/`0700`|
| `executable_dot_X` | `$HOME/.X` with `+x`            |
| `run_once_X.sh`  | Executes once per hash change     |
| `run_after_X.sh` | Executes after every apply        |
| `.chezmoiignore` | Patterns of dest paths to skip    |

This is structural in chezmoi — there is no setting to disable it.

---

## Uninstall

```sh
chezmoi purge                   # removes ~/.local/share/chezmoi/ and
                                # ~/.config/chezmoi/. Does NOT touch the
                                # already-deployed files in $HOME.
```
