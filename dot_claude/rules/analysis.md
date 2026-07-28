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

At the project root, organize directories by chronological work unit rather than by artifact type.

Example:

```text
00-shared/
01-ribogami-deterministic/
02-mrnafold-finer-grid/
```

Artifact-type directories may be created within each work unit.

Example:

```text
01-ribogami-deterministic/
├── logs/
├── plots/
├── results/
└── scripts/
```

Use `00-shared/` for inputs or resources shared across multiple work units.

Once a work-unit directory has been committed, published, or referenced by another artifact, do not renumber it. Use the next available prefix for new work.

## Execution behavior

- Inspect inputs and existing project conventions before running an analysis.
- Prefer deterministic and restartable procedures.
- Use workflow tools or environment specifications when they materially improve reproducibility.
- Do not overwrite existing results unless explicitly requested or safely versioned.
- Check exit status and relevant output after execution.
- Report failed commands and quality-control failures directly.
- Separate observed computational output from biological interpretation.
