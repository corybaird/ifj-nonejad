# Replication Discrepancy Tracker

## Table of Contents
* 1.1 Record of Truth
* 1.2 Severity Scale
* 1.3 Open Discrepancies
* 1.4 Resolved Discrepancies
* 1.5 Impact on Paper Findings

---

## 1.1 Record of Truth
* Run folder: `reports/results/runs/replication_run_20260924_151805/`
* Runner: `uv run python -m replication.matlab.pipelines_python.replication_runner` (config `pipelines_python/replication_runs.yaml`)
* Environment: MATLAB R2025b, macOS arm64; package developed on MATLAB R2009b
* Files:
  * `replication_summary_*.csv`: per job max and mean absolute difference, share matching at 4 dp
  * `replication_cells_*.csv`: every compared cell (reference vs reproduced)
  * `replication_conclusion_flips_*.csv`: cells where a TU ratio crosses 1 or a p-value crosses 1%, 5% or 10%
  * `replication_jobs_*.csv` and `logs/`: exit code and runtime of all 61 MATLAB jobs
* Determinism: three full runs, including one after the folder reorganisation, produced identical numbers

---

## 1.2 Severity Scale
* **Minor:** differences below 1e-2 with no change in any TU < 1 or significance conclusion
* **Moderate:** differences above 1e-2 in isolated cells, no conclusion flips
* **Material:** at least one conclusion flip or a systematic gap across a whole block

---

## 1.3 Open Discrepancies

| ID | Artifact | Block | Max abs diff | Conclusion flips | Severity | Status |
|---|---|---|---|---|---|---|
| D1 | Figure 4_supp (real WTI price) | both samples, all 18 rows | 0.22 (p-values), 0.010 (TU) | 19 of 108 cells | Material | Unexplained |
| D2 | Figure 7_supp | g = 5 row, both samples | 0.0037 | 0 | Minor | Unexplained |
| D3 | Figure 7 | 2024 sample, rows 13 and 16, col 2 | 0.019 | 0 | Moderate | Unexplained |
| D4 | Figure 5 | ir = 0, 4 cells | 0.0074 | 0 | Minor | Unexplained |
| D5 | Figure 4 | ir = 1, 19 cells over 1e-3 | 0.0034 | 0 | Minor | Unexplained |
| D6 | Figure 1_supp | λ = 1 block, 11 of 2,940 cells | 0.0046 | n/a (simulation) | Minor | Unexplained |
| D7 | Figures 1, 5, 7, 2_supp, 3_supp, 5_supp, 6_supp | scattered p-values | below 1e-3 | 0 | Minor | 4th decimal drift |
| D8 | Figure 8_supp panels (a), (c) and Figure 9_supp panel (c) | y-axis scaling | n/a | 0 | Cosmetic | Author set axes manually (readme) |

### D1 detail
* TU < 1 for all 18 predictors in both reference and reproduction (2024 and 2019 samples)
* Count of significant predictors shifts:

| Test | Sample | Reference p < 0.10 | Reproduced p < 0.10 | Reference p < 0.05 | Reproduced p < 0.05 |
|---|---|---|---|---|---|
| CW | 1990–2024 | 16 | 16 | 5 | 3 |
| DM | 1990–2024 | 13 | 12 | 3 | 1 |
| CW | 1990–2019 | 12 | 15 | 2 | 1 |
| DM | 1990–2019 | 7 | 9 | 1 | 1 |

* Checked and ruled out: deflation code (`vy=diff(log(vyc./vpc))`, CPI from `my.xls` column 4), producer/consumer file names
* Leading hypothesis: CPI vintage in `my.xls` differs from the vintage used to build `results.xls` (not verified)

### Common cause of D2 to D7
* `main.m` output matches the author-shipped `wti_4.mat` to about 1e-8
* `funcCW`, `funcDM`, `funcLearning*` are deterministic and unmodified from `original_files/`
* The drift therefore enters after estimation; `results.xls` likely reflects a slightly different code state than the shipped scripts

---

## 1.4 Resolved Discrepancies

| ID | Issue | Fix |
|---|---|---|
| R1 | `figure4_supp_computation.m` loaded nominal `wti_k` instead of `wti_real_k` | Load `wti_real_` |
| R2 | `figure7_supp_computation.m` loaded baseline `wti_1` (g = 50) | Load `wti_prior_<idx>` |
| R3 | `figure9_supp_computation.m` loaded nonexistent `for_1` | Load `for_<ih>` |
| R4 | `main_sim.m` saved `simulationl_` but consumer loads `simulation_` | Save `simulation_<idx>` |
| R5 | `main_sim.m` still called `setDefaultStream` (fails on R2025b) | `setGlobalStream` |
| R6 | Readme and `main_prior.m` list g grid {0.005, 0.05, 5, 50, 100}; `figure7_supp.fig` x-axis shows {0.05, 0.5, 5, 50, 100} | Grid and default corrected to the figure |
| R7 | `figure1_supp.m` to `figure7_supp.m` overwrote reference `plots/figureN_supp.fig` (now `reports/plots/`) | Save `_reproduced.fig`; references restored from `original_files/` |
| R8 | `figure8_supp_reproduced.png` was a re-export of the reference `.fig` | Regenerated from recomputed `brent_1.mat` and `rac_1.mat` |
| R9 | Only 1990–2024 / ir = 0 half of each sheet was ever regenerated | All toggles now run via `code/functions/replication_setting.m` |
| R10 | Local `figure9_supp.m` opened the reference `figure9_supp.fig` and pasted over panels (a), (b), so (c), (d) were never recomputed | Upstream script restored; (c), (d) recomputed from `exp_1.mat`; (d) matches, (c) has the D8 axis scaling |

---

## 1.5 Impact on Paper Findings
* **Main text: no impact.** Across Figures 1, 4, 5 and 7, no TU ratio crosses 1 and no CW or DM p-value crosses 1%, 5% or 10%
* **Supplementary robustness: no impact** for Table 1_supp, Figures 1_supp to 3_supp, 5_supp to 7_supp and 9_supp
* **Figure 4_supp (real price): qualitative message holds, individual cells do not.** TU < 1 for every predictor in both samples, so the robustness claim that real vs nominal prices "does not lead to any qualitatively meaningful changes" survives; the specific set of predictors significant at 5% differs
