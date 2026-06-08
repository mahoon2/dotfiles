## General code style
- Keep your namings consistent with the codebase.
- Avoid over-engineering. Always propose the simplest, most direct solution first unless a complex approach is strictly necessary.
- Avoid code duplication.

## Python code style
- Always use docstrings and type annotations. But except for that, don't overuse comments. Let the code explain your intention. If it doesn't, consider rewriting it.
- Keep the code pythonic and functional.
- For analysis codes: the code and the outputs (plots and tables) generated from it should have common prefix (ex. `compare_m1psi.py` and `compare_m1psi_fluc.png`). This helps me to figure out links between them.
    - Consider using `marimo` notebook for codes that generates plots.
- If not explicitly specified, don't change default fontsize or layout(no `tight_layout()` or `layout=constrained`)
- Format and lint codes with `ruff check --fix` and `ruff format`, respectively, check for types with `ty check`. Those tools are installed globally so you don't need to activate any environments for executing those commands.

## Python environments
- Before using conda commands, you should run `eval "$('/blaze/mahoon2/conda/bin/conda' 'shell.bash' 'hook' 2>/dev/null)" && conda activate {conda_environment_name}`.
- If there's `.venv/` directory under the project directory, use a virtual enviroment with the `source .venv/bin/activate` command.
- Always use `uv` for managing Python environments, dependencies, and virtual environments.

## Git Commits
- Always ask about whether you should work on current branch or another one.
- Keep commits atomic (one logical change) and self-explanatory. Split into multiple commits if addressing different concerns.
- Use conventional format: `<type>(<scope>): <subject>` where `type = feat|fix|docs|style|refactor|test|chore|perf`.
- Subject: 50 chars max, imperative mood ("add" not "added"), no period.
- For small changes: one-line commit only.
- For complex changes: add body explaining what/why (72-char lines) and reference issues.
- Ensure there are no credit statements (like "Co-Authored-By: Claude") included in commit messages and MR/PR descriptions.
