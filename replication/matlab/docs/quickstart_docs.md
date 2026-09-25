# MATLAB Replication Documentation Directory

## 1. Table of Contents
* 1.1 Overview
* 1.2 Documentation Index
* 1.3 Recommended Reading Sequences

---

## 1.1 Overview
* Fast reference catalog mapping all documentation artifacts across system architecture, execution runbooks, and audit logs
* Targets replication of Nonejad (2026), *IJF* under `replication/matlab/`

---

## 1.2 Documentation Index

| Directory | Document | Scope & Purpose |
|---|---|---|
| `docs/` | [`final_overview.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/final_overview.md) | Executive replication whitepaper, empirical synthesis, reproducibility verdict, and discrepancies in plain terms |
| `docs/` | [`quickstart_docs.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/quickstart_docs.md) | Single-screen documentation index and routing guide |
| `docs/` | [`sanity_draft_check.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/sanity_draft_check.md) | Manuscript draft audit reconciling text claims with figures and tables |
| `architecture/` | [`architecture.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/architecture.md) | Econometric DAG, RLS, Dynamic Forecast Rotation, and Beta-Binomial learning |
| `architecture/` | [`claims.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/claims.md) | Core paper hypotheses, monitoring variables, and artifact crosswalk |
| `architecture/` | [`data.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/data.md) | Dataset catalog (`my.xls`, `mx.xls`, `mz.xls`, `usrec.xls`), transformations, and sample calendars |
| `replication/` | [`replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md) | The technical record: artifact ledger for all 7 manuscript and 9 supplementary figures, open and resolved discrepancies against `results.xls`, re-execution runbook including environment settings, and reviewer verification protocol |
| `replication/` | [`figures.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/figures.md) | Visual comparison audit of reproduced figures against `.fig` reference plots |
| `docs/` | [`readme.txt`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/readme.txt) | Upstream author readme with step-by-step replication instructions |

---

## 1.3 Recommended Reading Sequences
* For Executive Findings: Start with [`final_overview.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/final_overview.md)
* For Pipeline Execution: Follow the runbook sections (1.7) of [`replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md)
* For Replication Status: Start with the discrepancy tracker (section 1.6) of [`replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md)
* For Figure & Table Audits: Inspect [`replication_log.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/replication_log.md) and [`figures.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/replication/figures.md)
* For Model & Data Definitions: Consult [`architecture.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/architecture.md) and [`data.md`](file:///Users/cory/Desktop/ifj-editor/nonejad-2026/replication/matlab/docs/architecture/data.md)
