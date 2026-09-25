# Replication Package for "A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil"
by Nima Nonejad

This folder contains the data, MATLAB code, numerical reference results, and MATLAB figure files required to reproduce the results presented in the manuscript and supplementary material, reorganised for an independent replication audit. The upstream package is kept unmodified in `original_files/ijfr/`.

The replication code was developed using MATLAB R2009b with the Econometrics Toolbox. This audit runs it on MATLAB R2025b.

## Layout
* `code/functions/`: user-written MATLAB functions, plus `combvec.m` (removes the Deep Learning Toolbox dependency) and `replication_setting.m` (environment-variable toggles)
* `code/replication_of_submission/`: manuscript scripts and the `wti_k.mat` estimation outputs
* `code/replication_of_supplementary_material/`: supplementary scripts and their `.mat` outputs
* `data/`: FRED-MD predictors (`mx.xls`), oil prices and CPI (`my.xls`), monitoring variables (`mz.xls`), NBER recessions (`usrec.xls`)
* `reports/results/results.xls`: the author's numerical reference results
* `reports/results/runs/`: timestamped replication runs comparing recomputed values against `results.xls`
* `reports/plots/`: reference `.fig` files, `*_reference.png` exports and `*_reproduced.png` outputs
* `pipelines_python/`: Python runner and run matrix (`replication_runs.yaml`)
* `docs/`: upstream `readme.txt` and audit documentation

## Running
* Every MATLAB script sets its own paths from its location, so it can be run from its folder with no `addpath` edits
* Toggles the upstream readme asks you to comment or uncomment (`vend`, `ir`, `dg`, `ih`, `dlam`, Beta prior `da0`/`db0`) default to the upstream values and can be overridden with `REPL_<NAME>` environment variables
* Full replication matrix (61 MATLAB jobs, about 3 minutes), from the project root:

```bash
/opt/homebrew/bin/uv run python -m replication.matlab.pipelines_python.replication_runner
```

## Status
* Main text results replicate closely with no change in any conclusion
* Figure 4_supp (real price) does not replicate at cell level; details in `docs/replication/replication_log.md`
* Step-by-step procedures: `docs/replication/replication_log.md` (runbook sections) and the upstream `docs/readme.txt`

## Guide to the docs
* `docs/final_overview.md`: nontechnical summary — what was replicated, the verdict, and a plain-language note on the one open discrepancy. Start here.
* `docs/replication/replication_log.md`: the technical record — artifact ledger, per-figure verification status, the open/resolved discrepancy tracker, the re-execution runbook, and the reviewer verification protocol. One doc, four jobs.
* `docs/replication/figures.md`: side-by-side original vs reproduced figure images.
* `docs/quickstart_docs.md`: index routing every doc with reading sequences by audience.
* `docs/architecture/`: model math (`architecture.md`), claims-to-artifact crosswalk (`claims.md`), data catalog (`data.md`). Definitions only, no audit status.
* `docs/sanity_draft_check.md`: audit of the manuscript PDF — do the text claims match the code and `results.xls`.
* `docs/readme.txt`: the author's original instructions, kept unmodified.
