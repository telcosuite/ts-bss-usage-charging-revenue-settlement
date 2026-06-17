# Usage, Charging, And Revenue Settlement P04 - Online Charging Policy Control And Simulation Development Tasks

Suite: BSS Commercial

App: Usage, Charging, And Revenue Settlement

App slug: `usage-charging-revenue-settlement`

Implementation repository: `ts-bss-usage-charging-revenue-settlement`

Phase: P04 - Online Charging Policy Control And Simulation

Phase file: `P04-online-charging-policy-control-and-simulation.md`

Phase rationale: Build the Rating Simulation Online Charging And Policy Control capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work.

Phase exit gate: Usage, Charging, And Revenue Settlement can execute the Rating Simulation Online Charging And Policy Control workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests.

Out of scope for this phase: Runtime bootstrap is in P01; unrelated feature clusters and post-launch operations remain in their own phases.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [Rating Simulation Online Charging And Policy Control](../features/rating-simulation-online-charging-and-policy-control.md)

## Phase Tasks

### DT-02-usage-charging-revenue-settlement-P04-T001: Build Rating Simulation Online Charging And Policy Control API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P04 - Online Charging Policy Control And Simulation |
| Priority | P0 |
| Source evidence | [Rating Simulation Online Charging And Policy Control](../features/rating-simulation-online-charging-and-policy-control.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../usage-charging-revenue-settlement.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Rating Simulation Online Charging And Policy Control |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/bsscommercial/usagechargingrevenuesettlement/RatingSimulationOnlineChargingAndPolicyControlController.java`, `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control`, `contracts/events/RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent.json`, and `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control` |
| Dependencies | DT-02-usage-charging-revenue-settlement-P01-T013 |
| Outputs | `RatingSimulationOnlineChargingAndPolicyControlController`, `RatingSimulationOnlineChargingAndPolicyControlService`, `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` migration, `RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control` using TMF620, TMF635, TMF654, TMF677, TMF678, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Rating Simulation Online Charging And Policy Control` state in `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: create or update, validate, close.
- Carry source details into code and tests for personas authorized operator and objects rating simulation online charging and policy control; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control.id`, and appends `RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent` to `usage_revenue_settlement.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Rating Simulation Online Charging And Policy Control` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` is required.

#### Definition Of Done

- `RatingSimulationOnlineChargingAndPolicyControlController`, service, repository, DTOs, validation, error model, and migration for `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` are committed under `ts-bss-usage-charging-revenue-settlement`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control`, `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control`, and `RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control` return `403` and write a denial audit row instead of exposing `Rating Simulation Online Charging And Policy Control` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Rating Simulation Online Charging And Policy Control` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `RatingSimulationOnlineChargingAndPolicyControlService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-simulation-online-charging-and-policy-control` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `usage_revenue_settlement.rating_simulation_online_charging_and_policy_control` columns and indexes; event replay tests validate `contracts/events/RatingSimulationOnlineChargingAndPolicyControlStateChangedEvent.json` and `usage_revenue_settlement.event_outbox` ordering.

### DT-02-usage-charging-revenue-settlement-P04-T002: Build Rating Simulation Online Charging And Policy Control workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P04 - Online Charging Policy Control And Simulation |
| Priority | P1 |
| Source evidence | [Rating Simulation Online Charging And Policy Control](../features/rating-simulation-online-charging-and-policy-control.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../usage-charging-revenue-settlement.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Rating Simulation Online Charging And Policy Control |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/rating-simulation-online-charging-and-policy-control/`, `tests/e2e/rating-simulation-online-charging-and-policy-control.spec.ts`, Grafana panel `rating-simulation-online-charging-and-policy-control`, and `docs/operations-runbook.md#rating-simulation-online-charging-and-policy-control` |
| Dependencies | DT-02-usage-charging-revenue-settlement-P04-T001 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/rating-simulation-online-charging-and-policy-control/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas authorized operator.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows create or update, validate, close, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/usage-charging-revenue-settlement/rating-simulation-online-charging-and-policy-control`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Rating Simulation Online Charging And Policy Control` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `rating-simulation-online-charging-and-policy-control` refreshes, then it shows the metric and links to `docs/operations-runbook.md#rating-simulation-online-charging-and-policy-control`.

#### Definition Of Done

- `frontend/src/app/pages/rating-simulation-online-charging-and-policy-control/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/rating-simulation-online-charging-and-policy-control.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Rating Simulation Online Charging And Policy Control` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Rating Simulation Online Charging And Policy Control` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/rating-simulation-online-charging-and-policy-control.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-02-usage-charging-revenue-settlement-P04-T003: Prove Online Charging Policy Control And Simulation release gate, replay, and handoff evidence

| Field | Value |
| --- | --- |
| Phase | P04 - Online Charging Policy Control And Simulation |
| Priority | P1 |
| Source evidence | [Rating Simulation Online Charging And Policy Control](../features/rating-simulation-online-charging-and-policy-control.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../usage-charging-revenue-settlement.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Online Charging Policy Control And Simulation |
| Build area | Test/Ops/Release/Event |
| Target artifact | `tests/release/online-charging-policy-control-and-simulation.spec.ts`, `docs/release-notes/online-charging-policy-control-and-simulation.md`, Grafana dashboard `online-charging-policy-control-and-simulation`, and replay fixtures |
| Dependencies | DT-02-usage-charging-revenue-settlement-P04-T002 |
| Outputs | Release-gate test, replay/reconciliation evidence, accessibility/security/performance reports, dashboard/runbook links, support handoff notes |
| Missing evidence | No |

#### Implementation Notes

- Create a release-gate checklist for `online-charging-policy-control-and-simulation` covering Rating Simulation Online Charging And Policy Control, with happy path, assisted path, negative path, edge cases, event replay, data reconciliation, security, accessibility, performance, and support evidence.
- Record producer and consumer acknowledgements for phase events, reconcile `usage_revenue_settlement.event_outbox`, and link replay fixtures and correlation IDs.
- Update `docs/operations-runbook.md`, `docs/release-notes/online-charging-policy-control-and-simulation.md`, and `development-task-tracker.md` with release evidence and unresolved blockers.

#### Acceptance Criteria

1. Given all tasks in `P04-online-charging-policy-control-and-simulation.md` are complete, when `tests/release/online-charging-policy-control-and-simulation.spec.ts` runs, then it returns exit code `0` and links evidence for UI, API, data, event, security, ops, and test gates.
2. Given a consumer rejects an event from `online-charging-policy-control-and-simulation`, when replay is triggered, then the replay fixture preserves `$.correlationId`, `$.eventId`, and consumer acknowledgement state.
3. Given release notes are generated, when support reviews `docs/release-notes/online-charging-policy-control-and-simulation.md`, then open blockers, rollback steps, runbook links, and ownership contacts are present.

#### Definition Of Done

- `tests/release/online-charging-policy-control-and-simulation.spec.ts`, replay fixtures, dashboard/runbook links, and release notes are committed.
- Accessibility, security, contract, migration, event replay, performance, and operational-readiness evidence is linked from the tracker.
- Open blockers have owner, due date, target increment, and rollback or removal criteria.

#### Negative Scenarios

- Do not mark the phase Done if event replay, reconciliation, accessibility, security, or downstream acknowledgement evidence is missing.
- Do not release `online-charging-policy-control-and-simulation` with unresolved cross-app writes, direct schema coupling, or stale source authority assumptions.
- Do not suppress failed release gates; record failures with owner, due date, and target increment.

#### Edge Cases

- Coordinated release gates may require downstream app windows; record scheduling, owner, and fallback route in release notes.
- Historical backfill, replay, bulk update, or migration repair runs must include preview, partial failure report, and rollback evidence.
- High-volume launch periods require dashboard thresholds, alert owners, queue back-pressure, and support escalation paths.

#### Test Expectations

- `tests/release/online-charging-policy-control-and-simulation.spec.ts`, `mvn test`, OpenAPI/event replay tests, Flyway checks, Playwright/Cypress E2E, accessibility, security, and k6/performance gates pass.
- `docker compose config`, clean-checkout smoke, `helm lint`, Kubernetes dry-run, dashboard JSON validation, and runbook link checks pass.
- Tracker evidence links command output, PRs, screenshots, replay payloads, dashboards, release notes, and support handoff notes.
