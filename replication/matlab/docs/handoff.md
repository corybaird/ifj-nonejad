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
  * `functions/`: Reusable econometric helpers and decoupled toolbox functions
  * `data/`: Shipped FRED-MD inputs (`mx.xls`), oil series (`my.xls`), and state trackers (`mz.xls`)
  * `results/`: Upstream baseline spreadsheet (`results.xls`)
  * `plots/`: Side-by-side reference PNGs (`*_reference.png`) and reproduced PNGs (`*_reproduced.png`)
  * `replication_of_submission/`: Main text estimation and plotting scripts
  * `replication_of_supplementary_material/`: Supplementary robustness estimation and plotting scripts
  * `docs/replication/`: Audit logs, guides, and visual verification tables

---

## 1.4 Replication Scope and Audit Status
* **Toolbox Decoupling:** Added [`functions/combvec.m`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/functions/combvec.m) eliminating Deep Learning Toolbox requirement
* **Manuscript Pipeline (`replication_of_submission/`):**
  * `main.m`: Full execution completed; 18 state models (`wti_1.mat` to `wti_19.mat`) generated
  * Computational routines: `figure1_computation.m`, `figure_4_computation.m`, `figure5_computation.m`, `figure7_computation.m` match `results.xls`
  * Manuscript Figures 1 through 7: 100% reproduced and verified
* **Supplementary Pipeline (`replication_of_supplementary_material/`):**
  * Script figures: Figures 1_supp through 7_supp, and 9_supp (panels a-b) reproduced and verified
  * Table 1_supp: Executed via `table1_supp.m`; matches `results.xls` sheet `table1_supp` to 4 decimal places
  * Benchmark figures: Figures 8_supp and 9_supp (panels c-d) visually verified against reference assets
* **Visual Audit Guide:** [`docs/replication/figures.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/figures.md) contains side-by-side visual comparisons for all 16 figures

---

## 1.5 Key Algorithmic Mechanics and Performance
* Algorithmic class: Recursive Least Squares (RLS) with Dynamic Model Averaging (DMA) and Beta-Binomial conjugate updating
* Contrast with DSGE MCMC: No Metropolis-Hastings Markov chains or sampling proposals; updates are deterministic analytical recursions
* Execution latency:
  * Individual script execution: 0.5 to 3.7 seconds per routine
  * Complete repository end-to-end execution: Under 2.5 minutes sequentially
  * Parallel execution potential: Sub-30 seconds across performance cores

---

## 1.6 Identified Edge Cases and Applied Fixes
* **Dummy Marker Filtering:**
  * Excel sheets (`figure1`, `figure4`, `figure5`, `figure2_supp` through `figure6_supp`) contain dummy row 19 (`1.2`) with label `"Yellow is to help make plot easier"`
  * Scripts updated with `mc = mc(1:18, :)` to prevent plot scaling distortions
* **Modern MATLAB Indexing:**
  * In `figure6.m`, `size(mz) - size(vd)` produces a 2D vector, breaking scalar colon indexing in R2025b
  * Fixed to `size(mz,1) - size(vd,1)`
* **Random Stream Compatibility:**
  * Replaced deprecated `RandStream.setDefaultStream` with `RandStream.setGlobalStream`
* **Path Auto-Resolution:**
  * Replaced hardcoded relative folder calls with robust dynamic search path detection

---

## 1.7 Verification Protocol for Reviewing Agent
1. Verify git cleanliness: `git status` reports clean working tree on branch `main`
2. Inspect visual comparisons: Review side-by-side tables in [`docs/replication/figures.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/figures.md)
3. Validate numerical tables: Run `table1_supp.m` in MATLAB and compare `mquant` against `results.xls` sheet `table1_supp`
4. Validate figure reproduction: Execute any `figure*.m` script and compare generated plot with corresponding `*_reference.png`
