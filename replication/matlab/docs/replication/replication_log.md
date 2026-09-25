# Replication Log, Runbook, and Discrepancy Tracker

The single technical record of the MATLAB replication audit: what was verified, what diverged, and how to rerun everything.

## 1. Table of Contents
* 1.1 Master Artifact Ledger
* 1.2 Manuscript Figures Verification Status
* 1.3 Supplementary Figures Verification Status
* 1.4 Supplementary Table Verification Status
* 1.5 Numerical Benchmark Summary
* 1.6 Discrepancy Tracker
* 1.7 Re-Execution Runbook
* 1.8 Verification Protocol for Reviewers

---

## 1.1 Master Artifact Ledger
* Total manuscript figures audited: 7
* Total supplementary figures audited: 9
* Total supplementary tables audited: 1
* Reference results file: `reports/results/results.xls`
* Record of truth: `reports/results/runs/replication_run_20260924_151805/` (61 MATLAB jobs, all exit 0, deterministic across three runs)
* Figures 1, 4, 5, 7 and 1_supp to 7_supp plot directly from `results.xls` — their PNGs validate plotting code only; Figures 2, 3, 6, 8_supp and 9_supp panels (c), (d) are recomputed from `.mat` files

Numerical match against `results.xls` (all sheet columns, both toggles):

| Block | Share matching at 4 dp | Max abs diff | Verdict |
|---|---|---|---|
| Table 1_supp | 100% | 5e-5 | Exact |
| Figure 9_supp | 100% | 4e-5 | Exact |
| Figure 1_supp | 99.5% to 100% | 4.6e-3 | Exact except 11 cells |
| Figures 1, 4, 5, 7 (main text) | 57% to 100% | 1.9e-2 | Close; no conclusion flips |
| Figures 2_supp, 3_supp, 5_supp, 6_supp, 7_supp | 0% to 94% | 3.7e-3 | Close; no conclusion flips |
| Figure 4_supp (real price) | 0% | 0.22 | Does not replicate; 19 conclusion flips |

---

## 1.2 Manuscript Figures Verification Status

| Artifact | Source Script | Reference Fig | Verification Status | Notes |
|---|---|---|---|---|
| Figure 1 | `figure1_computation.m` | `figure1.fig` | Close | All 6 columns rerun; max diff 9e-4; no conclusion flips; plot axes fixed (R11, R12) |
| Figure 2 | `figure2.m` | `figure2.fig` | Verified from `main.m` outputs | Subplots (3,2,5) and (3,2,6) require manual bar conversion |
| Figure 3 | `figure3.m` | `figure3.fig` | Verified from `main.m` outputs | Line to bar graphical formatting applied in published version |
| Figure 4 | `figure_4_computation.m` | `figure4.fig` | Close | ir = 0 and 1 rerun; max diff 3.4e-3 (D5); no conclusion flips; plot axes fixed (R11, R13) |
| Figure 5 | `figure5_computation.m` | `figure5.fig` | Close | ir = 0 and 1 rerun; max diff 7.4e-3 (D4); no conclusion flips; plot axes fixed (R11, R13) |
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

## 1.5 Numerical Benchmark Summary
* 1,056 non-simulation cells and 8,820 simulation cells compared against `results.xls`
* 19 conclusion flips (p-value crossing 1%, 5% or 10%), all in Figure 4_supp
* No TU ratio crosses 1 in any block
* Estimation stage matches the author-shipped `wti_4.mat` to about 1e-8; remaining drift enters after estimation
* Full itemization in section 1.6

---

## 1.6 Discrepancy Tracker

### Record of truth
* Run folder: `reports/results/runs/replication_run_20260924_151805/`
* Runner: `uv run python -m replication.matlab.pipelines_python.replication_runner` (config `pipelines_python/replication_runs.yaml`)
* Environment: MATLAB R2025b, macOS arm64; package developed on MATLAB R2009b
* Files:
  * `replication_summary_*.csv`: per job max and mean absolute difference, share matching at 4 dp
  * `replication_cells_*.csv`: every compared cell (reference vs reproduced)
  * `replication_conclusion_flips_*.csv`: cells where a TU ratio crosses 1 or a p-value crosses 1%, 5% or 10%
  * `replication_jobs_*.csv` and `logs/`: exit code and runtime of all 61 MATLAB jobs
* Determinism: three full runs, including one after the folder reorganisation, produced identical numbers

### Severity scale
* **Minor:** differences below 1e-2 with no change in any TU < 1 or significance conclusion
* **Moderate:** differences above 1e-2 in isolated cells, no conclusion flips
* **Material:** at least one conclusion flip or a systematic gap across a whole block

### Open discrepancies

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
| D9 | Figures 2 and 3 (main text) | tick formatting | n/a | 0 | Cosmetic | R2025b tick defaults vs author post-processing (readme) |

#### D9 detail (Figures 2 and 3 graphical presentation)
* Author disclosure (`readme.txt` lines 132-135): titles, labels, tick marks, and line-to-bar transformations adjusted manually post-computation for final publication
* Figure 2:
  * Time series curves and bar heights bit-identical to manuscript PDF
  * MATLAB R2025b automatic tick generation produces fewer ticks (`0, 0.1, 0.2` and `0.9, 1`) compared to author's manually formatted 2-decimal ticks (`0.00` to `0.30` by `0.06`, and `0.90` to `1.05` by `0.03`)
* Figure 3:
  * Selection frequencies and bar heights bit-identical to manuscript PDF
  * MATLAB R2025b default ticks produce `0, 0.1, 0.2, 0.3` without trailing zeroes; published PDF and reference `.fig` have 6 ticks (`0.00, 0.06, 0.12, 0.18, 0.24, 0.30`)

#### D1 detail
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

#### Common cause of D2 to D7
* `main.m` output matches the author-shipped `wti_4.mat` to about 1e-8
* `funcCW`, `funcDM`, `funcLearning*` are deterministic and unmodified from `original_files/`
* The drift therefore enters after estimation; `results.xls` likely reflects a slightly different code state than the shipped scripts

### Resolved discrepancies

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
| R11 | Reference PNGs for Figures 1, 4, 5 mislabelled their axes (dots appeared at wrong p-values and TU values). The R2009b `.fig` files store manual `XTickLabel`/`YTickLabel` strings but auto `XTick`/`YTick`; R2025b regenerates tick positions and pastes the strings onto them in order, wrapping when ticks outnumber labels (e.g. Figure 5 (c) y-axis read `0.00 … 1.00, 0.00, 0.20`). The Figure 4 "corrupted export" was the same fault | `code/functions/export_reference_png.m` rebuilds tick positions from the numeric labels and sets auto limits to the outer ticks; the runner calls it. Output matches PDF pages 35, 38, 39 |
| R12 | `figure1.m` hard-coded `xlim([0.945, 0.98])`, hiding every predictor with TU > 0.98 (3 dots in (a), (b); 7 in (c), (d), including DM p = 0.3467) | `xlim([0.95, 1.02])` as in the reference `.fig` and PDF |
| R13 | `figure4.m`, `figure5.m` left axes on auto (R2025b stretched (c), (d) to y = 1.2) and `figure4.m` (d) drew the threshold at 0.2 instead of 0.1 | Axes set to the PDF limits (x `[0.95, 1.02]` top, `[0.90, 1.02]` bottom, y `[0, 1]`); threshold 0.1 |
| R14 | Reproduced PNGs for Figures 1, 4, 5, 7 were not produced by the runner | Added to the `figures` phase of `replication_runs.yaml` |

### Impact on paper findings
* **Main text: no impact.** Across Figures 1, 4, 5 and 7, no TU ratio crosses 1 and no CW or DM p-value crosses 1%, 5% or 10%
* **Supplementary robustness: no impact** for Table 1_supp, Figures 1_supp to 3_supp, 5_supp to 7_supp and 9_supp
* **Figure 4_supp (real price): qualitative message holds, individual cells do not.** TU < 1 for every predictor in both samples, so the robustness claim that real vs nominal prices "does not lead to any qualitatively meaningful changes" survives; the specific set of predictors significant at 5% differs

---

## 1.7 Re-Execution Runbook

### Environment setup and prerequisites
* Preferred environment: MATLAB R2009b with Econometrics Toolbox
* Tested modern environment: MATLAB R2025b (macOS, Apple Silicon)
* Python runner environment: `/opt/homebrew/bin/uv`, Python 3.13 in workspace `.venv` (config: `pyproject.toml`, `uv.toml`)
* MATLAB Engine for Python installed from `/Applications/MATLAB_R2025b.app/extern/engines/python`; shared session name `'MATLAB_925'`
* MATLAB calls require sandbox bypass under Claude Code (inter-process socket communication)
* Paths: each script adds `code/functions`, `data`, `reports/results` and `code/replication_of_submission` relative to its own location (via `mfilename('fullpath')`); no manual `addpath` needed
* Boundary constraint: `original_files/` is strictly read-only; all replication activity lives in `replication/matlab/`
* Toggles: set `REPL_<NAME>` environment variables (read by `code/functions/replication_setting.m`) or edit the default in the script

| Toggle | Scripts | Values |
|---|---|---|
| `REPL_VEND` | `figure1/7_computation`, `figure2..7_supp_computation`, `table1_supp` | `202412`, `201912` |
| `REPL_IR` | `figure_4_computation`, `figure5_computation` | `0`, `1` |
| `REPL_DG`, `REPL_PRIOR_IDX` | `main_prior`, `figure7_supp_computation` | g in {0.05, 0.5, 5, 50, 100}, index 1 to 5 |
| `REPL_IH` | `main_for`, `figure9_supp_computation` | 2, 3, 4, 9 |
| `REPL_DLAM`, `REPL_SIM_IDX` | `main_sim`, `figure1_supp_computation` | λ in {1, 1.5, 0.5}, index 1 to 3 |
| `REPL_DA0`, `REPL_DB0` | `figure6_supp_computation` | (0.1, 0.1), (2, 2), (20, 1), (20, 0.1) |
| `REPL_REAL_K` | `main_real` | default `4`; full run uses all 18 predictors |

### Automated full run
* Command, from the project root:

```bash
/opt/homebrew/bin/uv run python -m replication.matlab.pipelines_python.replication_runner
```

* Run matrix: `pipelines_python/replication_runs.yaml` (19 producers, 38 computations, 5 recomputed figures)
* Runtime: about 3 minutes with 6 parallel MATLAB processes; `main.m` and `main_real.m` take about 46 seconds each (per job wall time including MATLAB startup: 6 to 46 seconds)
* Outputs in `reports/results/runs/replication_run_<timestamp>/`: job log, cell-level comparison, per-job summary, conclusion flips, MATLAB logs
* Also regenerates `reports/plots/*_reference.png` from `original_files/ijfr/plots/*.fig` via `export_reference_png.m`, which restores tick positions lost in R2025b (R11)

### Quickstart spot check (wti_4.mat)
* Navigate to `code/replication_of_submission` and run `main_example.m` (predictor `k=4`)
* Run `figure1_computation_example.m`; `mquant` matches row 4, columns 1 to 3 of sheet `figure1` to within 2e-4
* Python alternative with a shared MATLAB session: `uv run python -m replication.matlab.pipelines_python.run_example`

### Manual manuscript runbook
* `main.m`: writes the 18 `wti_k.mat` files ($k \in \{1..11, 13..19\}$)
* Figure 1: `figure1_computation.m` with `vend=202412` then `vend=201912`; plot with `figure1.m`
* Figures 2, 3, 6: run the script directly after `main.m`
* Figures 4 and 5: `figure_4_computation.m` / `figure5_computation.m` with `ir=0` then `ir=1`; plot with `figure4.m` / `figure5.m`
* Figure 7: `figure7_computation.m` with both `vend` values; plot with `figure7.m`

### Manual supplementary runbook
* Table 1_supp: `main_sma_bma.m`, `main_reg.m`, then `table1_supp.m` for both `vend` values
* Figure 1_supp: `main_sim.m` then `figure1_supp_computation.m` for each λ; plot via `figure1_supp.m`
* Figures 2_supp, 3_supp, 5_supp: computation script for both `vend` values (uses `main.m` outputs)
* Figure 4_supp: `main_real.m` for all 18 predictors, then `figure4_supp_computation.m`
* Figure 6_supp: `figure6_supp_computation.m` for each Beta prior
* Figure 7_supp: `main_prior.m` then `figure7_supp_computation.m` for each g
* Figure 8_supp: `main_brent.m`, `main_rac.m`, then `figure8_supp.m`
* Figure 9_supp: `main_for.m` and `figure9_supp_computation.m` for each h, `main_exp.m`, then `figure9_supp.m`
* Plot scripts write `reports/plots/figureN_supp_reproduced.{png,fig}`; reference `.fig` files are never overwritten

### Edge cases and modern MATLAB compatibility
* Dummy marker filtering: sheets `figure1`, `figure4`, `figure5`, `figure2_supp` to `figure6_supp` contain dummy row 19; scripts use `mc = mc(1:18, :)`
* `RandStream.setDefaultStream` replaced with `RandStream.setGlobalStream` (active only in `main_sim.m`)
* `xlsread` emits deprecation notices but still runs on R2025b
* `size(mz) - size(vd)` in `figure6.m` replaced with scalar `size(...,1)` indexing

---

## 1.8 Verification Protocol for Reviewers
1. Verify git cleanliness with `git status` and `git diff`
2. Rerun the full matrix: `/opt/homebrew/bin/uv run python -m replication.matlab.pipelines_python.replication_runner` (about 3 minutes; MATLAB calls need sandbox bypass)
3. Confirm the new `replication_summary_*.csv` matches the record of truth in section 1.1
4. Review open items D1 to D9 in section 1.6
