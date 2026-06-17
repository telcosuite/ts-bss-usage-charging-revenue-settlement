# Usage, Charging, And Revenue Settlement Phase Discovery

## App Identity

| Field | Value |
| --- | --- |
| Suite | BSS Commercial |
| App | Usage, Charging, And Revenue Settlement |
| App slug | `usage-charging-revenue-settlement` |
| Implementation repo | `ts-bss-usage-charging-revenue-settlement` |
| Database | `ts_bss_commercial` |
| Schema | `usage_revenue_settlement` |
| APIs | TMF635, TMF735, TMF771, TMF677, TMF696, TMF678, TMF736, TMF737, TMF738, TMF620, TMF668, TMF651 |
| Generated date | 2026-06-17 |
| Phase/task signature | 7 phases / P01=14, P02=5, P03=3, P04=3, P05=5, P06=5, P07=3 |

Phase count decision: 7 phases are evidence-derived from the current app-repo state, P01 runtime bootstrap requirements, and 9 build-ready feature files grouped by lifecycle, UI/API/data/event ownership, integration risk, and release gates.

Repeated skeleton audit: Evidence-derived and accepted for this app. Even when another app shares a phase/task-count signature, this discovery file cites this app's feature files, phase files, current repo state, and split/merge decisions; regenerate and split or merge phases if those inputs change.

## Input Evidence Inventory

| Evidence | Link | Status |
| --- | --- | --- |
| App implementation usage | [../implementation-file-usage.md](../implementation-file-usage.md) | Present |
| App README | [../README.md](../README.md) | Present |
| Modules and features | [../modules-and-features.md](../modules-and-features.md) | Present |
| Personas and journeys | [../personas-and-user-journeys.md](../personas-and-user-journeys.md) | Present |
| Suite data model | [../../data-model.md](../../data-model.md) | Present |
| Suite tech/UI guidance | [../../tech-and-ui-guidance.md](../../tech-and-ui-guidance.md) | Present |
| Suite implementation guide | [../../implementation-file-usage-guide.md](../../implementation-file-usage-guide.md) | Present |
| Repository strategy | [../../../../repository-strategy.md](../../../../repository-strategy.md) | Present |
| Feature: CDR Governance And Usage Fraud Leakage | [../features/cdr-governance-and-usage-fraud-leakage.md](../features/cdr-governance-and-usage-fraud-leakage.md) | Present |
| Feature: Partner Revenue Sharing | [../features/partner-revenue-sharing.md](../features/partner-revenue-sharing.md) | Present |
| Feature: Rating, Charging, And Tax Integration | [../features/rating-charging-and-tax-integration.md](../features/rating-charging-and-tax-integration.md) | Present |
| Feature: Rating Simulation Online Charging And Policy Control | [../features/rating-simulation-online-charging-and-policy-control.md](../features/rating-simulation-online-charging-and-policy-control.md) | Present |
| Feature: Revenue Assurance | [../features/revenue-assurance.md](../features/revenue-assurance.md) | Present |
| Feature: Roaming, Interconnect, And Wholesale Settlement | [../features/roaming-interconnect-and-wholesale-settlement.md](../features/roaming-interconnect-and-wholesale-settlement.md) | Present |
| Feature: Usage Consumption | [../features/usage-consumption.md](../features/usage-consumption.md) | Present |
| Feature: Usage Dispute Rerating And Tax Evidence | [../features/usage-dispute-rerating-and-tax-evidence.md](../features/usage-dispute-rerating-and-tax-evidence.md) | Present |
| Feature: Usage Ingestion And Mediation | [../features/usage-ingestion-and-mediation.md](../features/usage-ingestion-and-mediation.md) | Present |

## App Repository Current State Inventory

| Marker | Value |
| --- | --- |
| Repo exists | Yes |
| Runnable frontend: | No |
| Runnable backend: | No |
| App-specific migrations: | Yes |
| OpenAPI contract | Yes |
| Event contracts | Yes |
| Deployment skeleton | Yes |
| CI workflow | No |
| Current implementation conclusion: | Keep the zero-to-one foundation explicit until runnable frontend, backend, migrations, contracts, CI, deployment, and proof-slice evidence are all present in `ts-bss-usage-charging-revenue-settlement`. |

## Feature/Module Cluster Analysis

| Feature | Feature ID | Source detail carried into tasks | Implementing task IDs | Phase |
| --- | --- | --- | --- | --- |
| [CDR Governance And Usage Fraud Leakage](../features/cdr-governance-and-usage-fraud-leakage.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P02-T003, DT-02-usage-charging-revenue-settlement-P02-T004, DT-02-usage-charging-revenue-settlement-P02-T005 | P02 - Usage Ingestion Mediation And Cdr Governance |
| [Partner Revenue Sharing](../features/partner-revenue-sharing.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P06-T003, DT-02-usage-charging-revenue-settlement-P06-T004, DT-02-usage-charging-revenue-settlement-P06-T005 | P06 - Revenue Assurance And Partner Revenue Sharing |
| [Rating, Charging, And Tax Integration](../features/rating-charging-and-tax-integration.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P03-T001, DT-02-usage-charging-revenue-settlement-P03-T002, DT-02-usage-charging-revenue-settlement-P03-T003 | P03 - Rating Charging And Tax Integration |
| [Rating Simulation Online Charging And Policy Control](../features/rating-simulation-online-charging-and-policy-control.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P04-T001, DT-02-usage-charging-revenue-settlement-P04-T002, DT-02-usage-charging-revenue-settlement-P04-T003 | P04 - Online Charging Policy Control And Simulation |
| [Revenue Assurance](../features/revenue-assurance.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P06-T001, DT-02-usage-charging-revenue-settlement-P06-T002, DT-02-usage-charging-revenue-settlement-P06-T005 | P06 - Revenue Assurance And Partner Revenue Sharing |
| [Roaming, Interconnect, And Wholesale Settlement](../features/roaming-interconnect-and-wholesale-settlement.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P07-T001, DT-02-usage-charging-revenue-settlement-P07-T002, DT-02-usage-charging-revenue-settlement-P07-T003 | P07 - Roaming Interconnect And Wholesale Settlement |
| [Usage Consumption](../features/usage-consumption.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P05-T001, DT-02-usage-charging-revenue-settlement-P05-T002, DT-02-usage-charging-revenue-settlement-P05-T005 | P05 - Usage Consumption Dispute And Rerating |
| [Usage Dispute Rerating And Tax Evidence](../features/usage-dispute-rerating-and-tax-evidence.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P05-T003, DT-02-usage-charging-revenue-settlement-P05-T004, DT-02-usage-charging-revenue-settlement-P05-T005 | P05 - Usage Consumption Dispute And Rerating |
| [Usage Ingestion And Mediation](../features/usage-ingestion-and-mediation.md) | F-usage-charging-revenue-settlement-001 |  | DT-02-usage-charging-revenue-settlement-P02-T001, DT-02-usage-charging-revenue-settlement-P02-T002, DT-02-usage-charging-revenue-settlement-P02-T005 | P02 - Usage Ingestion Mediation And Cdr Governance |

## Phase Decision Matrix

| Phase file | Task count | Evidence basis | Exit gate |
| --- | --- | --- | --- |
| [P01-from-scratch-app-foundation-and-delivery-runtime.md](P01-from-scratch-app-foundation-and-delivery-runtime.md) | 14 | The planning pack and local repo inspection do not prove a complete runnable implementation for `ts-bss-usage-charging-revenue-settlement`; this from-scratch foundation phase creates the app-root runtime, governance, contracts, data, CI, deployment, observability, and proof slice before feature delivery. | A clean checkout of `ts-bss-usage-charging-revenue-settlement` can run Angular and Spring Boot, apply `usage_revenue_settlement` migrations, validate contracts/events, run Docker Compose and Helm checks, and prove one UI/API/data/event slice. |
| [P02-usage-ingestion-mediation-and-cdr-governance.md](P02-usage-ingestion-mediation-and-cdr-governance.md) | 5 | Build the Usage Ingestion And Mediation, CDR Governance And Usage Fraud Leakage capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work. | Usage, Charging, And Revenue Settlement can execute the Usage Ingestion And Mediation, CDR Governance And Usage Fraud Leakage workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests. |
| [P03-rating-charging-and-tax-integration.md](P03-rating-charging-and-tax-integration.md) | 3 | Build the Rating, Charging, And Tax Integration capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work. | Usage, Charging, And Revenue Settlement can execute the Rating, Charging, And Tax Integration workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests. |
| [P04-online-charging-policy-control-and-simulation.md](P04-online-charging-policy-control-and-simulation.md) | 3 | Build the Rating Simulation Online Charging And Policy Control capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work. | Usage, Charging, And Revenue Settlement can execute the Rating Simulation Online Charging And Policy Control workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests. |
| [P05-usage-consumption-dispute-and-rerating.md](P05-usage-consumption-dispute-and-rerating.md) | 5 | Build the Usage Consumption, Usage Dispute Rerating And Tax Evidence capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work. | Usage, Charging, And Revenue Settlement can execute the Usage Consumption, Usage Dispute Rerating And Tax Evidence workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests. |
| [P06-revenue-assurance-and-partner-revenue-sharing.md](P06-revenue-assurance-and-partner-revenue-sharing.md) | 5 | Build the Revenue Assurance, Partner Revenue Sharing capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work. | Usage, Charging, And Revenue Settlement can execute the Revenue Assurance, Partner Revenue Sharing workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests. |
| [P07-roaming-interconnect-and-wholesale-settlement.md](P07-roaming-interconnect-and-wholesale-settlement.md) | 3 | Build the Roaming, Interconnect, And Wholesale Settlement capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work. | Usage, Charging, And Revenue Settlement can execute the Roaming, Interconnect, And Wholesale Settlement workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests. |

## Split/Merge Decisions

- P01 remains the app-runtime foundation because the local repo inspection does not prove a complete runnable implementation for `ts-bss-usage-charging-revenue-settlement`.
- Feature phases are grouped from source `features/*.md` files by lifecycle ownership, UI workbench/API/data/event coupling, security/privacy controls, observability, and release-test needs.
- Every feature file appears in task `Source evidence`, the tracker coverage matrix, and this discovery artifact; tracker-only feature references are not accepted as coverage.
- Generic phase names from older task packs are retired by this refresh and replaced with feature-derived phase names.

## Validator and Regeneration Notes

- Run `python3 telcosuite-skills/skills/tmf-dev-task-planner/scripts/validate_dev_tasks.py --root ts-planning/planning/suite-details/02-bss-commercial/usage-charging-revenue-settlement --strict` after refresh.
- Re-run the mirror driver after validation so `ts-bss-usage-charging-revenue-settlement/dev-tasks/` remains byte-identical to the planning source.
- If a source feature changes, refresh this app pack and verify phase count, feature coverage, task detail quality, and mirror parity again.
