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
* Reference results file: `results/results.xls`

---

## 1.2 Manuscript Figures Verification Status

| Artifact | Source Script | Reference Fig | Verification Status | Notes |
|---|---|---|---|---|
| Figure 1 | `figure1.m` | `figure1.fig` | Verified against `results.xls` | Numerical values match sheet `figure1` columns 1-6 |
| Figure 2 | `figure2.m` | `figure2.fig` | Verified from `main.m` outputs | Subplots (3,2,5) and (3,2,6) require manual bar conversion |
| Figure 3 | `figure3.m` | `figure3.fig` | Verified from `main.m` outputs | Line to bar graphical formatting applied in published version |
| Figure 4 | `figure4.m` | `figure4.fig` | Verified against `results.xls` | Numerical values match sheet `figure4` columns 1-6 |
| Figure 5 | `figure5.m` | `figure5.fig` | Verified against `results.xls` | Numerical values match sheet `figure5` columns 1-6 |
| Figure 6 | `figure6.m` | `figure6.fig` | Verified from `main.m` outputs | Gray shading denotes true positive predictability windows |
| Figure 7 | `figure7.m` | `figure7.fig` | Verified against `results.xls` | Numerical values match sheet `figure7` columns 1-4 |

---

## 1.3 Supplementary Figures Verification Status

| Artifact | Source Script | Reference Fig | Verification Status | Notes |
|---|---|---|---|---|
| Figure 1_supp | `figure1_supp.m` | `figure1_supp.fig` | Verified against `results.xls` | Monte Carlo output matrix 420x21 across $\lambda \in \{1, 1.5, 0.5\}$ |
| Figure 2_supp | `figure2_supp.m` | `figure2_supp.fig` | Verified against `results.xls` | Lags $p \in \{2, 3\}$ sensitivity metrics |
| Figure 3_supp | `figure3_supp.m` | `figure3_supp.fig` | Verified against `results.xls` | Alternative horizons $h \in \{3, 6, 12\}$ |
| Figure 4_supp | `figure4_supp.m` | `figure4_supp.fig` | Verified against `results.xls` | Real crude oil price target series |
| Figure 5_supp | `figure5_supp.m` | `figure5_supp.fig` | Verified against `results.xls` | Rolling estimation windows (10-year and 15-year) |
| Figure 6_supp | `figure6_supp.m` | `figure6_supp.fig` | Verified against `results.xls` | Beta prior parameters $(a_0, b_0) \in \{(0.1, 0.1), (2, 2), (20, 1), (20, 0.1)\}$ |
| Figure 7_supp | `figure7_supp.m` | `figure7_supp.fig` | Verified against `results.xls` | Variance parameter $g \in \{0.005, 0.05, 5, 50, 100\}$ |
| Figure 8_supp | `figure8_supp.m` | `figure8_supp.fig` | Verified from model `.mat` files | Brent spot and refiner acquisition cost (RAC) series |
| Figure 9_supp | `figure9_supp.m` | `figure9_supp.fig` | Verified against `results.xls` | Forecast horizons $h \in \{2, 3, 4, 9\}$ |

---

## 1.4 Supplementary Table Verification Status

| Artifact | Source Script | Reference Sheet | Verification Status | Notes |
|---|---|---|---|---|
| Table 1_supp | `table1_supp.m` | `table1_supp` | Verified against `results.xls` | Simple model averaging (SMA) and Bayesian model averaging (BMA) comparison |

---

## 1.5 Numerical Benchmark Discrepancy Accounting
* Zero numerical discrepancies detected between generated computation scripts and `results.xls` values
* All test statistics (Clark-West and Diebold-Mariano) reproduce to published decimal precision
* Minor graphical formatting differences (font weights, tick marks, bar vs line presentation) reflect post-processing adjustments documented in `readme.txt`
