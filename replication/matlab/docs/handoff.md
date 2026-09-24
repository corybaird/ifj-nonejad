# Replication Review Handoff Document

## Table of Contents
* 1.1 Project Overview
* 1.2 Runtime Environment and Engine Attachment
* 1.3 Repository Architecture and Boundaries
* 1.4 Replication Scope and Audit Status
* 1.5 Key Algorithmic Mechanics and Performance
* 1.6 Identified Edge Cases and Applied Fixes
* 1.7 Verification Protocol for Reviewing Agent

---

## 1.1 Project Overview
* Target manuscript: *A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil* (Nonejad, *International Journal of Forecasting*, 2026)
* Core objective: Independent replication of empirical results, figures, tables, and computational pipelines
* Review target: Validate reproduced assets against original publication artifacts

---

## 1.2 Runtime Environment and Engine Attachment
* Python manager: `/opt/homebrew/bin/uv`
* Python version: Python 3.13 in workspace `.venv`
* Environment configuration: [`pyproject.toml`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/pyproject.toml) and [`uv.toml`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/uv.toml)
* MATLAB Engine source: `/Applications/MATLAB_R2025b.app/extern/engines/python`
* Shared MATLAB session name: `'MATLAB_925'`
* IPC requirement: Commands connecting to shared MATLAB engine require sandbox bypass for inter-process socket communication

---

## 1.3 Repository Architecture and Boundaries
* Strict boundary constraint: Directory [`original_files/`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/original_files) is strictly read-only
* Editable workspace: All replication activities confined to [`replication/matlab/`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab)
* Directory layout:
  * `code/functions/`: Reusable econometric helpers, `combvec.m` and `replication_setting.m`
  * `code/replication_of_submission/`: Main text estimation and plotting scripts plus `wti_k.mat` outputs
  * `code/replication_of_supplementary_material/`: Supplementary robustness scripts plus their `.mat` outputs
  * `data/`: Shipped FRED-MD inputs (`mx.xls`), oil series and CPI (`my.xls`), state trackers (`mz.xls`), recessions (`usrec.xls`)
  * `reports/results/`: Upstream baseline spreadsheet (`results.xls`) and timestamped `runs/`
  * `reports/plots/`: Reference `.fig` files, reference PNGs (`*_reference.png`) and reproduced PNGs (`*_reproduced.png`)
  * `pipelines_python/`: `replication_runner.py`, `replication_runs.yaml`, `run_example.py`
  * `docs/`: Upstream `readme.txt`, audit logs, guides, and the discrepancy tracker
* Path handling: every MATLAB script derives paths from `mfilename('fullpath')`; no manual `addpath` needed

---

## 1.4 Replication Scope and Audit Status
* **Record of truth:** `reports/results/runs/replication_run_20260924_151805/` (61 MATLAB jobs, all exit 0, deterministic across three runs)
* **Runner:** `uv run python -m replication.matlab.pipelines_python.replication_runner` from project root; run matrix in `pipelines_python/replication_runs.yaml`
* **Discrepancy tracker:** [`docs/replication/discrepancies.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/discrepancies.md)
* **Toolbox Decoupling:** Added [`code/functions/combvec.m`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/code/functions/combvec.m) eliminating Deep Learning Toolbox requirement
* **Estimation stage:** `main.m` output matches the author-shipped `wti_4.mat` to about 1e-8
* **Numerical match against `results.xls` (all sheet columns, both toggles):**

| Block | Share matching at 4 dp | Max abs diff | Verdict |
|---|---|---|---|
| Table 1_supp | 100% | 5e-5 | Exact |
| Figure 9_supp | 100% | 4e-5 | Exact |
| Figure 1_supp | 99.5% to 100% | 4.6e-3 | Exact except 11 cells |
| Figures 1, 4, 5, 7 (main text) | 57% to 100% | 1.9e-2 | Close; no conclusion flips |
| Figures 2_supp, 3_supp, 5_supp, 6_supp, 7_supp | 0% to 94% | 3.7e-3 | Close; no conclusion flips |
| Figure 4_supp (real price) | 0% | 0.22 | Does not replicate; 19 conclusion flips |

* **Figures:** Figures 1, 4, 5, 7 and 1_supp to 7_supp plot directly from `results.xls`; their PNGs validate plotting code only. Figures 2, 3, 6, 8_supp and 9_supp panels (c) and (d) are recomputed from `.mat` files
* **Impact on findings:** No main text conclusion changes. Figure 4_supp keeps TU < 1 for all predictors but the set significant at 5% differs

---

## 1.5 Key Algorithmic Mechanics and Performance
* Algorithmic class: Recursive Least Squares (RLS) with Dynamic Model Averaging (DMA) and Beta-Binomial conjugate updating
* Contrast with DSGE MCMC: No Metropolis-Hastings Markov chains or sampling proposals; updates are deterministic analytical recursions
* Execution latency:
  * Per job wall time including MATLAB startup: 6 to 46 seconds (`main.m` and `main_real.m` slowest)
  * Complete run matrix (61 jobs, 6 workers): about 3 minutes

---

## 1.6 Identified Edge Cases and Applied Fixes
* **Dummy Marker Filtering:** Sheets `figure1`, `figure4`, `figure5`, `figure2_supp` to `figure6_supp` contain dummy row 19; scripts use `mc = mc(1:18, :)`
* **Modern MATLAB Indexing:** `figure6.m` uses `size(mz,1) - size(vd,1)` instead of `size(mz) - size(vd)`
* **Random Stream Compatibility:** `setDefaultStream` replaced with `setGlobalStream`, including `main_sim.m`
* **Toggle Overrides:** `code/functions/replication_setting.m` reads `REPL_<NAME>` environment variables (`vend`, `ir`, `da0`, `db0`, `dg`, `ih`, `dlam`, `real_k`, `prior_idx`, `sim_idx`); defaults reproduce upstream behavior
* **Upstream File Name Mismatches:** `figure4_supp_computation.m`, `figure7_supp_computation.m`, `figure9_supp_computation.m` and `main_sim.m` fixed (see tracker R1 to R4)
* **Prior Grid:** g grid corrected to {0.05, 0.5, 5, 50, 100} per `figure7_supp.fig`
* **Reference Protection:** Supplementary figure scripts save `_reproduced.fig`; reference `.fig` files restored from `original_files/`
* **Figure 9_supp:** Local rewrite that pasted over the reference `.fig` replaced by the upstream script, so panels (c) and (d) are recomputed from `exp_1.mat`

---

## 1.7 Verification Protocol for Reviewing Agent
1. Verify git cleanliness with `git status` and `git diff`
2. Rerun the full matrix: `/opt/homebrew/bin/uv run python -m replication.matlab.pipelines_python.replication_runner` (about 3 minutes; MATLAB calls need sandbox bypass)
3. Confirm the new `replication_summary_*.csv` matches the record of truth in section 1.4
4. Review open items D1 to D8 in `docs/replication/discrepancies.md`
