# Econometric Replication: Final Overview and Comprehensive Sanity Check

## 1. Table of Contents
* 1.1 Executive Summary
* 1.2 Topline Reproducibility Findings
* 1.3 Key Econometric Hypotheses and Empirical Results
* 1.4 Methodology and Computational Pipeline
* 1.5 Upstream Code Package Review and Friction Points
* 1.6 Documentation Roadmap and Sub-Document Index

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
  * Tier 0 (Published benchmark comparison): Figures 1 to 7 and supplementary figures match `results/results.xls` numerical baselines
  * Tier 1 (Example re-execution): `main_example.m` and `figure1_computation_example.m` execute cleanly, reproducing row 4 of `results.xls`
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

## 1.5 Upstream Code Package Review and Friction Points
* Hardcoded paths: Scripts in subfolders rely on `addpath('functions')` and `addpath('data')`, requiring explicit directory adjustments
* Manual Excel transfer: Several computational routines output matrices meant to be copied manually into `results.xls` before running plot scripts
* Deprecated stream calls: Code employs `RandStream.setDefaultStream`, requiring `RandStream.setGlobalStream` under modern MATLAB releases
* Figure formatting: Reference `.fig` graphics reflect manual axis tick and bar styling adjustments noted in `readme.txt`

---

## 1.6 Documentation Roadmap and Sub-Document Index
* Fast navigation index: [`quickstart_docs.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/quickstart_docs.md)
* Theoretical DAG and solvers: [`architecture/architecture.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/architecture.md)
* Empirical claims and artifact crosswalk: [`architecture/claims.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/claims.md)
* Time series data catalog: [`architecture/data.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/data.md)
* Complete table and figure ledger: [`replication/replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md)
* Pipeline execution runbook: [`replication/reexecution_guide.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/reexecution_guide.md)
* Visual comparison audit: [`replication/figures.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/figures.md)
* Manuscript draft audit: [`sanity_draft_check.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/sanity_draft_check.md)
