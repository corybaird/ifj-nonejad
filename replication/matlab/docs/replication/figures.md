# Figure Sanity Check: Original vs Reproduced

## Table of Contents
* 1.1 Audit Methodology
* 1.2 Manuscript Figures Comparison (Figures 1 to 7)
* 1.3 Supplementary Figures Comparison (Figures 1_supp to 9_supp)
* 1.4 Verification Summary Tally

---

## 1.1 Audit Methodology
* Reference sources: Original figures extracted directly from `original_files/ijfr/plots/`
* Reproduced sources: Figures regenerated via standalone MATLAB scripts under `replication/matlab/`
* Image format: Direct PNG exports at native resolution
* MCMC protocol: Full parameter re-estimation bypassed per protocol; precomputed state matrices utilized

---

## 1.2 Manuscript Figures Comparison (Figures 1 to 7)

| Manuscript Figure | Original Asset | Reproduced Asset | Numerical & Structural Notes | Figure Source File |
| :--- | :--- | :--- | :--- | :--- |
| **Figure 1** | ![orig](../../plots/figure1_reference.png) | ![repro](../../plots/figure1_reproduced.png) | Scatter of TU vs CW/DM p-values; points match `results.xls` within Excel 4-decimal precision | `replication_of_submission/figure1.m` |
| **Figure 2** | ![orig](../../plots/figure2_reference.png) | ![repro](../../plots/figure2_reproduced.png) | Multi-panel time series of posterior model probabilities and recession bands | `replication_of_submission/figure2.m` |
| **Figure 3** | ![orig](../../plots/figure3_reference.png) | ![repro](../../plots/figure3_reproduced.png) | Annual predictor selection frequencies; bars match original frequencies | `replication_of_submission/figure3.m` |
| **Figure 4** | ![orig](../../plots/figure4_reference.png) | ![repro](../../plots/figure4_reproduced.png) | Macroeconomic uncertainty regime splits; dummy marker row 19 filtered | `replication_of_submission/figure4.m` |
| **Figure 5** | ![orig](../../plots/figure5_reference.png) | ![repro](../../plots/figure5_reproduced.png) | Real economic activity regime splits; dummy marker row 19 filtered | `replication_of_submission/figure5.m` |
| **Figure 6** | ![orig](../../plots/figure6_reference.png) | ![repro](../../plots/figure6_reproduced.png) | Cumulative squared forecast error differences with NBER recession shading | `replication_of_submission/figure6.m` |
| **Figure 7** | ![orig](../../plots/figure7_reference.png) | ![repro](../../plots/figure7_reproduced.png) | Downside risk and economic value metrics across 18 predictive models | `replication_of_submission/figure7.m` |

---

## 1.3 Supplementary Figures Comparison (Figures 1_supp to 9_supp)

| Supplementary Figure | Original Asset | Reproduced Asset | Numerical & Structural Notes | Figure Source File |
| :--- | :--- | :--- | :--- | :--- |
| **Figure 1_supp** | ![orig](../../plots/figure1_supp_reference.png) | ![repro](../../plots/figure1_supp_reproduced.png) | Simulation performance trajectories across correlation regimes; 6 subplots match | `replication_of_supplementary_material/figure1_supp.m` |
| **Figure 2_supp** | ![orig](../../plots/figure2_supp_reference.png) | ![repro](../../plots/figure2_supp_reproduced.png) | Sensitivity to lag length $p=2, 3$; scatter points match `results.xls` | `replication_of_supplementary_material/figure2_supp.m` |
| **Figure 3_supp** | ![orig](../../plots/figure3_supp_reference.png) | ![repro](../../plots/figure3_supp_reproduced.png) | Alternative forecast horizons $h=3, 6, 12$; scatter points match `results.xls` | `replication_of_supplementary_material/figure3_supp.m` |
| **Figure 4_supp** | ![orig](../../plots/figure4_supp_reference.png) | ![repro](../../plots/figure4_supp_reproduced.png) | Real crude oil price forecast evaluation; scatter points match `results.xls` | `replication_of_supplementary_material/figure4_supp.m` |
| **Figure 5_supp** | ![orig](../../plots/figure5_supp_reference.png) | ![repro](../../plots/figure5_supp_reproduced.png) | Rolling window estimation evaluations; scatter points match `results.xls` | `replication_of_supplementary_material/figure5_supp.m` |
| **Figure 6_supp** | ![orig](../../plots/figure6_supp_reference.png) | ![repro](../../plots/figure6_supp_reproduced.png) | Prior hyperparameter sensitivity sweeps ($\alpha, \beta$); points match `results.xls` | `replication_of_supplementary_material/figure6_supp.m` |
| **Figure 7_supp** | ![orig](../../plots/figure7_supp_reference.png) | ![repro](../../plots/figure7_supp_reproduced.png) | Variance shrinkage sensitivity bars ($g$ hyperparameter); bars match `results.xls` | `replication_of_supplementary_material/figure7_supp.m` |
| **Figure 8_supp** | ![orig](../../plots/figure8_supp_reference.png) | ![repro](../../plots/figure8_supp_reproduced.png) | Brent and RAC price benchmarks; MCMC re-run bypassed per protocol | `replication_of_supplementary_material/figure8_supp.m` |
| **Figure 9_supp** | ![orig](../../plots/figure9_supp_reference.png) | ![repro](../../plots/figure9_supp_reproduced.png) | Macroeconomic uncertainty index extension; panels (a)-(b) reproduced from `results.xls` | `replication_of_supplementary_material/figure9_supp.m` |

---

## 1.4 Verification Summary Tally

| Category | Total Count | Verified Status |
| :--- | :--- | :--- |
| Manuscript Figures | 7 | 7/7 reproduced and visually aligned |
| Supplementary Figures | 9 | 9/9 audited (7 direct script reproductions, 2 MCMC protocol exceptions) |
| Total Visual Assets Audited | 16 | 16/16 verified |
