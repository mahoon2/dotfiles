# Biological and bioinformatics analysis

These rules apply when executing biologically meaningful analysis commands or scripts. They do not apply to trivial navigation or inspection commands unless those commands affect the analysis.

## Reproducibility

For each scientifically meaningful analysis step, create a Markdown execution log named with the work-unit prefix and a descriptive slug.

Example:

```text
01-run-ribogami.log.md
```

Each log should record:

- purpose of the analysis step
- working directory
- input and output files
- software and version
- relevant environment, container, or dependency information
- parameter descriptions and rationale
- exact command
- random seed, when applicable
- reference genome, annotation, database, or accession version (if needed)
- execution status
- important warnings, errors, or quality-control results

Do not claim reproducibility when required versions, references, or inputs are unknown.

## Scientific conventions

Record conventions that could affect interpretation, including:

- coordinate system and indexing convention
- reference strand and strandedness
- reference sequence and annotation release
- normalization method
- filtering thresholds
- treatment of multimapping or ambiguous observations
- randomization or subsampling procedure

Preserve raw inputs. Treat source data as immutable unless modification is explicitly requested.

## Project organization

Organize analysis projects as a hierarchy of project root, chronological main
work units, and optional chronological sub-work units. Do not create sub-work
units when artifact-type directories are sufficient for a simple analysis.

Example:

```text
project/
├── README.md
├── 0707-parameter-calibration/
│   ├── README.md
│   ├── 00-shared/
│   │   └── README.md
│   └── 01-ribogami-deterministic/
│       └── README.md
└── 0707-poster/
    ├── README.md
    ├── scripts/
    └── results/
```

Every project root, main work unit, and sub-work unit must contain a
`README.md`. Describe what the unit owns, why the work is needed, its status,
its inputs and outputs, its canonical artifacts, and its relationship to
upstream and downstream work.

Keep artifact-type directories inside the work unit that owns them. Suitable
names include `inputs/`, `scripts/`, `jobs/`, `logs/`, `manifests/`,
`results/`, `artifacts/`, and `planned/`. Scheduler captures normally belong
under `logs/slurm/<job-family>/`; do not collect logs from unrelated work units
in one project-wide directory.

Example:

```text
01-ribogami-deterministic/
├── README.md
├── inputs/
├── jobs/
├── logs/
├── manifests/
├── results/
├── scripts/
└── artifacts/
```

Use `00-shared/` for inputs or resources shared across multiple work units.
Keep work-unit roots clear: aside from `README.md`, only canonical summary
datasets or final human-readable artifacts should be stored directly at a
work-unit root.

Once a work-unit directory has been committed, published, or referenced by another artifact, do not renumber it. Use the next available prefix for new work.

Before cleanup, distinguish unique evidence from rebuildable material.
Preserve immutable raw inputs, expensive or unique results, accepted summary
tables, final artifacts, execution logs, and provenance needed to reproduce a
conclusion. Delete caches, bytecode, failed or empty outputs, redundant report
revisions, obsolete generated jobs, and inexpensive-to-recompute
intermediates once their generating command and required inputs are preserved.

Do not rewrite historical logs, manifests, or runtime records merely because a
directory moved. Preserve their bytes and record old and new paths in a
relocation manifest. Keep planned but unexecuted work under `planned/` and mark
its status explicitly.

## Execution behavior

- Inspect inputs and existing project conventions before running an analysis.
- Prefer deterministic and restartable procedures.
- Use workflow tools or environment specifications when they materially improve reproducibility.
- Do not overwrite existing results unless explicitly requested or safely versioned.
- Check exit status and relevant output after execution.
- Report failed commands and quality-control failures directly.
- Separate observed computational output from biological interpretation.
