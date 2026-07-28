# Code guidelines

These rules apply when writing, modifying, testing, or committing code.

## General principles

- Follow the repository's existing naming, structure, style, and public interfaces unless there is a clear reason to change them.
- Prefer the simplest direct solution that fully satisfies the requirement.
- Avoid speculative abstractions, premature generalization, and unnecessary dependencies.
- Avoid meaningful duplication, but do not introduce an abstraction merely to eliminate a small amount of clear code.
- Preserve existing behavior unless the task explicitly requires a behavioral change.
- Keep changes focused on the requested task. Do not perform unrelated cleanup without permission.
- Prefer readable code over clever code.

## Python style

- Use type annotations for new or materially modified Python code.
- Write docstrings for public modules, classes, functions, and non-obvious internal interfaces.
- Do not add docstrings or comments that merely restate the code.
- Use comments to explain constraints, rationale, scientific assumptions, or behavior that is not evident from the implementation.
- Prefer idiomatic Python and small, composable functions.
- Use explicit control flow when it is clearer than a compact or highly abstract expression.
- Avoid mutable global state unless it is clearly justified.
- Preserve the Python version and compatibility requirements defined by the project.

## Analysis scripts and outputs

For an analysis script, give its principal outputs a common descriptive prefix.

Example:

```text
compare_m1psi.py
compare_m1psi_fluc.png
compare_m1psi_summary.tsv
```

The prefix should describe the analysis rather than the plotting library or output type.

Consider a `marimo` notebook when an analysis is exploratory, benefits from reactive execution, or produces multiple related plots and tables. Prefer a plain Python script when batch execution, workflow integration, or command-line reproducibility is more important.

Unless explicitly requested or required by the existing project style:

- do not override the default font size
- do not enable `tight_layout()`
- do not use `layout="constrained"` or `constrained_layout=True`
- do not make unrelated aesthetic changes to existing plots

## Formatting, linting, and type checking

Use the repository's configured commands when they exist. Otherwise, use:

```bash
ruff check --fix <changed-paths>
ruff format <changed-paths>
ty check <changed-paths>
```

Apply automatic fixes only to files within the task scope.

After editing Python code:

1. format the affected files
2. run lint checks
3. run type checks
4. run the most relevant tests or validation commands

Do not report a check as successful unless it was actually run. Report unavailable tools, failures, and pre-existing errors separately.

## Python environments

Use `uv` by default for Python environment, dependency, and virtual-environment management.

If a `.venv/` directory exists at the project root, treat it as the project's active virtual environment and use it rather than creating another environment.

For commands that require an activated shell environment, activate it with:

```bash
source .venv/bin/activate
```

For commands that do not require explicit activation, prefer running them through `uv`, for example:

```bash
uv run python script.py
uv run pytest
uv run ruff check
```

Use `uv` to:

- create and manage `.venv/`
- add, remove, or update Python dependencies
- maintain dependency declarations and lockfiles
- run Python commands within the project environment

Do not create multiple virtual environments for the same project.

Do not use `pip`, `venv`, Poetry, Pipenv, or Conda in place of `uv` unless the repository explicitly requires them or `uv` cannot satisfy a necessary dependency or platform constraint.

Use Conda only when it is unavoidable, such as when:

- the project explicitly depends on an existing Conda environment
- required non-Python packages are managed through Conda
- a dependency cannot be installed or executed reliably with `uv`
- the user explicitly requests a Conda environment

Before running Conda commands, initialize and activate Conda with:

```bash
eval "$('/blaze/mahoon2/conda/bin/conda' 'shell.bash' 'hook' 2>/dev/null)" &&
conda activate <environment-name>
```

Do not guess the Conda environment name. Determine it from project documentation, environment files, the current environment, or an explicit instruction.

Do not migrate an existing Conda-based project to `uv`, or an existing `uv` project to Conda, unless explicitly requested.

Do not modify dependency declarations or lockfiles unless the task requires it.

## Git and branches

Before making commits, creating or switching branches, rebasing, merging, or otherwise changing Git history, confirm whether to use the current branch or another branch unless the user has already specified this.

Do not interrupt read-only inspection or ordinary uncommitted edits solely to ask about branch choice.

Before modifying a repository:

- inspect the working tree and current branch
- preserve unrelated user changes
- do not discard, overwrite, stage, or commit unrelated changes
- do not rewrite published history without explicit authorization

## Commits

Create commits only when requested or when commit creation is clearly part of the task.

Keep each commit atomic and limited to one logical change. Separate unrelated concerns into different commits.

Use Conventional Commits:

```text
<type>(<scope>): <subject>
```

Allowed types:

```text
feat
fix
docs
style
refactor
test
chore
perf
```

The scope is optional. Use it only when it adds useful context.

Commit subjects must:

- use imperative mood
- begin with a lowercase verb
- contain no trailing period
- be no longer than 50 characters

For a small change, use only the subject line.

For a complex change, add a body that:

- explains what changed and why
- records important constraints or tradeoffs
- wraps prose at approximately 72 characters
- references relevant issues when available

Do not include generated credit or attribution statements, including `Co-Authored-By` lines, in commit messages, merge requests, or pull requests.
