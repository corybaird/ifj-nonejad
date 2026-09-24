# Manuscript Draft Audit and Reconciled Sanity Check

## 1. Table of Contents
* 1.1 Scope and Audit Methodology
* 1.2 Manuscript Claims Versus Code Artifacts
* 1.3 Table 1 Variable Verification
* 1.4 Figures 1 to 7 Empirical Verification
* 1.5 Supplementary Material Verification
* 1.6 Audit Verdict and Integrity Assessment

---

## 1.1 Scope and Audit Methodology
* Source manuscript: `drafts/IJF-D-26-00175_R3.pdf` (54 pages)
* Upstream replication package: `replication/matlab/`
* Verification goal: Reconcile written text claims, captions, and empirical numbers against shipped code and `results.xls`

---

## 1.2 Manuscript Claims Versus Code Artifacts
* Title: *A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil*
* Author: Nima Nonejad (Nordea's Artificial Intelligence Model Risk Unit)
* Predictand definition:
  * Manuscript states monthly WTI crude oil price and log differences
  * Confirmed in `my.xls` column 3 and `main.m` line 48
* Benchmark model:
  * Manuscript cites Ellwanger and Snudden (2023) end-of-month random-walk model
  * Confirmed in `main.m` lines 73 and 90-91
* Algorithmic mechanism:
  * Dynamic forecast rotation citing Zhu and Timmermann (2022)
  * Implemented in `functions/funcDynamicRotation.m`

---

## 1.3 Table 1 Variable Verification
* Manuscript Table 1 presents 18 monitoring variables
* Reconciled with `mz.xls`:
  * 18 columns active ($k \in \{1..11, 13..19\}$)
  * Column 12 omitted in upstream MATLAB loop (`for k=[1..11, 13..19]`)
  * All variable labels, definitions, and external data sources verified

---

## 1.4 Figures 1 to 7 Empirical Verification
* Figure 1:
  * Manuscript text: "Theil's U values below 1.00; Clark-West p-values confirm statistical significance"
  * Reconciled: Matches `figure1` sheet in `results.xls`
* Figure 2:
  * Manuscript text: "FN rate remains consistently at zero; rolling TUs fluctuate around 0.96-0.97"
  * Reconciled: Regenerated time series curves match published panels exactly
* Figure 3:
  * Manuscript text: "Cross-sectional correlation between true positive indicators remains positive"
  * Reconciled: Inter-variable correlation matrix matches published values
* Figure 4 & Figure 5:
  * Manuscript text: "Outperformance concentrates in high uncertainty and stressed business condition regimes"
  * Reconciled: Regime splits ($ir=0, 1$) match sheets `figure4` and `figure5`
* Figure 6:
  * Manuscript text: "Heterogeneous emergence of predictability windows across monitoring series"
  * Reconciled: Gray shaded bars correspond to $d_{t,m}=1$ rotation activations
* Figure 7:
  * Manuscript text: "Regulatory loss ratios below one; positive annualized Sharpe ratio differentials"
  * Reconciled: Matches sheet `figure7` in `results.xls`

---

## 1.5 Supplementary Material Verification
* Relocated to supplementary material per Editor request (cover letter):
  * Monte Carlo analysis (Figure 1_supp)
  * Comparative forecasting evaluation against SMA and BMA (Table 1_supp)
  * Extensive sensitivity analyses (Figures 2_supp to 9_supp)
* All supplementary scripts present and verified in `replication_of_supplementary_material/`

---

## 1.6 Audit Verdict and Integrity Assessment
* Status: Reconciled and verified
* Discrepancies between draft text and code outputs: Zero
* Omissions or missing data: None
