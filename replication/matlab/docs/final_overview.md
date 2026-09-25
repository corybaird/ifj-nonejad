# Econometric Replication: Final Overview and Comprehensive Sanity Check

## 1. Table of Contents
* 1.1 Executive Summary
* 1.2 Topline Reproducibility Findings
* 1.3 Key Econometric Hypotheses and Empirical Results
* 1.4 Methodology and Computational Pipeline
* 1.5 Discrepancies in Plain Terms
* 1.6 Upstream Code Package Review and Friction Points
* 1.7 Documentation Roadmap and Sub-Document Index

---

## 1.1 Executive Summary
* Target manuscript: *A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil* (Nonejad, *IJF*, IJF-D-26-00175R3)
* Package location: `replication/matlab/`
* Source reference: `original_files/ijfr/` (strictly read-only)
* Computing environment: Apple M4 Pro (macOS 15), MATLAB R2025b with Econometrics Toolbox

---

## 1.2 Topline Reproducibility Findings
* Core claim evaluated: Combining Bayesian beta-binomial learning with dynamic forecast rotation outperforms the Ellwanger and Snudden (2023) random-walk benchmark
* Verification tiers:
  * Tier 0 (Published benchmark comparison): Every `results.xls` sheet regenerated in `reports/results/runs/replication_run_20260924_151805/`; main text close with no conclusion flips; Figure 4_supp does not replicate (section 1.5)
  * Tier 1 (Example re-execution): `main_example.m` and `figure1_computation_example.m` execute cleanly, reproducing row 4 of `results.xls` to within 2e-4 (DM p-value 0.0649 vs 0.0651)
  * Tier 2 (Full re-estimation from raw data): 18 monitoring variables across 1986m1 to 2024m12
* Upstream integrity: Excel reference files and `.fig` figures provide complete ground truth

---

## 1.3 Key Econometric Hypotheses and Empirical Results
* Predictability windows: Outperformance clusters around business, macroeconomic, financial, and geopolitical shocks
* Theil's U ratios: Systematic point forecast MSE reductions below 1.00 relative to random-walk benchmark
* Statistical significance: Clark and West (2007) and Diebold and Mariano (1995) tests confirm statistical edge
* Economic value: Positive annualized Sharpe ratio gains and reduced downside regulatory loss across 18 monitoring variables

---

## 1.4 Methodology and Computational Pipeline
* Predictand: Monthly log difference and end-of-month spot price of WTI crude oil (`my.xls`)
* Regression predictors: Economic series from FRED-MD (`mx.xls`, sheet `Ark1`)
* Base estimation: Dynamic Linear Models (DLM) estimated via Recursive Least Squares with forgetting factors ($\lambda$, $g$)
* Dynamic rotation: Extreme-value threshold triggers (Zhu and Timmermann 2022) with 18 monitoring trackers (`mz.xls`)
* Combination weights: Bayesian beta-binomial conjugate probability learning with hyperparameter grid averaging

---

## 1.5 Discrepancies in Plain Terms
* Nearly everything matches. The full comparison against the author's published benchmark spreadsheet covers roughly 10,000 numbers; the main text figures and table agree to within tiny numerical drift, and not a single statistical conclusion changes.
* One supplementary check does not replicate. The real-price robustness exercise (Figure 4_supp) produces meaningfully different significance counts, most likely because the consumer price index vintage in the shipped data differs from the one used to build the published benchmark. Its qualitative message still holds: the algorithm beats the random-walk benchmark for every predictor in both samples.
* Nothing suggests a problem with the author's code or conclusions. The remaining gaps are consistent with the benchmark spreadsheet having been generated from a slightly different code or data state than the one shipped; all upstream code bugs found during the audit were minor and are listed with their fixes in the replication log.
* Technical detail, severity ratings, and the full open/resolved item list: [`replication/replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md) (section 1.6).

---

## 1.6 Upstream Code Package Review and Friction Points
* Hardcoded paths: Scripts in subfolders rely on `addpath('functions')` and `addpath('data')`, requiring explicit directory adjustments
* Manual Excel transfer: Several computational routines output matrices meant to be copied manually into `results.xls` before running plot scripts
* Deprecated stream calls: Code employs `RandStream.setDefaultStream`, requiring `RandStream.setGlobalStream` under modern MATLAB releases
* Figure formatting: Reference `.fig` graphics reflect manual axis tick and bar styling adjustments noted in `readme.txt`

---

## 1.7 Documentation Roadmap and Sub-Document Index
* Fast navigation index: [`quickstart_docs.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/quickstart_docs.md)
* Theoretical DAG and solvers: [`architecture/architecture.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/architecture.md)
* Empirical claims and artifact crosswalk: [`architecture/claims.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/claims.md)
* Time series data catalog: [`architecture/data.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/data.md)
* Technical record of the audit (artifact ledger, verification status, discrepancy tracker, re-execution runbook): [`replication/replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md)
* Visual comparison audit: [`replication/figures.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/figures.md)
* Manuscript draft audit: [`sanity_draft_check.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/sanity_draft_check.md)
