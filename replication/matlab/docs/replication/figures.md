# Visual Audit and Figure Comparison Guide

## 1. Table of Contents
* 1.1 Figure Audit Methodology
* 1.2 Manuscript Figures Comparison Matrix
* 1.3 Supplementary Figures Comparison Matrix
* 1.4 Post-Processing Graphical Adjustments

---

## 1.1 Figure Audit Methodology
* Baseline source: Shipped `.fig` files under `replication/matlab/plots/`
* Comparison artifacts: Graphics regenerated directly from `figure*.m` scripts
* Audit dimensions: Curve trajectories, axis limits, confidence envelopes, recession shading, and data labels

---

## 1.2 Manuscript Figures Comparison Matrix

| Figure | Reference File | Plot Type | Visual Correspondence | Formatting Notes |
|---|---|---|---|---|
| Figure 1 | `figure1.fig` | Scatter plot | Exact numeric match | Points match Theil's U and CW p-values in `results.xls` |
| Figure 2 | `figure2.fig` | Multi-panel time series | Exact match | Panels (e) and (f) reflect rolling Theil's U around 0.96-0.97 |
| Figure 3 | `figure3.fig` | Multi-panel bar/line plot | Exact match | Published version converts line plots to vertical bars |
| Figure 4 | `figure4.fig` | Grouped scatter plot | Exact match | High vs normal macroeconomic uncertainty splits |
| Figure 5 | `figure5.fig` | Grouped scatter plot | Exact match | High vs normal Kilian real economic activity splits |
| Figure 6 | `figure6.fig` | Shaded time series | Exact match | Shaded regions mark identified windows of predictability |
| Figure 7 | `figure7.fig` | Multi-panel bar chart | Exact match | Downside loss ratios < 1.0; positive Sharpe differentials |

---

## 1.3 Supplementary Figures Comparison Matrix

| Figure | Reference File | Plot Type | Visual Correspondence | Formatting Notes |
|---|---|---|---|---|
| Figure 1_supp | `figure1_supp.fig` | Surface/line curves | Exact match | Parameter grids for forgetting factor $\lambda$ |
| Figure 2_supp | `figure2_supp.fig` | Grouped bar/scatter | Exact match | Alternative lag order evaluations ($p=2, 3$) |
| Figure 3_supp | `figure3_supp.fig` | Scatter / bars | Exact match | Horizon evaluations ($h=3, 6, 12$) |
| Figure 4_supp | `figure4_supp.fig` | Scatter / bars | Exact match | Evaluated on real crude oil prices |
| Figure 5_supp | `figure5_supp.fig` | Rolling metric plots | Exact match | Rolling windows (120 and 180 months) |
| Figure 6_supp | `figure6_supp.fig` | Prior sensitivity plots | Exact match | Beta prior hyperparameter sweeps |
| Figure 7_supp | `figure7_supp.fig` | Variance shrinkage plots | Exact match | Shrinkage parameter sweeps ($g$) |
| Figure 8_supp | `figure8_supp.fig` | Benchmark comparison | Exact match | Brent and RAC price benchmarks |
| Figure 9_supp | `figure9_supp.fig` | Multi-horizon scatter | Exact match | Forecast horizons $h \in \{2, 3, 4, 9\}$ |

---

## 1.4 Post-Processing Graphical Adjustments
* Disclosed in author `readme.txt`:
  * Subplot lines converted to vertical bars in Figures 2 and 3
  * Tick marks and axis limits manually adjusted for publication layout
  * Numerical data underlying all plots confirmed bit-identical to `results.xls`
