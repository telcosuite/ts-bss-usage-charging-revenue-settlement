# Usage, Charging, And Revenue Settlement P03 - Rating Charging And Tax Integration Development Tasks

Suite: BSS Commercial

App: Usage, Charging, And Revenue Settlement

App slug: `usage-charging-revenue-settlement`

Implementation repository: `ts-bss-usage-charging-revenue-settlement`

Phase: P03 - Rating Charging And Tax Integration

Phase file: `P03-rating-charging-and-tax-integration.md`

Phase rationale: Build the Rating, Charging, And Tax Integration capability cluster for Usage, Charging, And Revenue Settlement, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work.

Phase exit gate: Usage, Charging, And Revenue Settlement can execute the Rating, Charging, And Tax Integration workflows through UI, API, `usage_revenue_settlement` persistence, outbox events, audit evidence, and release tests.

Out of scope for this phase: Runtime bootstrap is in P01; unrelated feature clusters and post-launch operations remain in their own phases.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [Rating, Charging, And Tax Integration](../features/rating-charging-and-tax-integration.md)

## Phase Tasks

### DT-02-usage-charging-revenue-settlement-P03-T001: Build Rating, Charging, And Tax Integration API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P03 - Rating Charging And Tax Integration |
| Priority | P0 |
| Source evidence | [Rating, Charging, And Tax Integration](../features/rating-charging-and-tax-integration.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../usage-charging-revenue-settlement.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Rating, Charging, And Tax Integration |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/bsscommercial/usagechargingrevenuesettlement/RatingChargingAndTaxIntegrationController.java`, `usage_revenue_settlement.rating_charging_and_tax_integration`, `contracts/events/RatingChargingAndTaxIntegrationStateChangedEvent.json`, and `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration` |
| Dependencies | DT-02-usage-charging-revenue-settlement-P01-T013 |
| Outputs | `RatingChargingAndTaxIntegrationController`, `RatingChargingAndTaxIntegrationService`, `usage_revenue_settlement.rating_charging_and_tax_integration` migration, `RatingChargingAndTaxIntegrationStateChangedEvent` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration` using TMF620, TMF635, TMF677, TMF678, TMF735, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Rating, Charging, And Tax Integration` state in `usage_revenue_settlement.rating_charging_and_tax_integration` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `RatingChargingAndTaxIntegrationStateChangedEvent` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: create or update, validate, close.
- Carry source details into code and tests for personas authorized operator and objects rating charging and tax integration; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `usage_revenue_settlement.rating_charging_and_tax_integration.id`, and appends `RatingChargingAndTaxIntegrationStateChangedEvent` to `usage_revenue_settlement.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Rating, Charging, And Tax Integration` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `usage_revenue_settlement.rating_charging_and_tax_integration` is required.

#### Definition Of Done

- `RatingChargingAndTaxIntegrationController`, service, repository, DTOs, validation, error model, and migration for `usage_revenue_settlement.rating_charging_and_tax_integration` are committed under `ts-bss-usage-charging-revenue-settlement`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration`, `usage_revenue_settlement.rating_charging_and_tax_integration`, and `RatingChargingAndTaxIntegrationStateChangedEvent`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration` return `403` and write a denial audit row instead of exposing `Rating, Charging, And Tax Integration` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `usage_revenue_settlement.rating_charging_and_tax_integration` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `RatingChargingAndTaxIntegrationStateChangedEvent` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Rating, Charging, And Tax Integration` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `usage_revenue_settlement.rating_charging_and_tax_integration` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `RatingChargingAndTaxIntegrationService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/02-bss-commercial/usage-charging-revenue-settlement/v1/rating-charging-and-tax-integration` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `usage_revenue_settlement.rating_charging_and_tax_integration` columns and indexes; event replay tests validate `contracts/events/RatingChargingAndTaxIntegrationStateChangedEvent.json` and `usage_revenue_settlement.event_outbox` ordering.

### DT-02-usage-charging-revenue-settlement-P03-T002: Build Rating, Charging, And Tax Integration workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P03 - Rating Charging And Tax Integration |
| Priority | P1 |
| Source evidence | [Rating, Charging, And Tax Integration](../features/rating-charging-and-tax-integration.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../usage-charging-revenue-settlement.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Rating, Charging, And Tax Integration |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/rating-charging-and-tax-integration/`, `tests/e2e/rating-charging-and-tax-integration.spec.ts`, Grafana panel `rating-charging-and-tax-integration`, and `docs/operations-runbook.md#rating-charging-and-tax-integration` |
| Dependencies | DT-02-usage-charging-revenue-settlement-P03-T001 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/rating-charging-and-tax-integration/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas authorized operator.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows create or update, validate, close, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/usage-charging-revenue-settlement/rating-charging-and-tax-integration`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Rating, Charging, And Tax Integration` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `rating-charging-and-tax-integration` refreshes, then it shows the metric and links to `docs/operations-runbook.md#rating-charging-and-tax-integration`.

#### Definition Of Done

- `frontend/src/app/pages/rating-charging-and-tax-integration/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/rating-charging-and-tax-integration.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Rating, Charging, And Tax Integration` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Rating, Charging, And Tax Integration` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/rating-charging-and-tax-integration.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-02-usage-charging-revenue-settlement-P03-T003: Prove Rating Charging And Tax Integration release gate, replay, and handoff evidence

| Field | Value |
| --- | --- |
| Phase | P03 - Rating Charging And Tax Integration |
| Priority | P1 |
| Source evidence | [Rating, Charging, And Tax Integration](../features/rating-charging-and-tax-integration.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../usage-charging-revenue-settlement.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Rating Charging And Tax Integration |
| Build area | Test/Ops/Release/Event |
| Target artifact | `tests/release/rating-charging-and-tax-integration.spec.ts`, `docs/release-notes/rating-charging-and-tax-integration.md`, Grafana dashboard `rating-charging-and-tax-integration`, and replay fixtures |
| Dependencies | DT-02-usage-charging-revenue-settlement-P03-T002 |
| Outputs | Release-gate test, replay/reconciliation evidence, accessibility/security/performance reports, dashboard/runbook links, support handoff notes |
| Missing evidence | No |

#### Implementation Notes

- Create a release-gate checklist for `rating-charging-and-tax-integration` covering Rating, Charging, And Tax Integration, with happy path, assisted path, negative path, edge cases, event replay, data reconciliation, security, accessibility, performance, and support evidence.
- Record producer and consumer acknowledgements for phase events, reconcile `usage_revenue_settlement.event_outbox`, and link replay fixtures and correlation IDs.
- Update `docs/operations-runbook.md`, `docs/release-notes/rating-charging-and-tax-integration.md`, and `development-task-tracker.md` with release evidence and unresolved blockers.

#### Acceptance Criteria

1. Given all tasks in `P03-rating-charging-and-tax-integration.md` are complete, when `tests/release/rating-charging-and-tax-integration.spec.ts` runs, then it returns exit code `0` and links evidence for UI, API, data, event, security, ops, and test gates.
2. Given a consumer rejects an event from `rating-charging-and-tax-integration`, when replay is triggered, then the replay fixture preserves `$.correlationId`, `$.eventId`, and consumer acknowledgement state.
3. Given release notes are generated, when support reviews `docs/release-notes/rating-charging-and-tax-integration.md`, then open blockers, rollback steps, runbook links, and ownership contacts are present.

#### Definition Of Done

- `tests/release/rating-charging-and-tax-integration.spec.ts`, replay fixtures, dashboard/runbook links, and release notes are committed.
- Accessibility, security, contract, migration, event replay, performance, and operational-readiness evidence is linked from the tracker.
- Open blockers have owner, due date, target increment, and rollback or removal criteria.

#### Negative Scenarios

- Do not mark the phase Done if event replay, reconciliation, accessibility, security, or downstream acknowledgement evidence is missing.
- Do not release `rating-charging-and-tax-integration` with unresolved cross-app writes, direct schema coupling, or stale source authority assumptions.
- Do not suppress failed release gates; record failures with owner, due date, and target increment.

#### Edge Cases

- Coordinated release gates may require downstream app windows; record scheduling, owner, and fallback route in release notes.
- Historical backfill, replay, bulk update, or migration repair runs must include preview, partial failure report, and rollback evidence.
- High-volume launch periods require dashboard thresholds, alert owners, queue back-pressure, and support escalation paths.

#### Test Expectations

- `tests/release/rating-charging-and-tax-integration.spec.ts`, `mvn test`, OpenAPI/event replay tests, Flyway checks, Playwright/Cypress E2E, accessibility, security, and k6/performance gates pass.
- `docker compose config`, clean-checkout smoke, `helm lint`, Kubernetes dry-run, dashboard JSON validation, and runbook link checks pass.
- Tracker evidence links command output, PRs, screenshots, replay payloads, dashboards, release notes, and support handoff notes.
