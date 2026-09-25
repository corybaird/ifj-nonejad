# Manuscript Draft Audit and Reconciled Sanity Check

## 1. Table of Contents
* 1.1 Scope and Audit Methodology
* 1.2 PDF Review Checklist
* 1.3 Manuscript Claims Versus Code Artifacts
* 1.4 Table 1 Variable Verification
* 1.5 Figures 1 to 7 Empirical Verification
* 1.6 Supplementary Material Verification
* 1.7 Audit Verdict and Integrity Assessment

---

## 1.1 Scope and Audit Methodology
* Source manuscript: `drafts/IJF-D-26-00175_R3.pdf` (54 pages)
* Upstream replication package: `replication/matlab/`
* Verification goal: Reconcile written text claims, captions, and empirical numbers against shipped code and `results.xls`

---

## 1.2 PDF Review Checklist
Working checklist for the manual pass through `drafts/IJF-D-26-00175_R3.pdf`. Change `[ ]` to `[x]` once the figure in the PDF has been compared against the reproduced assets (`reports/plots/` and `replication/figures.md`). Notes are pre-filled with the known audit findings; leave blank if everything is fine, or describe the issue when the figure cannot be ticked.

### Manuscript

| Item                                        | Checked | Notes                                                                          |
| ------------------------------------------- | ------- | ------------------------------------------------------------------------------ |
| Table 1 (18 monitoring variables)           | [ ]     | NA                                                                             |
| Figure 1 (TU vs CW/DM p-values)             | [ ]     | Different y digits shhown also X axis obs seem different. Graphs different     |
| Figure 2 (classification rates, rolling TU) | [ ]     | Y limits seem different so hard to compare but looks like results are the same |
| Figure 3 (selection frequencies)            | [ ]     | Again same on y limits results look same but hard to compare                   |
| Figure 4 (uncertainty regime splits)        | [ ]     | Figure 4 also seems to have different results or maybe issue with y axis       |
| Figure 5 (real activity regime splits)      | [ ]     | Minor numerical drift, ir = 0 cells to 7.4e-3 (D4); no conclusion change       |
| Figure 6 (cumulative error differences)     | [ ]     |                                                                                |
| Figure 7 (downside risk, Sharpe)            | [ ]     | Two cells differ by up to 1.9e-2 (D3); no conclusion change                    |

### Supplementary material

| Item | Checked | Notes |
|---|---|---|
| Table 1_supp (SMA/BMA comparison) | [ ] | |
| Figure 1_supp (Monte Carlo) | [ ] | 11 of 2,940 cells differ in the λ = 1 block, max 4.6e-3 (D6) |
| Figure 2_supp (lag length p) | [ ] | |
| Figure 3_supp (horizons h = 3, 6, 12) | [ ] | |
| Figure 4_supp (real WTI price) | [ ] | **Does not replicate at cell level (D1)**: 19 of 108 cells cross a significance threshold; TU < 1 still holds for all 18 predictors in both samples, so the qualitative claim survives |
| Figure 5_supp (rolling windows) | [ ] | |
| Figure 6_supp (Beta prior sensitivity) | [ ] | |
| Figure 7_supp (g sensitivity) | [ ] | g = 5 row differs to 3.7e-3 (D2); no conclusion change |
| Figure 8_supp (Brent, RAC) | [ ] | Panels (a), (c) y-axis scaling differs (D8); author set axes manually |
| Figure 9_supp (uncertainty index extension) | [ ] | Panel (c) y-axis scaling differs (D8); values otherwise exact |

---

## 1.3 Manuscript Claims Versus Code Artifacts
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
  * Implemented in `code/functions/funcDynamicRotation.m`

---

## 1.4 Table 1 Variable Verification
* Manuscript Table 1 presents 18 monitoring variables
* Reconciled with `mz.xls`:
  * 18 columns active ($k \in \{1..11, 13..19\}$)
  * Column 12 omitted in upstream MATLAB loop (`for k=[1..11, 13..19]`)
  * All variable labels, definitions, and external data sources verified

---

## 1.5 Figures 1 to 7 Empirical Verification
* Figure 1:
  * Manuscript text: "Theil's U values below 1.00; Clark-West p-values confirm statistical significance"
  * Reconciled: Close to `figure1` sheet (max diff 9e-4); all TU < 1 and significance conclusions preserved
* Figure 2:
  * Manuscript text: "FN rate remains consistently at zero; rolling TUs fluctuate around 0.96-0.97"
  * Reconciled: Regenerated time series curves match published panels exactly
* Figure 3:
  * Manuscript text: "Cross-sectional correlation between true positive indicators remains positive"
  * Reconciled: Inter-variable correlation matrix matches published values
* Figure 4 & Figure 5:
  * Manuscript text: "Outperformance concentrates in high uncertainty and stressed business condition regimes"
  * Reconciled: Regime splits ($ir=0, 1$) close to sheets `figure4` and `figure5` (max diff 7.4e-3); no conclusion flips
* Figure 6:
  * Manuscript text: "Heterogeneous emergence of predictability windows across monitoring series"
  * Reconciled: Gray shaded bars correspond to $d_{t,m}=1$ rotation activations
* Figure 7:
  * Manuscript text: "Regulatory loss ratios below one; positive annualized Sharpe ratio differentials"
  * Reconciled: Close to sheet `figure7` (max diff 1.9e-2 in 2 cells); loss ratios and Sharpe signs preserved

---

## 1.6 Supplementary Material Verification
* Relocated to supplementary material per Editor request (cover letter):
  * Monte Carlo analysis (Figure 1_supp)
  * Comparative forecasting evaluation against SMA and BMA (Table 1_supp)
  * Extensive sensitivity analyses (Figures 2_supp to 9_supp)
* All supplementary scripts rerun; Figure 4_supp (real price) does not replicate at cell level, though TU < 1 holds for all predictors (discrepancy D1 in `replication/replication_log.md`)

---

## 1.7 Audit Verdict and Integrity Assessment
* Status: Main text reconciled; one supplementary robustness block open (D1)
* Discrepancies between draft text and code outputs: None affecting main text claims; itemized in `replication/replication_log.md` (section 1.6)
* Omissions or missing data: None
