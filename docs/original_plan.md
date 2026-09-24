# Native Python Replication of Nonejad (2026), *IJF*

## 1. Table of Contents
* 1.1 Context and Overview
* 1.2 Upstream Methodology and Architecture
* 1.3 Verified Environment Facts
* 1.4 Scope Decisions and Parity Tiers
* 1.5 Target Repository Structure
* 2.1 Implementation Phases and Build Order
* 2.2 Phase 0: Project Scaffold and Ingestion
* 2.3 Phase 7: Manuscript Claim Extraction
* 2.4 Phase 1: Econometric Core and Solvers
* 2.5 Phase 2: Data Ingestion and Transformations
* 2.6 Phase 3: Forecast Generation and Dynamic Rotation
* 2.7 Phase 4: Hypothesis Testing and Loss Metrics
* 2.8 Phase 5: Figure and Table Reproduction
* 2.9 Phase 6: Pipeline Orchestration
* 3.1 Documentation Roadmap
* 3.2 Verification and Parity Gates
* 3.3 Risks and Mitigation Strategies
* 3.4 Micro-Commit Staging Sequence

---

## 1.1 Context and Overview
* Upstream replication package: `original_files/ijfr/`
* Target manuscript: *A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil* (Nonejad, *International Journal of Forecasting*, IJF-D-26-00175R3)
* Package volume: 69 MATLAB `.m` scripts, 4 Excel workbooks, 16 `.fig` graphics files, and benchmark `results.xls`
* Goal: Standalone native Python replication reproducing every manuscript table and figure without MATLAB runtime dependency
* Reference corpus immutability: `original_files/` and `drafts/` remain strictly read-only

---

## 1.2 Upstream Methodology and Architecture
* Target predictand: Monthly log return and price of West Texas Intermediate (WTI) crude oil
* Benchmark model: End-of-month random-walk benchmark from Ellwanger and Snudden (2023)
* Predictive regressors: Economic indicators from FRED-MD dataset (`mx.xls`)
* Recursive estimation: Dynamic linear models estimated via Recursive Least Squares (RLS) with exponential forgetting factors ($\lambda \in [0.94, 1.00]$, $g=50$)
* Dynamic Forecast Rotation (DFR): Real-time switching between benchmark and combination forecasts based on extreme-value threshold triggers (Zhu and Timmermann 2022)
* Monitoring variables: 18 economic, financial, and uncertainty trackers (`mz.xls`)
* Bayesian learning: Beta-binomial conjugate updating over dynamic transition probabilities and prior hyperparameter grids
* Statistical tests: Clark-West (2007) nested test, Diebold-Mariano (1995) test with Newey-West HAC covariance, Value-at-Risk (VaR), Expected Shortfall, downside regulatory loss

---

## 1.3 Verified Environment Facts
* Python execution environment: Apple M4 Pro, macOS 15, `/opt/homebrew/bin/uv` with Python 3.13
* MATLAB test oracle: Local MATLAB R2025b session available for parity verification
* Upstream file formats:
  * Raw data: Excel 97-2003 `.xls` workbooks (`data/my.xls`, `data/mx.xls`, `data/mz.xls`, `data/usrec.xls`)
  * Benchmark results: Multi-sheet Excel workbook (`results/results.xls`)
  * Figures: MATLAB binary figure format (`plots/*.fig`)
  * Intermediate cache: MATLAB v7 matrix archive (`replication_of_submission/wti_4.mat`)
* Graphify knowledge graph: Successfully mapped into `graphify-out/` (30 nodes, 30 edges, 6 communities)

---

## 1.4 Scope Decisions and Parity Tiers
* Standalone native Python replication with test-time MATLAB oracle
* Tier 0: Direct validation and plot regeneration from shipped `results.xls` benchmarks
* Tier 1: End-to-end econometric estimation and dynamic forecast rotation re-executed from raw Excel time series
* Deterministic numerical parity: Coefficients, forecasts, and loss statistics match upstream outputs to $10^{-10}$
* Data transformation parity: Growth rates, lag matrices, and mean adjustments match upstream inputs to $10^{-12}$

---

## 1.5 Target Repository Structure
* Standard Cookiecutter Data Science layout:
```
nonejad-2026/
├── original_files/              # READ-ONLY upstream package
├── drafts/                      # READ-ONLY manuscript PDF
├── graphify-out/                # Generated knowledge graph and reports
├── pyproject.toml               # uv project definition
├── docs/                        # Architecture and replication documentation
│   └── original_plan.md         # Master replication strategy document
├── src/
│   ├── config.py                # Configuration and path management
│   ├── data/                    # Time series ingestion and transformations
│   ├── models/                  # RLS, Dynamic Rotation, Beta-Binomial learning
│   ├── forecasting/             # Forecast rolling windows and combination
│   ├── claims/                  # PDF claim extraction and ledger builder
│   ├── viz/                     # Matplotlib reproduction of figures
│   └── utils/                   # MatIO, Newey-West HAC, CW/DM statistics
├── references/
│   ├── configs/                 # YAML pipeline configurations
│   └── dictionaries/            # Monitoring variables and model specifications
├── data/
│   ├── raw/                     # Cached parquet extracts of Excel workbooks
│   ├── processed/               # Aligned regression matrices
│   ├── pipeline/                # Extracted claims and intermediate arrays
│   └── temp/                    # Scratch outputs
├── reports/
│   ├── tables/                  # Markdown and LaTeX summary tables
│   └── figures/                 # Exported reproduction figures
└── tests/                       # Parity and econometric test suite
```

---

## 2.1 Implementation Phases and Build Order
* Strict phase progression:
```
Phase 0: Scaffold & MatIO
   │
   ├── Phase 7: Manuscript Claim Extraction (Independent baseline)
   │
   └── Phase 1: Models → Phase 2: Data → Phase 3: Forecasting → Phase 4: Tests → Phase 5: Viz → Phase 6: Orchestration
```

---

## 2.2 Phase 0: Project Scaffold and Ingestion
* Construct `pyproject.toml` with uv dependencies (`numpy`, `scipy`, `pandas`, `matplotlib`, `xlrd`, `openpyxl`, `pyyaml`, `pymupdf`, `pytest`)
* Build `src/utils/matio.py` supporting safe read-only access to `.mat` and `.xls` files
* Build `src/utils/matlab_oracle.py` wrapping local MATLAB engine as test-time validator
* Build `src/config.py` loading paths and parameters from `references/configs/`
* Construct initial variable registries in `references/dictionaries/` (>3 keys per dictionary)

---

## 2.3 Phase 7: Manuscript Claim Extraction
* Target artifact: `drafts/IJF-D-26-00175_R3.pdf`
* PDF word coordinate extraction via `pymupdf`: `src/claims/extract_text.py`
* Caption and boundary detection: `src/claims/locate.py`
* Structural number normalization and star parsing: `src/claims/normalize.py`
* Table parsing into tidy tabular records: `src/claims/parse_tables.py`
* Prose empirical claim harvesting: `src/claims/parse_prose.py`
* Tri-party ledger generation comparing Paper PDF, `results.xls`, and Python outputs: `src/claims/report.py`

---

## 2.4 Phase 1: Econometric Core and Solvers
* Recursive Least Squares solver with dual discounting: `src/models/rls.py`
  * Parity gate: Match `funcEstimateRLS.m` output matrices to $10^{-10}$
* Dynamic Forecast Rotation engine: `src/models/dynamic_rotation.py`
  * Rolling window extreme value thresholds (`funcMax`, `funcMin`)
  * Net change indicator evaluation
  * Parity gate: Match `funcDynamicRotation.m` matrices on `wti_4.mat` to $10^{-10}$
* Bayesian Beta-Binomial learning: `src/models/beta_binomial.py`
  * Conjugate updating of beta distribution parameters
  * Exponential discounting of historical observation counts
  * Parity gate: Match `funcLearning.m` predictive densities to $10^{-10}$

---

## 2.5 Phase 2: Data Ingestion and Transformations
* Excel workbook loaders: `src/data/loader.py`
  * `my.xls`: Monthly WTI crude oil prices and nominal returns
  * `mx.xls`: FRED-MD macroeconomic predictor series
  * `mz.xls`: 18 monitoring series for dynamic rotation
  * `usrec.xls`: NBER recession dates
* Preprocessing transformations: `src/data/transforms.py`
  * Forward fill missing values
  * Logarithmic differencing and lag operations (`funcLag.m`)
  * Sample centering and mean subtraction (`funcMeanc.m`)
  * Parity gate: Matrix checksum comparison against `main.m` preprocessed arrays to $10^{-12}$

---

## 2.6 Phase 3: Forecast Generation and Dynamic Rotation
* Master forecast execution pipeline: `src/forecasting/pipeline.py`
* Predictor regression loops over all 18 monitoring variables:
  * Full out-of-sample window (1990m1 to 2024m12)
  * Pre-COVID out-of-sample window (1990m1 to 2019m12)
* Multi-hyperparameter grid evaluation over forgetting factors ($\lambda$, $g$)
* Parity gate: Bit-level and float-level correspondence against intermediate `wti_k.mat` files

---

## 2.7 Phase 4: Hypothesis Testing and Loss Metrics
* Forecast evaluation statistics: `src/utils/metrics.py`
  * Relative Theil's U against random-walk benchmark
  * Clark and West (2007) nested model test statistic (`funcCW.m`)
  * Diebold and Mariano (1995) test statistic (`funcDM.m`)
  * Newey-West HAC robust standard errors (`NeweyWest.m`, `nwest.m`)
* Financial and regulatory loss metrics: `src/utils/loss.py`
  * Regulatory loss function under asymmetric penalties
  * Value-at-Risk (VaR) and Expected Shortfall (ES) at 5% coverage
  * Downside risk and annualized Sharpe ratio differentials
  * Parity gate: Exact match with `results.xls` sheets (`figure1`, `figure4`, `figure5`, `figure7`)

---

## 2.8 Phase 5: Figure and Table Reproduction
* Shared plotting engine: `src/viz/plots.py`
* Reproduction of manuscript figures:
  * Figure 1: Relative Theil's U and Clark-West p-values across 18 monitoring variables
  * Figure 2: Recursive classification rates (TP, TN, FP, FN) and rolling Theil's U
  * Figure 3: Cross-sectional correlation between true positive predictability indicators
  * Figure 4: Relative forecasting performance during high uncertainty periods
  * Figure 5: Relative forecasting performance conditioned on Kilian real economic activity
  * Figure 6: Monitoring variable time paths alongside identified predictability windows
  * Figure 7: Regulatory loss ratios and annualized Sharpe ratio gains
* Reproduction of supplementary figures (Figures 1_supp through 9_supp) and Table 1_supp
* Output storage: High-resolution PDF and PNG artifacts under `reports/figures/`

---

## 2.9 Phase 6: Pipeline Orchestration
* Command line execution orchestrator: `src/pipeline/orchestrator.py`
* Sole execution entry point: `run()` method without top-level `main()` functions
* Support for modular execution flags:
  * `--tier 0`: Direct regeneration of figures and summary metrics from `results.xls`
  * `--tier 1`: Re-estimation of RLS and dynamic rotation across all 18 predictors
  * `--spot-check`: Single variable rapid validation (`k=4`, WTI Petroleum tracker)
* Execution command format: `/opt/homebrew/bin/uv run python -m src.pipeline.orchestrator --tier 0`

---

## 3.1 Documentation Roadmap
* Sub-document roadmap modeled on `girstmair-2026`:
  * `docs/final_overview.md`: Executive replication synthesis and final verdict
  * `docs/quickstart_docs.md`: Navigation index and fast routing guide
  * `docs/sanity_draft_check.md`: Audit checklist reconciling paper text with figures
  * `docs/architecture/architecture.md`: Mathematical DAG, solvers, and pipeline contracts
  * `docs/architecture/claims.md`: Formal econometric claims and artifact crosswalk
  * `docs/architecture/data.md`: Variable definitions, data transformations, and sample splits
  * `docs/replication/replication_log.md`: Ledger tracking reproduction status of every table and figure
  * `docs/replication/reexecution_guide.md`: Step-by-step reproduction runbook
  * `docs/replication/figures.md`: Visual comparison audit of reproduced figures against `.fig` baselines

---

## 3.2 Verification and Parity Gates
* Automated pytest test suite: `tests/`
  * `tests/test_matio.py`: Verification of Excel and `.mat` loaders
  * `tests/test_rls.py`: Parity of recursive least squares against MATLAB oracle
  * `tests/test_dynamic_rotation.py`: Parity of forecast rotation against MATLAB oracle
  * `tests/test_metrics.py`: Clark-West and Diebold-Mariano tests against `results.xls`
  * `tests/test_claims.py`: PDF extracted claims compared with replication outputs
* Parity threshold criteria:
  * Deterministic matrix calculations: absolute difference $\le 10^{-10}$
  * Statistical p-values and test statistics: absolute difference $\le 10^{-6}$
  * Visual figure comparisons: zero structural or trend discrepancies

---

## 3.3 Risks and Mitigation Strategies
* Computational runtime for full 18-variable dynamic rotation:
  * Mitigation: Implement vectorized numpy operations; preserve `--spot-check` mode (`k=4`) for rapid testing
* Excel formatting and missing value encoding:
  * Mitigation: Explicit forward-fill and nan-filtering mirroring lines 36-41 of `main.m`
* MATLAB version compatibility differences (R2009b vs modern releases):
  * Mitigation: Package relies on standard linear algebra and basic indexing; verify edge cases via local R2025b oracle
* Read-only repository isolation:
  * Mitigation: Strict read-only file handling; all Python outputs redirected to `data/` and `reports/`

---

## 3.4 Micro-Commit Staging Sequence
* Micro-commit schedule adhering to global format rules:
  1. `DOCS Add master replication plan for Nonejad (2026)` (`docs/original_plan.md`)
  2. `ADD uv project configuration and dependencies` (`pyproject.toml`)
  3. `ADD config loader and path resolver` (`src/config.py`, `references/configs/pipeline.yaml`)
  4. `ADD variable and monitoring registries` (`references/dictionaries/MONITORING_VARIABLES.py`)
  5. `ADD read-only matio and excel loader` (`src/utils/matio.py`)
  6. `ADD pdf text and table extraction pipeline` (`src/claims/extract_text.py`, `src/claims/parse_tables.py`)
  7. `ADD recursive least squares and dynamic rotation models` (`src/models/rls.py`, `src/models/dynamic_rotation.py`)
  8. `ADD beta-binomial learning solver` (`src/models/beta_binomial.py`)
  9. `ADD forecast evaluation and loss metrics` (`src/utils/metrics.py`, `src/utils/loss.py`)
  10. `ADD data preprocessing pipeline` (`src/data/transforms.py`)
  11. `ADD matplotlib reproduction figures` (`src/viz/plots.py`)
  12. `ADD pipeline orchestrator` (`src/pipeline/orchestrator.py`)
  13. `ADD numerical parity test suite` (`tests/test_parity.py`)
