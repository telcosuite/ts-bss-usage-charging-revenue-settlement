| Field | Value |
| --- | --- |
| Feature ID | F-usage-charging-revenue-settlement-001 |
| App | Usage Charging Revenue Settlement |
| App slug | `usage-charging-revenue-settlement` |
| Module | Usage, Charging, And Revenue Settlement |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Rating Simulation Online Charging And Policy Control Feature Specification


Reviewed: 2026-06-07

Suite: BSS Commercial

App: [Usage, Charging, And Revenue Settlement](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Source gap review: [E2E Feature Gap Assessment](../../../e2e-feature-gap-assessment.md)

Feature area slug: `rating-simulation-online-charging-and-policy-control`

E2E gap severity: High

## Feature Intent

Validate rate plans, online charging, balance reservation, policy control, and tax behavior before usage impacts customer balances or bills.

Rating Simulation Online Charging And Policy Control turns that intent into a controlled usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control capability: the app owns the rating simulation online charging and policy control lifecycle state, validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule, and leaves network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data consumers with auditable status rather than spreadsheet or direct-database workarounds.

## Personas Covered

- Revenue assurance analyst: detects leakage, missing usage, rating errors, and bill mismatches.
- Billing operations user: monitors usage-to-bill readiness and rerating issues.
- Partner finance user: manages revenue sharing and settlement.
- Wholesale operations user: reconciles roaming, interconnect, MVNO, and partner traffic.
- Charging integration owner: manages rating, charging, taxation, and financial posting handoff.

## Persona-Specific Outcomes

| Persona | Decision rights and jobs-to-be-done | Feature outcome |
| --- | --- | --- |
| Revenue assurance analyst | Reviews and reconciles rating simulation online charging and policy control financial state, postings, adjustments, settlement, and audit evidence. | Revenue assurance analyst can complete, approve, monitor, or audit rating simulation online charging and policy control with usage/CDR/charging/settlement/revenue-assurance context state, network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff status, and immutable policy/evidence trail. |
| Billing operations user | Reviews and reconciles rating simulation online charging and policy control financial state, postings, adjustments, settlement, and audit evidence. | Billing operations user can complete, approve, monitor, or audit rating simulation online charging and policy control with usage/CDR/charging/settlement/revenue-assurance context state, network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff status, and immutable policy/evidence trail. |
| Partner finance user | Reviews and reconciles rating simulation online charging and policy control financial state, postings, adjustments, settlement, and audit evidence. | Partner finance user can complete, approve, monitor, or audit rating simulation online charging and policy control with usage/CDR/charging/settlement/revenue-assurance context state, network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff status, and immutable policy/evidence trail. |
| Wholesale operations user | Reviews rating simulation online charging and policy control partner-facing status, settlement, dispute, or task evidence within the partner entitlement boundary. | Wholesale operations user can complete, approve, monitor, or audit rating simulation online charging and policy control with usage/CDR/charging/settlement/revenue-assurance context state, network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff status, and immutable policy/evidence trail. |
| Charging integration owner | Acts on rating simulation online charging and policy control only within usage acceptance, mediation exception, rating/charging reconciliation, balance reservation outcome, leakage case, settlement approval, rerating decision, dispute outcome, tax evidence, and policy control handoff decisions and role-based evidence visibility. | Charging integration owner can complete, approve, monitor, or audit rating simulation online charging and policy control with usage/CDR/charging/settlement/revenue-assurance context state, network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff status, and immutable policy/evidence trail. |

## Core User Journeys Covered

| Step | User or system intent | Feature responsibility |
| ---: | --- | --- |
| 1 | Intake request, signal, or dependency from the upstream app, user, partner, event, or API consumer. | Rating Simulation Online Charging And Policy Control captures the intake and source authority for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; it records rating simulation online charging and policy control state, correlation ID, source channel, owner, policy decision, and network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff evidence. |
| 2 | Validate eligibility, policy, commercial, operational, regulatory, and data-quality context. | Rating Simulation Online Charging And Policy Control validates eligibility, policy, and dependency state for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; it records rating simulation online charging and policy control state, correlation ID, source channel, owner, policy decision, and network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff evidence. |
| 3 | Coordinate downstream tasks, events, notifications, and state transitions across the owning apps. | Rating Simulation Online Charging And Policy Control orchestrates owned lifecycle updates and downstream handoffs for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; it records rating simulation online charging and policy control state, correlation ID, source channel, owner, policy decision, and network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff evidence. |
| 4 | Resolve exceptions, retries, approvals, compensation, or manual intervention. | Rating Simulation Online Charging And Policy Control routes fallout, approval, retry, cancellation, or compensation work for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; it records rating simulation online charging and policy control state, correlation ID, source channel, owner, policy decision, and network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff evidence. |
| 5 | Close the journey with reconciliation, evidence, reporting, and feedback into planning or operations. | Rating Simulation Online Charging And Policy Control publishes completion, reconciliation, and evidence events for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; it records rating simulation online charging and policy control state, correlation ID, source channel, owner, policy decision, and network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data handoff evidence. |

## Missing Use Cases And Scenarios

| Scenario | Required behavior |
| --- | --- |
| Happy path | Rating Simulation Online Charging And Policy Control must support this path for rating simulation online charging and policy control: Usage events or CDRs are ingested, enriched, deduplicated, rated/charged, taxed, exposed as consumption, billed, settled, and reconciled with revenue assurance evidence. |
| Assisted path | Rating Simulation Online Charging And Policy Control must support this path for rating simulation online charging and policy control: Revenue assurance or billing operations resolves mediation exception, missing inventory/customer reference, rating mismatch, tax jurisdiction issue, or settlement dispute before billing or payout. |
| Automated path | Rating Simulation Online Charging And Policy Control must support this path for rating simulation online charging and policy control: Network, partner, charging, tax, billing, and finance systems exchange idempotent usage, charge, rerate, settlement, and reconciliation events. |
| Partner path | Rating Simulation Online Charging And Policy Control must support this path for rating simulation online charging and policy control: Partner, roaming, interconnect, MVNO, wholesale, or marketplace usage is rated against agreement terms and included in settlement reports and payout approvals. |
| Care path | Rating Simulation Online Charging And Policy Control must support this path for rating simulation online charging and policy control: A customer usage inquiry or dispute links consumption, CDR, rated charge, tax evidence, bill item, rerating decision, and customer communication. |
| Fraud/leakage path | Rating Simulation Online Charging And Policy Control must support this path for rating simulation online charging and policy control: A revenue assurance or fraud signal opens a case from missing usage, duplicate CDR, bypass pattern, abnormal roaming, or settlement variance. |

## Core Workflow And Control Points

| Control point | Required behavior | Evidence captured |
| --- | --- | --- |
| Trigger | Start rating simulation online charging and policy control from a network usage file, CDR stream, partner usage feed, charging event, balance reservation request, rating result, bill dispute, roaming/interconnect settlement file, revenue assurance anomaly, or policy-control event with source channel, actor, tenant, customer/account/product/order references where applicable, and idempotency key. | Intake timestamp, source, actor, correlation ID, initiating record, and submitted payload hash. |
| Validation | Validate usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule before mutating usage/CDR/charging/settlement/revenue-assurance context state or handing work to another app. | Validation result, policy decision, source authority, missing fields, and permitted next action. |
| Orchestration | Coordinate network mediation sources, partner platforms and clearinghouses, online/offline charging, tax engines, Billing for billable charges and disputes, Finance/ERP for settlement and revenue close, Credit/Fraud for usage fraud, Product Catalog for rate plan context, Customer Care for usage inquiries, policy control systems, and DWH/lakehouse using APIs, events, workflow tasks, or governed projections while preserving app mastership: Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities. | Downstream owner, dependency state, request/response reference, retry counter, and event IDs. |
| Exception | Route rating simulation online charging and policy control fallout, policy failures, manual approvals, retries, rollback, compensation, and cancellation to accountable queues. | Queue owner, severity, due date, customer/revenue/compliance impact, reason code, comments, and evidence links. |
| Completion | Close rating simulation online charging and policy control only when owned lifecycle state, downstream handoffs, reconciliation, notifications, and reporting facts are complete or explicitly excepted. | Completion state, before/after values, reconciliation result, notification status, approver, and closure event. |
| Evidence | Preserve audit and regulatory evidence for CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls with role-aware masking and retention/legal-hold controls. | Audit log, policy version, document/evidence reference, retention class, legal hold flag, and export controls. |

## Detailed Feature Backlog

| Feature ID | Feature | Parent feature area | Priority guidance |
| --- | --- | --- | --- |
| F-rating-simulation-online-charging-and-policy-control-01 | Rating simulator | Rating Simulation Online Charging And Policy Control | P1/P2: closes High E2E gap when rating simulator gates usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; implementation must include API/event contract, exception queue, and evidence before pilot exit. |
| F-rating-simulation-online-charging-and-policy-control-02 | Rate plan sync validation | Rating Simulation Online Charging And Policy Control | P1/P2: closes High E2E gap when rate plan sync validation gates usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; implementation must include API/event contract, exception queue, and evidence before pilot exit. |
| F-rating-simulation-online-charging-and-policy-control-03 | Online charging interaction | Rating Simulation Online Charging And Policy Control | P1/P2: closes High E2E gap when online charging interaction gates usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; implementation must include API/event contract, exception queue, and evidence before pilot exit. |
| F-rating-simulation-online-charging-and-policy-control-04 | Balance reservation check | Rating Simulation Online Charging And Policy Control | P1/P2: closes High E2E gap when balance reservation check gates usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; implementation must include API/event contract, exception queue, and evidence before pilot exit. |
| F-rating-simulation-online-charging-and-policy-control-05 | Policy control decision handoff | Rating Simulation Online Charging And Policy Control | P1/P2: closes High E2E gap when policy control decision handoff gates usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; implementation must include API/event contract, exception queue, and evidence before pilot exit. |
| F-rating-simulation-online-charging-and-policy-control-06 | Pre-bill charging audit | Rating Simulation Online Charging And Policy Control | P1/P2: closes High E2E gap when pre-bill charging audit gates usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence; implementation must include API/event contract, exception queue, and evidence before pilot exit. |

## Acceptance Criteria

### Intake and ownership

Feature detail: Accept requests from UI, API, event, workflow, partner channel, or upstream app while assigning a clear owner and lifecycle state. For rating simulation online charging and policy control, this controls usage/CDR/charging/settlement/revenue-assurance context through usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control while respecting that Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities.

Acceptance criteria:

1. **AC-rating-simulation-online-charging-and-policy-control-01-01 Happy path:** Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete intake and ownership for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
2. **AC-rating-simulation-online-charging-and-policy-control-01-02 Assisted path:** Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in intake and ownership, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
3. **AC-rating-simulation-online-charging-and-policy-control-01-03 Automated path:** Given an API consumer or event submits rating simulation online charging and policy control data for intake and ownership, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
4. **AC-rating-simulation-online-charging-and-policy-control-01-04 Exception path:** Given validation, downstream response, or compliance control fails during intake and ownership, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
5. **AC-rating-simulation-online-charging-and-policy-control-01-05 Completion evidence:** Given intake and ownership is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.

### Validation and policy control

Feature detail: Validate required data, source authority, permissions, consent, regulatory policy, tenant/geography boundary, and dependency references. For rating simulation online charging and policy control, this controls usage/CDR/charging/settlement/revenue-assurance context through usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control while respecting that Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities.

Acceptance criteria:

1. **AC-rating-simulation-online-charging-and-policy-control-02-01 Happy path:** Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete validation and policy control for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
2. **AC-rating-simulation-online-charging-and-policy-control-02-02 Assisted path:** Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in validation and policy control, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
3. **AC-rating-simulation-online-charging-and-policy-control-02-03 Automated path:** Given an API consumer or event submits rating simulation online charging and policy control data for validation and policy control, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
4. **AC-rating-simulation-online-charging-and-policy-control-02-04 Exception path:** Given validation, downstream response, or compliance control fails during validation and policy control, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
5. **AC-rating-simulation-online-charging-and-policy-control-02-05 Completion evidence:** Given validation and policy control is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.

### Cross-app orchestration

Feature detail: Coordinate APIs, events, tasks, projections, notifications, and retry behavior with each downstream owner. For rating simulation online charging and policy control, this controls usage/CDR/charging/settlement/revenue-assurance context through usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control while respecting that Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities.

Acceptance criteria:

1. **AC-rating-simulation-online-charging-and-policy-control-03-01 Happy path:** Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete cross-app orchestration for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
2. **AC-rating-simulation-online-charging-and-policy-control-03-02 Assisted path:** Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in cross-app orchestration, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
3. **AC-rating-simulation-online-charging-and-policy-control-03-03 Automated path:** Given an API consumer or event submits rating simulation online charging and policy control data for cross-app orchestration, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
4. **AC-rating-simulation-online-charging-and-policy-control-03-04 Exception path:** Given validation, downstream response, or compliance control fails during cross-app orchestration, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
5. **AC-rating-simulation-online-charging-and-policy-control-03-05 Completion evidence:** Given cross-app orchestration is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.

### Exception and compensation

Feature detail: Route fallout, partial failure, rollback, cancellation, amendment, or compensation to accountable queues with evidence. For rating simulation online charging and policy control, this controls usage/CDR/charging/settlement/revenue-assurance context through usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control while respecting that Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities.

Acceptance criteria:

1. **AC-rating-simulation-online-charging-and-policy-control-04-01 Happy path:** Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete exception and compensation for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
2. **AC-rating-simulation-online-charging-and-policy-control-04-02 Assisted path:** Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in exception and compensation, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
3. **AC-rating-simulation-online-charging-and-policy-control-04-03 Automated path:** Given an API consumer or event submits rating simulation online charging and policy control data for exception and compensation, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
4. **AC-rating-simulation-online-charging-and-policy-control-04-04 Exception path:** Given validation, downstream response, or compliance control fails during exception and compensation, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
5. **AC-rating-simulation-online-charging-and-policy-control-04-05 Completion evidence:** Given exception and compensation is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.

### Reporting and closure

Feature detail: Close only after reconciliation, evidence capture, operational metrics, and downstream completion signals are available. For rating simulation online charging and policy control, this controls usage/CDR/charging/settlement/revenue-assurance context through usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control while respecting that Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities.

Acceptance criteria:

1. **AC-rating-simulation-online-charging-and-policy-control-05-01 Happy path:** Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete reporting and closure for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
2. **AC-rating-simulation-online-charging-and-policy-control-05-02 Assisted path:** Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in reporting and closure, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
3. **AC-rating-simulation-online-charging-and-policy-control-05-03 Automated path:** Given an API consumer or event submits rating simulation online charging and policy control data for reporting and closure, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
4. **AC-rating-simulation-online-charging-and-policy-control-05-04 Exception path:** Given validation, downstream response, or compliance control fails during reporting and closure, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
5. **AC-rating-simulation-online-charging-and-policy-control-05-05 Completion evidence:** Given reporting and closure is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.

## Negative Scenarios

| Scenario | Expected behavior |
| --- | --- |
| Unauthorized rating simulation online charging and policy control access or mutation | Reject the request, mask usage/CDR/charging/settlement/revenue-assurance context data, and record actor, channel, tenant, policy decision, and correlation ID. |
| Missing mandatory rating simulation online charging and policy control context | Keep rating simulation online charging and policy control in draft, blocked, or rejected state with field-level errors for usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and do not publish downstream handoff events. |
| Invalid rating simulation online charging and policy control lifecycle transition | Block the transition, show allowed next states, preserve prior state/version, and require permitted role or automated policy to resubmit. |
| Conflicting master data for rating simulation online charging and policy control | Route correction to the owning app named by data mastery and prevent local shadow updates to customer, catalog, order, inventory, billing, usage, risk, or partner masters. |
| Downstream network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency unavailable | Fail fast for synchronous decisions or queue controlled retry with owner, due date, backoff policy, and customer/revenue impact flag. |
| Duplicate, stale, or out-of-order rating simulation online charging and policy control request | Use optimistic locking, event version, source timestamp, and idempotency key so retries cannot duplicate work or corrupt current state. |
| Policy, consent, regulatory, or geography breach | Stop the transaction, preserve the policy decision, notify only permitted roles, and enforce CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls. |
| Manual override for rating simulation online charging and policy control | Require approval role, reason code, expiry, compensating action, post-action review, and searchable audit evidence. |
| Sensitive evidence requested for rating simulation online charging and policy control | Mask or deny restricted KYC, payment, fraud, complaint, usage, tax, or legal evidence while keeping operational task status visible. |
| Reconciliation mismatch after rating simulation online charging and policy control completion | Reopen or hold closure until network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data state agrees or an approved exception with finance/customer/compliance impact is recorded. |

## Edge Cases

| Edge case | Expected handling |
| --- | --- |
| Bulk or project-scale rating simulation online charging and policy control processing | Support validation preview, staged commit, partial failure report, throttling, replay, and rollback or repair plan before production release. |
| Long-running rating simulation online charging and policy control journey | Expose waiting, blocked, retrying, escalated, compensated, corrected, and completed states with timers, owners, and customer/revenue impact. |
| Historical rating simulation online charging and policy control correction | Allow effective-dated correction with reason, old/new values, approver, downstream recalculation trigger, and retention/legal-hold validation. |
| Multi-brand, multi-tenant, or data-residency boundary | Apply tenant, brand, market, geography, language, currency, and data-residency controls consistently in UI, API, event, and reporting paths. |
| High-volume operational period for rating simulation online charging and policy control | Protect critical flows with pagination, async export, queue back-pressure, circuit breakers, dashboard filters, and runbook-defined load-shedding. |
| Duplicate or out-of-order CDR | Use CDR identifiers, source sequence, event timestamp, and idempotency keys to prevent duplicate charging and preserve replay evidence. |
| Late usage after invoice release | Create rerating, bill adjustment, tax evidence, and customer/partner dispute workflow rather than silently changing billed totals. |
| Partner settlement variance | Hold payout for the settlement period, show CDR/usage/rate-plan evidence, and queue partner finance approval or dispute. |
| Online charging reservation timeout | Apply charging-policy fallback, preserve balance reservation evidence, and reconcile with prepay balance and policy-control systems. |
| CDR privacy/legal hold conflict | Mask restricted usage data for care/analytics while preserving lawful retention, legal hold, and regulatory evidence. |

## Suite Gap Review Closure Addendum

Source review: [02 Bss Commercial Gap Review](../../../../suite-gap-reviews/02-bss-commercial-gap-review.md)

This addendum applies the suite gap-review findings tied to this feature file. It supplements the baseline feature specification and should be carried into epic, story, API, event, data, and test refinement.

### Review Backlog Items Addressed

| Severity | Gap-review item | Closure expectation |
| --- | --- | --- |
| High | Online/offline charging consistency and balance reservation controls. | Add concrete happy path, negative path, edge-case, API/event/data control, reporting, and test evidence for this feature area. |

### Acceptance Criteria Additions

1. Given a usage batch or stream must be replayed, when replay is requested, then duplicate detection, source lineage, affected bills/settlements/tax, financial impact, and approval are calculated before commit.
2. Given online and offline charging disagree, when reconciliation runs, then the app opens an exception with balance impact, customer impact, source owner, and correction path.
3. Given a partner disputes settlement, when evidence is reviewed, then usage lineage, rating basis, revenue-share model, tax/withholding, payout hold, and resolution decision are preserved.

### Negative Scenario Additions

1. A late roaming file arrives after settlement close; reopen under approved adjustment path and preserve partner impact evidence.
2. Duplicate API usage events inflate billable usage; dedupe using idempotency/source event and raise revenue assurance case.
3. Rerating changes tax after customer bill release; require corrected bill/tax evidence and finance approval.

### API, Event, Data, And Reporting Updates

- Add or refine command/query APIs so the owning app remains the system of record and consumers do not bypass app APIs.
- Add lifecycle events for the reviewed gap, including created, validated, blocked, approved, completed, failed, corrected, replayed, and reconciliation-failed variants where applicable.
- Capture idempotency keys, correlation IDs, source freshness, lineage, confidence, policy version, owner, SLA/OLA timers, and audit evidence.
- Add dashboards or operational reports for aging, failure reason, confidence/quality, consumer impact, exception backlog, and closure proof.
- Extend the test approach with happy-path, negative, edge-case, contract, event replay, data reconciliation, security, accessibility, and operational-readiness tests for the listed review items.

## API, Event, And Data Requirements

Related APIs and API areas: [TMF635](../../../../../references/tmforum-open-apis/openapi-specs/TMF635_UsageManagement), [TMF677](../../../../../references/tmforum-open-apis/openapi-specs/TMF677_UsageConsumption), TMF654, [TMF678](../../../../../references/tmforum-open-apis/openapi-specs/TMF678_CustomerBill), [TMF620](../../../../../references/tmforum-open-apis/openapi-specs/TMF620_ProductCatalog)

TMF API fit and extension notes:

- Use TMF635, TMF677, TMF654, TMF678, TMF620 for the TMF resource areas already identified in this feature specification; do not replace those resources with local-only contracts when the TMF API covers the lifecycle or query behavior.
- Extension APIs are allowed only for mediation rule administration, rating simulation, online charging balance reservation handoff, policy control decision capture, usage dispute/rerating workflow, tax evidence ledger, leakage/fraud rule library, and wholesale settlement exception workflow where no direct TMF resource exists; each extension must be explicitly labelled non-TMF, documented with OpenAPI, and aligned to TMF-style id, href, lifecycle state, relatedParty, relatedEntity, error, pagination, and event-envelope patterns where practical.
- Command APIs for rating simulation online charging and policy control must cover create/initiate, validate, update, approve/reject, hold/release, cancel, rollback or compensate where applicable, retry, correct, and close.
- Query APIs for rating simulation online charging and policy control must cover search, detail, timeline, related usage/CDR/charging/settlement/revenue-assurance context references, dependency graph, work queue, metrics, and audit/evidence retrieval with role-aware masking.
- Domain events for rating simulation online charging and policy control must include created, validated, blocked, approved, rejected, updated, handoff requested, exception raised, exception resolved, cancelled, compensated, completed, corrected, and reconciliation failed where the lifecycle uses those states.

Data and ownership requirements:

- Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities; other apps consume rating simulation online charging and policy control state through APIs, events, governed projections, workflow tasks, or certified data products.
- Store source channel, actor, tenant/brand/market, external references, status reason, timestamps, policy decision, before/after values, related customer/account/product/order/bill/usage/ticket references where applicable, and evidence links.
- Keep read projections, analytics extracts, and DWH/lakehouse outputs separate from operational writes so Rating Simulation Online Charging And Policy Control does not create shadow mastership.
- Provide reconciliation outputs that prove network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependencies have completed, failed, or remain explicitly owned.

Integration and handoff requirements:

- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with network mediation sources through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with partner platforms and clearinghouses through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with online/offline charging through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with tax engines through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with Billing for billable charges and disputes through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with Finance/ERP for settlement and revenue close through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with Credit/Fraud for usage fraud through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with Product Catalog for rate plan context through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with Customer Care for usage inquiries through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with policy control systems through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.
- Rating Simulation Online Charging And Policy Control must exchange rating simulation online charging and policy control state or evidence with DWH/lakehouse through APIs, events, workflow tasks, files, or governed projections as appropriate to that owner.

## Non-Functional Requirements

- Scale and latency: high-volume CDR ingestion with back-pressure, mediation replay without duplicate billing, usage/consumption query P95 below 500 ms, 99.9% availability for charging-facing APIs, auditable CDR retention, and resilient settlement batch recovery.
- Availability and resilience: Rating Simulation Online Charging And Policy Control must support 99.9% or higher availability for interactive and API paths that gate usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence, with queue back-pressure, retry, replay, and circuit-breaker controls for downstream integrations.
- Auditability and retention: rating simulation online charging and policy control history must preserve actor, channel, reason, old/new value, policy version, approval, event ID, external reference, and retention/legal-hold class for CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls.
- Localization and accessibility: Rating Simulation Online Charging And Policy Control user tasks, customer/partner communications, currency/date formats, invoice or offer disclosures where applicable, and error messages must support market localization, WCAG-aligned accessibility, and role-aware data masking.
- Data protection: API, event, export, and dashboard paths must enforce tenant isolation, data residency, purpose limitation, least privilege, field-level masking, and secure evidence storage for usage/CDR/charging/settlement/revenue-assurance context.

## Compliance, Security, And Privacy

- Rating Simulation Online Charging And Policy Control must enforce CDR retention for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce privacy masking for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce lawful/regulatory evidence for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce tax jurisdiction evidence for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce roaming/interconnect audit for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce partner settlement evidence for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce revenue assurance controls for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce data residency for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce tenant isolation for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce legal hold for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Rating Simulation Online Charging And Policy Control must enforce export controls for rating simulation online charging and policy control records, UI actions, API payloads, events, reports, and evidence exports.
- Privileged actions on rating simulation online charging and policy control require role-based approval, reason code, expiration where relevant, and post-action review by usage operations, charging integration, revenue assurance, wholesale settlement, partner finance, and billing operations.
- Sensitive usage/CDR/charging/settlement/revenue-assurance context evidence must be masked in search, timelines, exports, analytics, partner views, and operational dashboards unless the persona has a permitted purpose.

## Observability And Operations

- Metrics: track rating simulation online charging and policy control intake volume, validation failure rate, policy rejection rate, automation rate, manual override rate, queue aging, retry count, cancellation/rollback/compensation count, reconciliation mismatch, and completion quality by tenant, market, channel, product, partner, and owning team.
- Queues: provide work queues for draft, pending validation, pending approval, blocked dependency, exception, retrying, customer-impacting, revenue-impacting, compliance-impacting, compensated, corrected, completed, and archived rating simulation online charging and policy control records.
- Alerts: alert usage operations, charging integration, revenue assurance, wholesale settlement, partner finance, and billing operations when rating simulation online charging and policy control queue aging, downstream failure, event publication failure, reconciliation mismatch, abnormal policy override, or SLA/OLA breach risk exceeds threshold.
- Runbooks: document triage, retry, replay, rollback, compensation, manual approval, customer/partner communication, evidence export, and reconciliation steps for Rating Simulation Online Charging And Policy Control.
- Replay and reconciliation: support idempotent replay for events, files, callbacks, and workflow tasks so Rating Simulation Online Charging And Policy Control can recover without duplicate usage/CDR/charging/settlement/revenue-assurance context state or lost audit history.
- Ownership: usage operations, charging integration, revenue assurance, wholesale settlement, partner finance, and billing operations owns first-line operational health; architecture, data, security, and compliance teams own policy and conformance review for the rating simulation online charging and policy control lifecycle.

## Test Approach

| Test layer | Required coverage |
| --- | --- |
| Unit tests | Field rules, lifecycle transitions, policy decisions, duplicate detection, effective dating, masking, and usage/CDR/charging/settlement/revenue-assurance context state calculations for rating simulation online charging and policy control. |
| API contract tests | Commands, queries, errors, idempotency, pagination, filtering, version compatibility, and TMF-aligned payloads for TMF635, TMF677, TMF654, TMF678, TMF620 plus documented extension APIs. |
| Event contract tests | rating simulation online charging and policy control event names, payload shape, changed fields, correlation ID, idempotency key, ordering metadata, replay behavior, and subscriber compatibility. |
| Workflow tests | Happy path, assisted path, automated path, partner/channel path, approval, exception, timeout, retry, cancellation, rollback, compensation, correction, and closure for usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control. |
| Integration tests | Handoffs with network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data owners, external provider unavailability, eventual consistency, reconciliation, and no direct database access. |
| Security and privacy tests | Tenant isolation, role permissions, consent/purpose checks, sensitive-data masking, malicious payloads, audit logging, legal hold, retention, and export controls for CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls. |
| Data tests | Source authority, referential integrity, historical correction, projection refresh, DWH/lakehouse extract, reporting metrics, and data-quality stewardship for usage/CDR/charging/settlement/revenue-assurance context. |
| Performance and resilience tests | Search, list, bulk import/export, queue throughput, API throughput, event replay, retry storm, downstream outage, and batch recovery under realistic telecom volumes. |
| Operational acceptance tests | Dashboards, alerts, runbooks, queue ownership, SLA/OLA reporting, reconciliation reports, and evidence export for usage operations, charging integration, revenue assurance, wholesale settlement, partner finance, and billing operations. |

## Out Of Scope And Dependencies

- Rating Simulation Online Charging And Policy Control does not master entities assigned to another app in the data mastery document; it stores only its app-owned rating simulation online charging and policy control state, transaction snapshots, references, projections, and evidence.
- Direct writes to another app database, reference database, external engine, payment gateway, tax engine, credit bureau, fraud provider, clearinghouse, ERP, network controller, or partner platform remain out of scope.
- Downstream execution by network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data owners remains with those apps; Rating Simulation Online Charging And Policy Control must track dependency state, retry status, and reconciliation evidence.
- Platform identity, authorization, policy, audit, notification, eventing, API gateway, workflow, reporting, data retention, and data residency capabilities must be available before production rollout.
- Any non-TMF extension API must be documented, reviewed by architecture, and tested alongside TMF Open API contracts before external exposure.

## Feature Detail Review Implementation Alignment (2026-06-14)

Source: [App Feature Detail Review Alignment](README.md#feature-detail-review-alignment-2026-06-14) and [Suite Feature Detail Review](../../feature-detail-review.md).

Apply this app review scope to this feature: usage ingestion, mediation exceptions, rating, charging and tax handoff, replay and reconciliation, revenue assurance, and partner or wholesale settlement.

Implementation updates required for this feature:

- Re-check the core workflows and add or adjust happy paths, approval paths, exception queues, rollback or compensation behavior, and handoffs so the review scope is directly represented in build stories.
- Add or refine UI workbench expectations, including operator queues, evidence panels, policy decision traces, preview/simulation views, and status dashboards where this feature owns the behavior.
- Add or refine command APIs, query APIs, events, app-owned data fields, DDL gap notes, and integration handoffs needed to support the review scope without crossing app data ownership boundaries.
- Add acceptance criteria for source authority, tenant and residency controls, lifecycle state, approval evidence, idempotency, correlation IDs, SLA/OLA timers, and downstream acknowledgement where applicable.
- Add negative scenarios for stale data, duplicate events, policy denial, missing evidence, downstream outage, unauthorized access, bulk/replay risk, and manual override misuse.
- Extend tests to include happy path, negative path, edge case, API contract, event replay, data reconciliation, security, accessibility, observability, runbook, and release-gate evidence for the review scope.

## Build-Ready Refinement (2026-06-14)

This refinement converts the feature review material for Rating Simulation Online Charging And Policy Control into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Usage, Charging, And Revenue Settlement as the owning application for this feature within Suite BSS Commercial and schema `usage_revenue_settlement`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Rating Simulation Online Charging And Policy Control workbench for Revenue assurance analyst, Billing operations user, Partner finance user, Wholesale operations user, Charging integration owner. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose create, validate, approve, correct, close, and audit rating simulation online charging and policy control state and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around rating-simulation-online-charging-and-policy-control using TMF635, TMF677, TMF654, TMF678, TMF620. Command APIs for rating simulation online charging and policy control must cover create/initiate, validate, update, approve/reject, hold/release, cancel, rollback or compensate where applicable, retry, correct, and... Query APIs for rating simulation online charging and policy control must cover search, detail, timeline, related usage/CDR/charging/settlement/revenue-assurance context references, dependency graph, work queue, metrics... Domain events for rating simulation online charging and policy control must include created, validated, blocked, approved, rejected, updated, handoff requested, exception raised, exception resolved, cancelled... Extension APIs are allowed only for mediation rule administration, rating simulation, online charging balance reservation handoff, policy control decision capture, usage dispute/rerating workflow, tax evidence ledger... Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist rating simulation online charging and policy control record inside `usage_revenue_settlement` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax... Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange not yet specified with the upstream and downstream owners named in the app README, modules-and-features, suite data model, TMF review, and DDL traceability files only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Rating Simulation Online Charging And Policy Control. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Rating Simulation Online Charging And Policy Control. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - usage ingestion, mediation exceptions, rating, charging and tax handoff, replay and reconciliation, revenue assurance, and partner or wholesale settlement. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Usage, Charging, And Revenue Settlement as the lifecycle owner for rating simulation online charging and policy control record; referenced data such as not yet specified must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. Product owner has approved Rating Simulation Online Charging And Policy Control scope for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence with personas, decision rights, happy path, assisted path, automated path, partner/channel path, and back-office path covered.
2. Architecture owner has approved ODA boundaries, TMF635, TMF677, TMF654, TMF678, TMF620 usage, extension API notes, event contracts, integration handoffs, and private app database assumptions for rating simulation online charging and policy control.
3. QA owner has automated or explicitly documented acceptance, negative, edge, API, event, workflow, integration, security, privacy, data, performance, resilience, and regression tests for rating simulation online charging and policy control.
4. Operations owner has dashboards, queues, alerts, runbooks, replay/reconciliation procedures, SLA/OLA measures, and ownership model ready for usage operations, charging integration, revenue assurance, wholesale settlement, partner finance, and billing operations.
5. Data owner has confirmed source authority, app-owned fields, related entity references, projection/data-product behavior, lineage, retention, legal hold, and reporting measures for usage/CDR/charging/settlement/revenue-assurance context.
6. Compliance and security owners have approved CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls controls, evidence retention, masking, tenant/data-residency enforcement, and privileged-action review.


## Build-Ready Refinement (2026-06-15)

Header added at the top of this file. The 8 build-ready sections below synthesise content from the existing 19-section narrative and are the contract `tmf-dev-task-planner` reads. Source citations are inline.

## Persona & decision

- Not applicable — feature has no separate persona (single shared workflow).

## Lifecycle ownership

- This app owns the lifecycle state of the planning record listed in the source `## Telecom Objects And Decision Rights`. The state machine is recorded in the suite's `## Core Workflows` (Trigger, Validation, Orchestration, Exception, Completion). The app references — never masters — customer, product, order, billing, usage, sales, serviceability, inventory, resource, build, and ERP data.
- Source: [features/<this>.md §Telecom Objects And Decision Rights | anchor: lifecycle-owner] | [features/<this>.md §Core Workflows | anchor: lifecycle-states]

## TMF fit

- TMF API baseline for this app: (none captured in tmf-api-ddl-reviews).
- Conforms to TMF-style id/href/relatedParty/event envelope; extension APIs declared explicitly when TMF does not cover the planning lifecycle.

## Data fit

- Owns schema `usage_charging_revenue_settlement`; the V001 migration lists the owned tables: (none captured).
- Source: [database/postgres/suites/ts_bss_commercial/V001__create_app_schemas_and_starter_tables.sql §schema | anchor: schema-list]

## Path coverage

- Happy path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Assisted path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Automated path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Exception path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Bulk path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Historical path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Multi-tenant path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Regulatory path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Source: [features/<this>.md §Edge Cases | anchor: paths] | [features/<this>.md §Missing Use Cases And Scenarios | anchor: paths]

## UI implications

- Pages / workbenches (per the app's `Required app screens / workbenches` block in `dev-tasks/development-task-tracker.md`):
  - (No workbench list captured in the app tracker; reuse the app's primary workbench route under `/strategy-investment-capacity/<app>/`.)
- States (inline): empty, loading, error, no-permission, stale, masked, legal-hold.
- Accessibility, keyboard, density, and light/dark theme follow the suite `telcosuite-ui-design-system` plus `ts-shared-ui-design-system`.
- Source: [development-task-tracker.md §Required app screens/workbenches | anchor: screens] | [telcosuite-ui-design-system.md | anchor: ux-baseline]

## Acceptance & tests

- AC1 (AC-rating-simulation-online-charging-and-policy-control-01-01): Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete intake and ownership for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
- AC2 (AC-rating-simulation-online-charging-and-policy-control-01-02): Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in intake and ownership, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
- AC3 (AC-rating-simulation-online-charging-and-policy-control-01-03): Given an API consumer or event submits rating simulation online charging and policy control data for intake and ownership, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
- AC4 (AC-rating-simulation-online-charging-and-policy-control-01-04): Given validation, downstream response, or compliance control fails during intake and ownership, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
- AC5 (AC-rating-simulation-online-charging-and-policy-control-01-05): Given intake and ownership is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.
- AC6 (AC-rating-simulation-online-charging-and-policy-control-02-01): Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete validation and policy control for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
- AC7 (AC-rating-simulation-online-charging-and-policy-control-02-02): Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in validation and policy control, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
- AC8 (AC-rating-simulation-online-charging-and-policy-control-02-03): Given an API consumer or event submits rating simulation online charging and policy control data for validation and policy control, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
- AC9 (AC-rating-simulation-online-charging-and-policy-control-02-04): Given validation, downstream response, or compliance control fails during validation and policy control, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
- AC10 (AC-rating-simulation-online-charging-and-policy-control-02-05): Given validation and policy control is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.
- AC11 (AC-rating-simulation-online-charging-and-policy-control-03-01): Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete cross-app orchestration for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
- AC12 (AC-rating-simulation-online-charging-and-policy-control-03-02): Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in cross-app orchestration, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
- AC13 (AC-rating-simulation-online-charging-and-policy-control-03-03): Given an API consumer or event submits rating simulation online charging and policy control data for cross-app orchestration, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
- AC14 (AC-rating-simulation-online-charging-and-policy-control-03-04): Given validation, downstream response, or compliance control fails during cross-app orchestration, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
- AC15 (AC-rating-simulation-online-charging-and-policy-control-03-05): Given cross-app orchestration is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.
- AC16 (AC-rating-simulation-online-charging-and-policy-control-04-01): Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete exception and compensation for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
- AC17 (AC-rating-simulation-online-charging-and-policy-control-04-02): Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in exception and compensation, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
- AC18 (AC-rating-simulation-online-charging-and-policy-control-04-03): Given an API consumer or event submits rating simulation online charging and policy control data for exception and compensation, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
- AC19 (AC-rating-simulation-online-charging-and-policy-control-04-04): Given validation, downstream response, or compliance control fails during exception and compensation, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
- AC20 (AC-rating-simulation-online-charging-and-policy-control-04-05): Given exception and compensation is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.
- AC21 (AC-rating-simulation-online-charging-and-policy-control-05-01): Given a permitted Revenue assurance analyst has valid usage/CDR/charging/settlement/revenue-assurance context, when they complete reporting and closure for rating simulation online charging and policy control, then the app validates usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule and stores the accepted lifecycle state with owner, timestamp, source channel, and correlation ID.
- AC22 (AC-rating-simulation-online-charging-and-policy-control-05-02): Given rating simulation online charging and policy control needs manual review, when a persona resolves missing data, approval, or policy conflict in reporting and closure, then the app shows the blocking network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependency, captures comments/evidence, and resumes the same lifecycle instance without duplicate work.
- AC23 (AC-rating-simulation-online-charging-and-policy-control-05-03): Given an API consumer or event submits rating simulation online charging and policy control data for reporting and closure, when the payload is valid and idempotent, then the app returns a contract-compliant state, emits the required event, and keeps read projections separate from app-owned writes.
- AC24 (AC-rating-simulation-online-charging-and-policy-control-05-04): Given validation, downstream response, or compliance control fails during reporting and closure, when the exception is raised, then the app assigns an accountable queue with severity, due date, retry/rollback/compensation option, customer or revenue impact, and evidence requirements.
- AC25 (AC-rating-simulation-online-charging-and-policy-control-05-05): Given reporting and closure is ready to close for rating simulation online charging and policy control, when downstream handoffs and reconciliation are complete, then the app records before/after values, approval or policy decision, related entity references, metrics, and evidence links for audit and reporting.
- Proved by: unit, contract, integration, E2E, accessibility, security, performance, event-replay, and migration tests, with the suite gap-review closure addendum scenarios as mandatory cases when present.
- Source: [features/<this>.md §Acceptance Criteria | anchor: ac-list]

## Dependencies & release gate

- Depends on: dev-tasks tracker `Required app screens/workbenches` block; the suite's P01 foundation tasks; cross-app TMF and event contracts listed under `## API, Event, And Data Requirements`.
- Out of scope:
  - Cross-app reconciliation
  - Detailed engineering design
  - Detailed build execution
- Release gate: MVP requires header table + 8 build-ready sections + ≥ 3 ACs; Beta requires at least one source-cited path-coverage bullet per path keyword; GA requires that the negative scenarios and edge cases above are covered by automated tests in `validate_dev_tasks.py`.
- Source: [development-task-tracker.md | anchor: release-gate]
