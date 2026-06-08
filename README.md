# Dotfiles (chezmoi-managed)

My dotfiles, managed by [chezmoi](https://www.chezmoi.io). Source files live in
`~/.local/share/chezmoi/` on every host; `chezmoi apply` materializes them into
`$HOME`.

## What this repo manages

| Tool        | Files                                                |
| ----------- | ---------------------------------------------------- |
| zsh         | `.zshrc`, `.zshenv`, `.profile`, `.p10k.zsh`         |
| zsh helpers | `.zsh/completions/refresh.sh`                        |
| tmux        | `.tmux.conf`                                         |
| neovim      | `.config/nvim/` (LazyVim setup; `lazy-lock.json` is per-host, see `.chezmoiignore`) |
| matplotlib  | `.config/matplotlib/matplotlibrc`                    |
| conda       | `.condarc`                                           |
| Claude Code | `.claude/CLAUDE.md`, `.claude/rules/code/CLAUDE.md`  |

Plus two bootstrap scripts that run once on first `chezmoi apply`:

- `run_once_install-zsh-stack.sh` — installs Oh My Zsh and clones
  `zsh-autosuggestions`, `fast-syntax-highlighting`, `powerlevel10k`. Refreshes
  cached completions.
- `run_once_install-tmux-stack.sh` — clones TPM (Tmux Plugin Manager) into
  `~/.tmux/plugins/tpm`.

## What this repo intentionally does NOT manage

See [`.chezmoiignore`](./.chezmoiignore) for the full list
---

## New machine setup

One command pulls the binary, the repo, and runs the bootstrap scripts:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mahoon2/dotfiles
```

This:

1. Downloads the chezmoi binary into `~/bin/`.
2. Clones this repo into `~/.local/share/chezmoi/`.
3. Runs `chezmoi apply`, which:
   - Materializes every managed file into `$HOME`.
   - Executes both `run_once_*` scripts (clones OMZ + plugins, TPM).
   - Refreshes cached zsh completions for whatever tools are already installed.

### After bootstrap: install tmux plugins

The bootstrap script installs TPM but not the plugins listed in `.tmux.conf`.
Open tmux and press `prefix + I` (capital I) to install them.

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

After upgrading `uv`, `glab`, `marimo`, or `gh`:

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
| `.chezmoiignore` | Patterns of dest paths to skip    |

This is structural in chezmoi — there is no setting to disable it.

---

## Uninstall

```sh
chezmoi purge                   # removes ~/.local/share/chezmoi/ and
                                # ~/.config/chezmoi/. Does NOT touch the
                                # already-deployed files in $HOME.
```
