# Graph Report - nonejad-2026  (2026-09-24)

## Corpus Check
- Corpus is ~10,949 words - fits in a single context window. You may not need a graph.

## Summary
- 30 nodes · 30 edges · 6 communities (5 shown, 1 thin omitted)
- Extraction: 90% EXTRACTED · 10% INFERRED · 0% AMBIGUOUS · INFERRED: 3 edges (avg confidence: 0.92)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- Bayesian Beta-Binomial Algorithm
- Dynamic Forecast Rotation & Sticky Expectations
- Monitoring Variables & Empirical Shock Indices
- Replication Data & Execution Workflows
- Manuscript & Author Repository
- Forecast Evaluation & Hypothesis Testing

## God Nodes (most connected - your core abstractions)
1. `Beta-Binomial Forecasting Algorithm` - 8 edges
2. `Detailed Replication Instructions (readme.txt)` - 6 edges
3. `Dynamic Forecast Rotation (DFR)` - 5 edges
4. `Set of 18 Monitoring Variables` - 5 edges
5. `Manuscript Figures Replication Workflow` - 3 edges
6. `Windows of Predictability` - 3 edges
7. `Replication Package README.md` - 2 edges
8. `Replication Package Repository` - 2 edges
9. `A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil` - 2 edges
10. `Sticky Expectations Theory` - 2 edges

## Surprising Connections (you probably didn't know these)
- `Manuscript Figures Replication Workflow` --implements--> `Beta-Binomial Forecasting Algorithm`  [INFERRED]
  original_files/ijfr/readme/readme.txt → drafts/IJF-D-26-00175_R3.pdf
- `Manuscript Figures Replication Workflow` --shares_data_with--> `Set of 18 Monitoring Variables`  [INFERRED]
  original_files/ijfr/readme/readme.txt → drafts/IJF-D-26-00175_R3.pdf
- `A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil` --references--> `Replication Package Repository`  [EXTRACTED]
  drafts/IJF-D-26-00175_R3.pdf → original_files/ijfr/README.md
- `Replication Package README.md` --references--> `Detailed Replication Instructions (readme.txt)`  [EXTRACTED]
  original_files/ijfr/README.md → original_files/ijfr/readme/readme.txt

## Hyperedges (group relationships)
- **Beta-Binomial Dynamic Rotation Forecasting Pipeline** — drafts_ijf_d_26_00175_r3_beta_binomial_algorithm, drafts_ijf_d_26_00175_r3_dynamic_forecast_rotation, drafts_ijf_d_26_00175_r3_bayesian_beta_binomial_model, drafts_ijf_d_26_00175_r3_dynamic_linear_model [EXTRACTED 1.00]
- **Theoretical Foundation of Predictability Windows** — drafts_ijf_d_26_00175_r3_windows_of_predictability, drafts_ijf_d_26_00175_r3_sticky_expectations_theory, drafts_ijf_d_26_00175_r3_mankiw_reis_2002, drafts_ijf_d_26_00175_r3_farmer_et_al_2023 [EXTRACTED 1.00]
- **Manuscript and Supplementary Replication Architecture** — original_files_ijfr_readme_readme_md, original_files_ijfr_readme_readme_readme_txt, original_files_ijfr_readme_readme_manuscript_replication, original_files_ijfr_readme_readme_supplementary_replication [EXTRACTED 1.00]

## Communities (6 total, 1 thin omitted)

### Community 0 - "Bayesian Beta-Binomial Algorithm"
Cohesion: 0.25
Nodes (8): Bayesian Beta-Binomial Conjugate Model, Beta-Binomial Forecasting Algorithm, Dynamic Linear Model (DLM) Base Predictive Models, Ellwanger and Snudden (2023), FRED-MD Database of Economic Variables, End-of-Month Price Random-Walk Benchmark, Spike-and-Slab Prior Hyperparameter Averaging, Nominal End-of-Month WTI Spot Price

### Community 1 - "Dynamic Forecast Rotation & Sticky Expectations"
Cohesion: 0.29
Nodes (7): Dynamic Forecast Rotation (DFR), Farmer, Schmidt, and Timmermann (2023), Mankiw and Reis (2002), Net Change Operation, Sticky Expectations Theory, Windows of Predictability, Zhu and Timmermann (2022)

### Community 2 - "Monitoring Variables & Empirical Shock Indices"
Cohesion: 0.40
Nodes (5): Caldara and Iacoviello (2022), Kilian (2009), Ludvigson, Ma, and Ng (2021), Set of 18 Monitoring Variables, Manuscript Figures Replication Workflow

### Community 3 - "Replication Data & Execution Workflows"
Cohesion: 0.40
Nodes (5): Replication Computing Environment, Replication Dataset Structure, Detailed Replication Instructions (readme.txt), Reference Results and Figures (results.xls), Supplementary Material Replication Workflow

### Community 4 - "Manuscript & Author Repository"
Cohesion: 0.67
Nodes (3): A Beta-Binomial Algorithm for Forecasting the Price of Crude Oil, Replication Package README.md, Replication Package Repository

## Knowledge Gaps
- **15 isolated node(s):** `Replication Computing Environment`, `Replication Dataset Structure`, `Reference Results and Figures (results.xls)`, `Supplementary Material Replication Workflow`, `Nominal End-of-Month WTI Spot Price` (+10 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 18 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **1 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Beta-Binomial Forecasting Algorithm` connect `Bayesian Beta-Binomial Algorithm` to `Dynamic Forecast Rotation & Sticky Expectations`, `Monitoring Variables & Empirical Shock Indices`, `Manuscript & Author Repository`?**
  _High betweenness centrality (0.516) - this node is a cross-community bridge._
- **Why does `Dynamic Forecast Rotation (DFR)` connect `Dynamic Forecast Rotation & Sticky Expectations` to `Bayesian Beta-Binomial Algorithm`, `Monitoring Variables & Empirical Shock Indices`?**
  _High betweenness centrality (0.380) - this node is a cross-community bridge._
- **Why does `Manuscript Figures Replication Workflow` connect `Monitoring Variables & Empirical Shock Indices` to `Bayesian Beta-Binomial Algorithm`, `Replication Data & Execution Workflows`?**
  _High betweenness centrality (0.322) - this node is a cross-community bridge._
- **Are the 2 inferred relationships involving `Manuscript Figures Replication Workflow` (e.g. with `Beta-Binomial Forecasting Algorithm` and `Set of 18 Monitoring Variables`) actually correct?**
  _`Manuscript Figures Replication Workflow` has 2 INFERRED edges - model-reasoned connections that need verification._
- **What connects `Replication Computing Environment`, `Replication Dataset Structure`, `Reference Results and Figures (results.xls)` to the rest of the system?**
  _15 weakly-connected nodes found - possible documentation gaps or missing edges._