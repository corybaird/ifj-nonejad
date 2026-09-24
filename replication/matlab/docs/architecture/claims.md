# Econometric Claims and Artifact Crosswalk

## 1. Table of Contents
* 1.1 Core Paper Hypotheses
* 1.2 Monitoring Variables Registry (Table 1)
* 1.3 Manuscript Figures Crosswalk
* 1.4 Supplementary Material Crosswalk
* 1.5 Numerical Reference Results in results.xls

---

## 1.1 Core Paper Hypotheses
* Hypothesis 1 (Point Forecast Superiority): Combining predictive regressions with dynamic forecast rotation achieves lower out-of-sample MSE than the Ellwanger and Snudden (2023) random-walk benchmark
* Hypothesis 2 (Predictability Clustering): Forecast gains are episodic, concentrating within distinct windows triggered by macroeconomic, financial, or geopolitical shocks
* Hypothesis 3 (Economic and Regulatory Value): Improved point forecasts yield statistically significant reductions in downside regulatory loss and deliver positive annualized Sharpe ratio differentials

---

## 1.2 Monitoring Variables Registry (Table 1)
* 18 monitoring series in `data/mz.xls` (columns 1 to 19, excluding column 12):

| Column Index | Variable Label | Description & Source |
|---|---|---|
| `k=1` | Commodity | Newspaper-based commodity markets volatility tracker (Baker et al.) |
| `k=2` | Emv | Newspaper-based US equity market volatility tracker (Baker et al.) |
| `k=3` | Epu | Newspaper-based US economic policy uncertainty index (Baker et al.) |
| `k=4` | Petroleum | Newspaper-based petroleum markets volatility tracker (Baker et al.) |
| `k=5` | Kilian | Global real economic activity index (Kilian 2009, FRED) |
| `k=6` | Spread | Term spread: 10-year Treasury minus 3-month Treasury |
| `k=7` | Default | Default spread: Moody's BAA minus AAA corporate yields |
| `k=8` | VIX | CBOE equity market volatility index |
| `k=9` | Macro Uncertainty | Macroeconomic uncertainty index (Ludvigson et al. 2021) |
| `k=10` | Financial Uncertainty | Financial uncertainty index (Ludvigson et al. 2021) |
| `k=11` | GPR | Geopolitical risk index (Caldara and Iacoviello 2022) |
| `k=13` | Ted | TED spread: 3-month LIBOR minus 3-month Treasury bill rate |
| `k=14` | Real Uncertainty | Real activity uncertainty index (Jurado et al. 2015) |
| `k=15` | Inflation Uncertainty | Price level uncertainty index (Jurado et al. 2015) |
| `k=16` | OVX | CBOE crude oil ETF volatility index |
| `k=17` | Energy EMV | Energy sector newspaper volatility tracker |
| `k=18` | CPU | Climate policy uncertainty index |
| `k=19` | GSCPI | Global supply chain pressure index (Federal Reserve Bank of New York) |

---

## 1.3 Manuscript Figures Crosswalk

| Figure | Script | Generating Routine | Reference Sheet | Description |
|---|---|---|---|---|
| Figure 1 | `figure1.m` | `figure1_computation.m` | `figure1` | Scatter plot of Theil's U versus Clark-West p-values across 18 predictors |
| Figure 2 | `figure2.m` | `main.m` outputs | Plot only | Recursive classification rates (TP, TN, FP, FN) and rolling Theil's U |
| Figure 3 | `figure3.m` | `main.m` outputs | Plot only | Cross-sectional correlation between true positive predictability indicators |
| Figure 4 | `figure4.m` | `figure4_computation.m` | `figure4` | Theil's U conditioned on macroeconomic uncertainty states |
| Figure 5 | `figure5.m` | `figure5_computation.m` | `figure5` | Theil's U conditioned on Kilian real economic activity states |
| Figure 6 | `figure6.m` | `main.m` outputs | Plot only | Time series of monitoring variables with shaded predictability windows |
| Figure 7 | `figure7.m` | `figure7_computation.m` | `figure7` | Regulatory loss ratios and annualized Sharpe ratio differentials |

---

## 1.4 Supplementary Material Crosswalk

| Artifact | Script | Generating Routine | Reference Sheet | Description |
|---|---|---|---|---|
| Table 1_supp | `table1_supp.m` | `main_sma_bma.m`, `main_reg.m` | `table1_supp` | Forecast performance of alternative model averaging methods |
| Figure 1_supp | `figure1_supp.m` | `main_sim.m` | `figure1_supp` | Monte Carlo simulation results across discounting parameters ($\lambda$) |
| Figure 2_supp | `figure2_supp.m` | `figure2_supp_computation.m` | `figure2_supp` | Sensitivity analysis under alternative lag orders |
| Figure 3_supp | `figure3_supp.m` | `figure3_supp_computation.m` | `figure3_supp` | Sensitivity analysis under alternative forecast horizons |
| Figure 4_supp | `figure4_supp.m` | `figure4_supp_computation.m` | `figure4_supp` | Performance evaluated on real (inflation-adjusted) oil prices |
| Figure 5_supp | `figure5_supp.m` | `figure5_supp_computation.m` | `figure5_supp` | Performance under rolling estimation windows |
| Figure 6_supp | `figure6_supp.m` | `figure6_supp_computation.m` | `figure6_supp` | Prior sensitivity analysis across Beta distribution parameters ($a_0, b_0$) |
| Figure 7_supp | `figure7_supp.m` | `figure7_supp_computation.m` | `figure7_supp` | Prior sensitivity analysis across variance shrinkage parameter ($g$) |
| Figure 8_supp | `figure8_supp.m` | `main_brent.m`, `main_rac.m` | Plot only | Robustness checks using Brent crude oil and RAC benchmarks |
| Figure 9_supp | `figure9_supp.m` | `figure9_supp_computation.m` | `figure9_supp` | Multi-step ahead forecast evaluations ($h \in \{2, 3, 4, 9\}$) |

---

## 1.5 Numerical Reference Results in results.xls
* Workbook contains 11 dedicated sheets:
  * `figure1`: Theil's U, CW p-value, DM statistic, VaR loss ratio (1990-2024 and 1990-2019)
  * `figure4`: Uncertainty-conditioned metrics ($ir=0, 1$)
  * `figure5`: Economic activity-conditioned metrics ($ir=0, 1$)
  * `figure7`: Regulatory loss and Sharpe ratio differentials
  * `table1_supp`: SMA and BMA comparison metrics
  * `figure1_supp`: Monte Carlo simulation loss grids
  * `figure2_supp` to `figure7_supp`, `figure9_supp`: Sensitivity benchmark grids
