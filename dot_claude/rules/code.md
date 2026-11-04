# Code guidelines

These rules apply when writing, modifying, testing, or committing code.

## Scope

Keep changes focused on the requested task. Do not perform unrelated cleanup or modify dependency declarations and lockfiles unless the task requires it.

## Python style

- Use type annotations, and write docstrings for public modules, classes, and functions and for non-obvious internal interfaces.
- Comment only constraints, rationale, scientific assumptions, or non-evident behavior. Do not add docstrings or comments that merely restate the code.
- Keep code pythonic and functional in style, built from small, composable functions.

## Analysis scripts and outputs

Give an analysis script and its principal outputs a common prefix that describes the analysis rather than the library or output type:

```text
compare_m1psi.py
compare_m1psi_fluc.png
compare_m1psi_summary.tsv
```

Use a `marimo` notebook for exploratory analyses that produce several related plots and tables, and a plain Python script when batch execution or workflow integration matters more.

When plotting with Matplotlib in a sandboxed environment, set `MPLCONFIGDIR` to a writable cache directory and `MATPLOTLIBRC` to `~/.config/matplotlib/matplotlibrc` so that the user configuration is respected.

Unless explicitly requested or required by the project's existing style, do not override the default font size, use `tight_layout()` or constrained layout, or make unrelated aesthetic changes to existing plots.

## Formatting, linting, and type checking

After editing Python code, use the repository's configured commands if they exist. Otherwise, run `ruff check --fix`, `ruff format`, and `ty check` on the changed paths, then the most relevant tests. `ruff` and `ty` are installed globally, so they need no environment activation.

## Python environments

Use `uv` by default instead of `pip`, `venv`, Poetry, or Pipenv. If the project has a `.venv/`, use it rather than creating another environment, and prefer `uv run` for commands. If the project already uses another tool, follow it, and do not migrate a project between `uv`, Pixi, and Conda unless explicitly requested.

When `uv` is insufficient, such as when non-Python packages from conda-forge or Bioconda are required, prefer Pixi over Conda. If a project has a `pixi.toml` or a `[tool.pixi]` table in `pyproject.toml`, manage it with Pixi (`pixi add`, `pixi add --pypi`, `pixi run`) and do not create a separate `.venv/`.

Use Conda only when the project already depends on a Conda environment or I explicitly request it. Determine the environment name from project documentation, environment files, or the current environment instead of guessing it. If `conda` is not already available in the shell, initialize it before `conda activate`; on the `/blaze` server, use:

```bash
eval "$('/blaze/mahoon2/conda/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
```

## Git

- Before commits, branch changes, rebases, merges, or other history changes, confirm which branch to use unless I have specified it. Do not ask during read-only inspection or ordinary uncommitted edits.
- Stage and commit only task-related changes, and preserve unrelated ones.
- Keep each commit atomic. Use Conventional Commits, `<type>(<scope>): <subject>`, with an optional scope and a type from `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, and `perf`. The subject uses imperative mood, starts with a lowercase verb, has no trailing period, and is at most 50 characters. Use a subject-only message for small changes; for complex ones, add a body explaining what and why, wrapped at about 72 characters.
- Do not include generated attribution, such as `Co-Authored-By` lines, in commits, merge requests, or pull requests.

## Remote actions

Anything that leaves the local machine requires my explicit confirmation immediately before the action, every time. This includes pushing, creating or updating merge or pull requests, posting or editing comments and reviews, resolving threads, and changing issues. Prepare the work locally, show the exact commits, the target branch or remote, and the full text of any comment, then wait. Earlier confirmation does not carry over to a later action.

A request to address, fix, or respond to review feedback authorizes local changes only, not the push or the reply. "Resolve the comments" means work out the fix, not mark the threads resolved.

Read-only remote inspection, such as fetching, cloning, or viewing issues and comments, needs no confirmation.
