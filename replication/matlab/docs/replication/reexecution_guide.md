# MATLAB Pipeline Re-Execution Guide and Runbook

## 1. Table of Contents
* 1.1 Environment Setup and Prerequisites
* 1.2 Quickstart Spot Check (wti_4.mat)
* 1.3 Full Manuscript Figures Pipeline Runbook
* 1.4 Supplementary Material Pipeline Runbook
* 1.5 Compatibility Notes for Modern MATLAB Versions

---

## 1.1 Environment Setup and Prerequisites
* Preferred environment: MATLAB R2009b with Econometrics Toolbox
* Supported modern environment: MATLAB R2025b (macOS 15, Apple Silicon)
* Required directories on MATLAB search path:
  * `replication/matlab/data`
  * `replication/matlab/functions`
  * `replication/matlab/replication_of_submission`
  * `replication/matlab/replication_of_supplementary_material`

---

## 1.2 Quickstart Spot Check (wti_4.mat)
* Step 1: Navigate to `replication/matlab/replication_of_submission`
* Step 2: Open and execute `main_example.m`:
  * Solves RLS and Dynamic Forecast Rotation for predictor `k=4` (Petroleum tracker)
  * Generates `wti_4.mat` (~15 MB) in ~30 seconds
* Step 3: Run `figure1_computation_example.m`:
  * Outputs 1x3 vector `mquant`
  * Corresponds exactly to row 4, columns 1 to 3 in sheet `figure1` of `results/results.xls`

---

## 1.3 Full Manuscript Figures Pipeline Runbook
* Full model estimation:
  * Open `replication_of_submission/main.m`
  * Run master script generating all 18 `wti_k.mat` files ($k \in \{1..11, 13..19\}$)
  * Estimated runtime: ~25 minutes on Apple M4 Pro
* Figure generation:
  * Figure 1: Run `figure1_computation.m` with `vend=202412` then `vend=201912`; plot with `figure1.m`
  * Figure 2: Run `figure2.m` directly after `main.m`
  * Figure 3: Run `figure3.m` directly after `main.m`
  * Figure 4: Run `figure4_computation.m` with `ir=0` then `ir=1`; plot with `figure4.m`
  * Figure 5: Run `figure5_computation.m` with `ir=0` then `ir=1`; plot with `figure5.m`
  * Figure 6: Run `figure6.m` directly after `main.m`
  * Figure 7: Run `figure7_computation.m` with `vend=202412` then `vend=201912`; plot with `figure7.m`

---

## 1.4 Supplementary Material Pipeline Runbook
* Table 1_supp: Execute `main_sma_bma.m`, `main_reg.m`, then `table1_supp.m`
* Figure 1_supp: Run `main_sim.m` for `dlam` in $\{1, 1.5, 0.5\}$; plot via `figure1_supp.m`
* Figures 2_supp to 7_supp: Execute respective computation scripts then call plot scripts
* Figure 8_supp: Run `main_brent.m`, `main_rac.m`, then `figure8_supp.m`
* Figure 9_supp: Execute `main_for.m` for `ih` in $\{2, 3, 4, 9\}$, `main_exp.m`, then `figure9_supp.m`

---

## 1.5 Compatibility Notes for Modern MATLAB Versions
* Random stream initialization:
  * Replace `RandStream.setDefaultStream(mtstream)` with `RandStream.setGlobalStream(mtstream)`
* Excel reading:
  * Modern MATLAB emits deprecation notices for `xlsread`
  * `readmatrix` or `readtable` functions provide modern replacements
* Path separators:
  * Code utilizes standard forward slashes compatible across macOS and Windows
