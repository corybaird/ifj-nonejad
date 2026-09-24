# MATLAB Pipeline Re-Execution Guide and Runbook

## 1. Table of Contents
* 1.1 Environment Setup and Prerequisites
* 1.2 Automated Full Run
* 1.3 Quickstart Spot Check (wti_4.mat)
* 1.4 Manual Manuscript Runbook
* 1.5 Manual Supplementary Runbook
* 1.6 Compatibility Notes for Modern MATLAB Versions

---

## 1.1 Environment Setup and Prerequisites
* Preferred environment: MATLAB R2009b with Econometrics Toolbox
* Tested modern environment: MATLAB R2025b (macOS, Apple Silicon)
* Paths: each script adds `code/functions`, `data`, `reports/results` and `code/replication_of_submission` relative to its own location; no manual `addpath` needed
* Toggles: set `REPL_<NAME>` environment variables (read by `code/functions/replication_setting.m`) or edit the default in the script

| Toggle | Scripts | Values |
|---|---|---|
| `REPL_VEND` | `figure1/7_computation`, `figure2..7_supp_computation`, `table1_supp` | `202412`, `201912` |
| `REPL_IR` | `figure_4_computation`, `figure5_computation` | `0`, `1` |
| `REPL_DG`, `REPL_PRIOR_IDX` | `main_prior`, `figure7_supp_computation` | g in {0.05, 0.5, 5, 50, 100}, index 1 to 5 |
| `REPL_IH` | `main_for`, `figure9_supp_computation` | 2, 3, 4, 9 |
| `REPL_DLAM`, `REPL_SIM_IDX` | `main_sim`, `figure1_supp_computation` | λ in {1, 1.5, 0.5}, index 1 to 3 |
| `REPL_DA0`, `REPL_DB0` | `figure6_supp_computation` | (0.1, 0.1), (2, 2), (20, 1), (20, 0.1) |
| `REPL_REAL_K` | `main_real` | default `4`; full run uses all 18 predictors |

---

## 1.2 Automated Full Run
* Command, from the project root (MATLAB calls need sandbox bypass under Claude Code):

```bash
/opt/homebrew/bin/uv run python -m replication.matlab.pipelines_python.replication_runner
```

* Run matrix: `pipelines_python/replication_runs.yaml` (19 producers, 38 computations, 5 recomputed figures)
* Runtime: about 3 minutes with 6 parallel MATLAB processes; `main.m` and `main_real.m` take about 46 seconds each
* Outputs in `reports/results/runs/replication_run_<timestamp>/`: job log, cell-level comparison, per-job summary, conclusion flips, MATLAB logs
* Also regenerates `reports/plots/*_reference.png` from `original_files/ijfr/plots/*.fig`

---

## 1.3 Quickstart Spot Check (wti_4.mat)
* Navigate to `code/replication_of_submission` and run `main_example.m` (predictor `k=4`)
* Run `figure1_computation_example.m`; `mquant` matches row 4, columns 1 to 3 of sheet `figure1` to within 2e-4
* Python alternative with a shared MATLAB session: `uv run python -m replication.matlab.pipelines_python.run_example`

---

## 1.4 Manual Manuscript Runbook
* `main.m`: writes the 18 `wti_k.mat` files ($k \in \{1..11, 13..19\}$)
* Figure 1: `figure1_computation.m` with `vend=202412` then `vend=201912`; plot with `figure1.m`
* Figures 2, 3, 6: run the script directly after `main.m`
* Figures 4 and 5: `figure_4_computation.m` / `figure5_computation.m` with `ir=0` then `ir=1`; plot with `figure4.m` / `figure5.m`
* Figure 7: `figure7_computation.m` with both `vend` values; plot with `figure7.m`

---

## 1.5 Manual Supplementary Runbook
* Table 1_supp: `main_sma_bma.m`, `main_reg.m`, then `table1_supp.m` for both `vend` values
* Figure 1_supp: `main_sim.m` then `figure1_supp_computation.m` for each λ; plot via `figure1_supp.m`
* Figures 2_supp, 3_supp, 5_supp: computation script for both `vend` values (uses `main.m` outputs)
* Figure 4_supp: `main_real.m` for all 18 predictors, then `figure4_supp_computation.m`
* Figure 6_supp: `figure6_supp_computation.m` for each Beta prior
* Figure 7_supp: `main_prior.m` then `figure7_supp_computation.m` for each g
* Figure 8_supp: `main_brent.m`, `main_rac.m`, then `figure8_supp.m`
* Figure 9_supp: `main_for.m` and `figure9_supp_computation.m` for each h, `main_exp.m`, then `figure9_supp.m`
* Plot scripts write `reports/plots/figureN_supp_reproduced.{png,fig}`; reference `.fig` files are never overwritten

---

## 1.6 Compatibility Notes for Modern MATLAB Versions
* `RandStream.setDefaultStream` replaced with `RandStream.setGlobalStream` (active only in `main_sim.m`)
* `xlsread` emits deprecation notices but still runs on R2025b
* `size(mz) - size(vd)` in `figure6.m` replaced with scalar `size(...,1)` indexing
