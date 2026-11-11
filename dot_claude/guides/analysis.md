# Biological and bioinformatics analysis

These rules apply when executing biologically meaningful analysis commands or scripts, not to trivial navigation or inspection.

## Execution logs

For each scientifically meaningful step, write a Markdown execution log named with the work-unit prefix and a descriptive slug, such as `01-run-ribogami.log.md`. Record:

- purpose, working directory, and input and output files
- software versions and environment, container, or dependency information
- exact command, parameters with rationale, and random seed when applicable
- reference genome, annotation, database, or accession versions
- conventions that affect interpretation: coordinate system and indexing, strandedness, normalization, filtering thresholds, handling of multimapping or ambiguous observations, and randomization or subsampling
- execution status, warnings, errors, and quality-control results

Do not claim reproducibility when required versions, references, or inputs are unknown.

## Compute resources

- Size scheduler requests from a measurement, not an estimate. An oversized `--mem` or `--cpus-per-task` leaves every task pending with no error and no diagnosis: check what nodes actually have free, and record the measured peak next to the request.

## Project organization

Organize a project as project root, chronological main work units, and optional chronological sub-work units. Do not create sub-work units when artifact-type directories suffice.

```text
project/
├── README.md
├── 0707-parameter-calibration/       # main work unit with sub-work units
│   ├── README.md
│   ├── 00-shared/                     # resources shared across sub-work units
│   └── 01-ribogami-deterministic/
│       ├── README.md
│       ├── scripts/  jobs/  manifests/  results/
│       └── logs/slurm/<job-family>/
└── 0707-poster/                       # simple unit: artifact directories only
    ├── README.md
    ├── scripts/
    └── results/
```

- Every project root, work unit, and sub-work unit has a `README.md` stating what it owns, why it exists, its status, inputs and outputs, canonical artifacts, and upstream and downstream relationships.
- Keep artifact-type directories (`inputs/`, `scripts/`, `jobs/`, `logs/`, `manifests/`, `results/`, `artifacts/`, `planned/`) inside the unit that owns them. Do not collect logs from unrelated units in one project-wide directory.
- Aside from `README.md`, keep only canonical summary datasets or final human-readable artifacts at a work-unit root.
- Never renumber a work unit once it has been committed, published, or referenced. Use the next available prefix.
- Keep planned but unexecuted work under `planned/` with its status marked.

## Cleanup and relocation

- During cleanup, preserve raw inputs, expensive or unique results, accepted summary tables, final artifacts, execution logs, and provenance. Delete caches, bytecode, failed or empty outputs, redundant report revisions, obsolete generated jobs, and cheap intermediates once their generating command and inputs are preserved.
- When a directory moves, do not rewrite historical logs, manifests, or runtime records. Preserve their bytes and record old and new paths in a relocation manifest.
