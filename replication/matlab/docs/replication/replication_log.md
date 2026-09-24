# Replication Audit Log and Output Accounting

## 1. Table of Contents
* 1.1 Master Artifact Ledger
* 1.2 Manuscript Figures Verification Status
* 1.3 Supplementary Figures Verification Status
* 1.4 Supplementary Table Verification Status
* 1.5 Numerical Benchmark Discrepancy Accounting

---

## 1.1 Master Artifact Ledger
* Total manuscript figures audited: 7
* Total supplementary figures audited: 9
* Total supplementary tables audited: 1
* Reference results file: `reports/results/results.xls`
* Record of truth: `reports/results/runs/replication_run_20260924_151805/`
* Discrepancy tracker: `docs/replication/discrepancies.md`

---

## 1.2 Manuscript Figures Verification Status

| Artifact | Source Script | Reference Fig | Verification Status | Notes |
|---|---|---|---|---|
| Figure 1 | `figure1_computation.m` | `figure1.fig` | Close | All 6 columns rerun; max diff 9e-4; no conclusion flips |
| Figure 2 | `figure2.m` | `figure2.fig` | Verified from `main.m` outputs | Subplots (3,2,5) and (3,2,6) require manual bar conversion |
| Figure 3 | `figure3.m` | `figure3.fig` | Verified from `main.m` outputs | Line to bar graphical formatting applied in published version |
| Figure 4 | `figure_4_computation.m` | `figure4.fig` | Close | ir = 0 and 1 rerun; max diff 3.4e-3 (D5); no conclusion flips |
| Figure 5 | `figure5_computation.m` | `figure5.fig` | Close | ir = 0 and 1 rerun; max diff 7.4e-3 (D4); no conclusion flips |
| Figure 6 | `figure6.m` | `figure6.fig` | Verified from `main.m` outputs | Gray shading denotes true positive predictability windows |
| Figure 7 | `figure7_computation.m` | `figure7.fig` | Close | Both samples rerun; max diff 1.9e-2 in 2 cells (D3); no conclusion flips |

---

## 1.3 Supplementary Figures Verification Status

| Artifact | Source Script | Reference Fig | Verification Status | Notes |
|---|---|---|---|---|
| Figure 1_supp | `main_sim.m`, `figure1_supp_computation.m` | `figure1_supp.fig` | Exact except 11 cells | 420x21 across $\lambda \in \{1, 1.5, 0.5\}$; λ = 1 block max diff 4.6e-3 (D6) |
| Figure 2_supp | `figure2_supp_computation.m` | `figure2_supp.fig` | Close | Both samples; max diff 6e-4 |
| Figure 3_supp | `figure3_supp_computation.m` | `figure3_supp.fig` | Close | Both samples; max diff 8e-4 |
| Figure 4_supp | `main_real.m`, `figure4_supp_computation.m` | `figure4_supp.fig` | **Does not replicate** | Real price; max diff 0.22; 19 conclusion flips; TU < 1 holds (D1) |
| Figure 5_supp | `figure5_supp_computation.m` | `figure5_supp.fig` | Close | Both samples; max diff 9e-4 |
| Figure 6_supp | `figure6_supp_computation.m` | `figure6_supp.fig` | Close | All 4 Beta priors; max diff 6e-4 |
| Figure 7_supp | `main_prior.m`, `figure7_supp_computation.m` | `figure7_supp.fig` | Close | $g \in \{0.05, 0.5, 5, 50, 100\}$; g = 5 row max diff 3.7e-3 (D2) |
| Figure 8_supp | `figure8_supp.m` | `figure8_supp.fig` | Visual match (b), (d) | Recomputed from `brent_1.mat`, `rac_1.mat`; (a), (c) axis scaling differs (D8) |
| Figure 9_supp | `main_for.m`, `figure9_supp_computation.m`, `main_exp.m` | `figure9_supp.fig` | Exact | $h \in \{2, 3, 4, 9\}$; max diff 4e-5; panels (c), (d) recomputed from `exp_1.mat` |

---

## 1.4 Supplementary Table Verification Status

| Artifact | Source Script | Reference Sheet | Verification Status | Notes |
|---|---|---|---|---|
| Table 1_supp | `table1_supp.m` | `table1_supp` | Exact | Both samples; max diff 5e-5 |

---

## 1.5 Numerical Benchmark Discrepancy Accounting
* 1,056 non-simulation cells and 8,820 simulation cells compared against `results.xls`
* 19 conclusion flips (p-value crossing 1%, 5% or 10%), all in Figure 4_supp
* No TU ratio crosses 1 in any block
* Estimation stage matches the author-shipped `wti_4.mat` to about 1e-8; remaining drift enters after estimation
* Full itemization in `docs/replication/discrepancies.md`
