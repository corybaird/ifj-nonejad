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
* Recomputed figures: Figures 2, 3, 6 and 8_supp are drawn from `.mat` files produced by the full rerun
* Sheet-driven figures: Figures 1, 4, 5, 7, 1_supp to 7_supp and 9_supp plot directly from `results.xls`; a visual match validates plotting code only. Numerical validity is tracked in `replication_log.md` (section 1.6)

---

## 1.2 Manuscript Figures Comparison (Figures 1 to 7)

| Manuscript Figure | Original Asset                                     | Reproduced Asset                                     |
| :---------------- | :------------------------------------------------- | :--------------------------------------------------- |
| **Figure 1**      | ![orig](../../reports/plots/figure1_reference.png) | ![repro](../../reports/plots/figure1_reproduced.png) |
| **Figure 2**      | ![orig](../../reports/plots/figure2_reference.png) | ![repro](../../reports/plots/figure2_reproduced.png) |
| **Figure 3**      | ![orig](../../reports/plots/figure3_reference.png) | ![repro](../../reports/plots/figure3_reproduced.png) |
| **Figure 4**      | ![orig](../../reports/plots/figure4_reference.png) | ![repro](../../reports/plots/figure4_reproduced.png) |
| **Figure 5**      | ![orig](../../reports/plots/figure5_reference.png) | ![repro](../../reports/plots/figure5_reproduced.png) |
| **Figure 6**      | ![orig](../../reports/plots/figure6_reference.png) | ![repro](../../reports/plots/figure6_reproduced.png) |
| **Figure 7**      | ![orig](../../reports/plots/figure7_reference.png) | ![repro](../../reports/plots/figure7_reproduced.png) |

| Manuscript Figure | Numerical & Structural Notes | Figure Source File |
| :--- | :--- | :--- |
| **Figure 1** | Scatter of TU vs CW/DM p-values; points match `results.xls` within Excel 4-decimal precision; x-axis cropped to 0.98 in script vs 1.02 in draft PDF (D9 in `replication_log.md`) | `code/replication_of_submission/figure1.m` |
| **Figure 2** | Multi-panel time series of posterior model probabilities and recession bands; R2025b automatic tick decimation vs manual author 2-decimal ticks (D9 in `replication_log.md`) | `code/replication_of_submission/figure2.m` |
| **Figure 3** | Annual predictor selection frequencies; bars match original frequencies; tick formatting differs between R2025b and published PDF (D9 in `replication_log.md`) | `code/replication_of_submission/figure3.m` |
| **Figure 4** | Macroeconomic uncertainty regime splits; dummy marker row 19 filtered; reference asset corrupted by headless legacy fig export; numerical coordinates exact (D9 in `replication_log.md`) | `code/replication_of_submission/figure4.m` |
| **Figure 5** | Real economic activity regime splits; dummy marker row 19 filtered | `code/replication_of_submission/figure5.m` |
| **Figure 6** | Cumulative squared forecast error differences with NBER recession shading | `code/replication_of_submission/figure6.m` |
| **Figure 7** | Downside risk and economic value metrics across 18 predictive models | `code/replication_of_submission/figure7.m` |

---

## 1.3 Supplementary Figures Comparison (Figures 1_supp to 9_supp)

| Supplementary Figure | Original Asset                                          | Reproduced Asset                                          |
| :------------------- | :------------------------------------------------------ | :-------------------------------------------------------- |
| **Figure 1_supp**    | ![orig](../../reports/plots/figure1_supp_reference.png) | ![repro](../../reports/plots/figure1_supp_reproduced.png) |
| **Figure 2_supp**    | ![orig](../../reports/plots/figure2_supp_reference.png) | ![repro](../../reports/plots/figure2_supp_reproduced.png) |
| **Figure 3_supp**    | ![orig](../../reports/plots/figure3_supp_reference.png) | ![repro](../../reports/plots/figure3_supp_reproduced.png) |
| **Figure 4_supp**    | ![orig](../../reports/plots/figure4_supp_reference.png) | ![repro](../../reports/plots/figure4_supp_reproduced.png) |
| **Figure 5_supp**    | ![orig](../../reports/plots/figure5_supp_reference.png) | ![repro](../../reports/plots/figure5_supp_reproduced.png) |
| **Figure 6_supp**    | ![orig](../../reports/plots/figure6_supp_reference.png) | ![repro](../../reports/plots/figure6_supp_reproduced.png) |
| **Figure 7_supp**    | ![orig](../../reports/plots/figure7_supp_reference.png) | ![repro](../../reports/plots/figure7_supp_reproduced.png) |
| **Figure 8_supp**    | ![orig](../../reports/plots/figure8_supp_reference.png) | ![repro](../../reports/plots/figure8_supp_reproduced.png) |
| **Figure 9_supp**    | ![orig](../../reports/plots/figure9_supp_reference.png) | ![repro](../../reports/plots/figure9_supp_reproduced.png) |

| Supplementary Figure | Numerical & Structural Notes | Figure Source File |
| :--- | :--- | :--- |
| **Figure 1_supp** | Simulation performance trajectories across correlation regimes; 6 subplots match | `code/replication_of_supplementary_material/figure1_supp.m` |
| **Figure 2_supp** | Sensitivity to lag length $p=2, 3$; scatter points match `results.xls` | `code/replication_of_supplementary_material/figure2_supp.m` |
| **Figure 3_supp** | Alternative forecast horizons $h=3, 6, 12$; scatter points match `results.xls` | `code/replication_of_supplementary_material/figure3_supp.m` |
| **Figure 4_supp** | Real crude oil price forecast evaluation; plotted from `results.xls`; recomputed values do not replicate (discrepancy D1 in `replication_log.md`) | `code/replication_of_supplementary_material/figure4_supp.m` |
| **Figure 5_supp** | Rolling window estimation evaluations; scatter points match `results.xls` | `code/replication_of_supplementary_material/figure5_supp.m` |
| **Figure 6_supp** | Prior hyperparameter sensitivity sweeps ($\alpha, \beta$); points match `results.xls` | `code/replication_of_supplementary_material/figure6_supp.m` |
| **Figure 7_supp** | Variance shrinkage sensitivity bars ($g$ hyperparameter); bars match `results.xls` | `code/replication_of_supplementary_material/figure7_supp.m` |
| **Figure 8_supp** | Brent and RAC benchmarks recomputed from `brent_1.mat` and `rac_1.mat`; panels (b), (d) match; (a), (c) axis scaling differs (D8) | `code/replication_of_supplementary_material/figure8_supp.m` |
| **Figure 9_supp** | Macroeconomic uncertainty index extension; panels (a), (b) from `results.xls`; (c), (d) recomputed from `exp_1.mat`; (c) axis scaling differs (D8) | `code/replication_of_supplementary_material/figure9_supp.m` |

---

## 1.4 Verification Summary Tally

| Category | Total Count | Verified Status |
| :--- | :--- | :--- |
| Manuscript Figures | 7 | 7/7 reproduced and visually aligned |
| Supplementary Figures | 9 | 9/9 plotted; 8/9 numerically close or exact; Figure 4_supp does not replicate (D1) |
| Total Visual Assets Audited | 16 | 16/16 plotted; see `replication_log.md` (section 1.6) for numerical status |
