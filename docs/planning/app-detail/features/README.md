# Usage, Charging, And Revenue Settlement App Feature Specifications

Reviewed: 2026-06-07

This folder contains the build-ready feature specifications for the Usage, Charging, And Revenue Settlement app in Suite 02 BSS Commercial. Each specification defines concrete usage/CDR/charging/settlement/revenue-assurance context lifecycle behavior, personas and decision rights, use cases, workflow controls, Given/When/Then acceptance criteria, TMF API fit, extension notes, integrations, NFRs, compliance controls, observability, and definition of done.

Parent app: [Usage, Charging, And Revenue Settlement App](../README.md)

## Suite 02 Domain Lenses

- Primary journey coverage: usage ingestion, mediation, charging, rating, tax, consumption, revenue assurance, partner revenue sharing, roaming/interconnect/wholesale settlement, rerating, dispute, and policy control.
- BSS lens: usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence.
- Data boundary: Usage, Charging, And Revenue Settlement owns usage ingestion batch, mediation exception, CDR transaction, usage consumption summary, revenue assurance case, revenue sharing model/report context, settlement exception, rerating/dispute, tax evidence, and policy-control handoff context while network, clearinghouse, charging engine, tax engine, and ERP systems may remain external authorities.
- Integration handoffs: network mediation sources, partner platforms and clearinghouses, online/offline charging, tax engines, Billing for billable charges and disputes, Finance/ERP for settlement and revenue close, Credit/Fraud for usage fraud, Product Catalog for rate plan context, Customer Care for usage inquiries, policy control systems, and DWH/lakehouse.
- Compliance focus: CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls.

## Feature Specification Index

| Feature specification | Commercial outcome | API basis | Evidence and control focus |
| --- | --- | --- | --- |
| [CDR Governance And Usage Fraud Leakage](cdr-governance-and-usage-fraud-leakage.md) | Govern CDR retention, privacy, replay, anomaly detection, usage fraud signals, and leakage controls by usage type and partner. | TMF735, TMF635, TMF677, TMF644, TMF696 | CDR Governance And Usage Fraud Leakage must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Partner Revenue Sharing](partner-revenue-sharing.md) | Manage revenue sharing algorithms, models, settlement periods, partner reports, partner payouts, partner usage, catalog item linkage, and marketplace commercial models. | TMF736, TMF737, TMF738 | Partner Revenue Sharing must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Rating, Charging, And Tax Integration](rating-charging-and-tax-integration.md) | Integrate rating, online charging, offline charging, taxation, invoicing, financial posting, rerating, tax errors, charging adjustments, and reconciliation status. | TMF620, TMF635, TMF677, TMF735, TMF678 | Rating, Charging, And Tax Integration must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Rating Simulation Online Charging And Policy Control](rating-simulation-online-charging-and-policy-control.md) | Validate rate plans, online charging, balance reservation, policy control, and tax behavior before usage impacts customer balances or bills. | TMF635, TMF677, TMF654, TMF678, TMF620 | Rating Simulation Online Charging And Policy Control must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Revenue Assurance](revenue-assurance.md) | Reconcile usage, orders, inventory, billing, payments, settlement, rating, and charging. Detect leakage, missing usage, rating failures, bill mismatches, duplicate records, and financial risk. | TMF696, TMF735, TMF678 | Revenue Assurance must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Roaming, Interconnect, And Wholesale Settlement](roaming-interconnect-and-wholesale-settlement.md) | Manage settlement inputs for roaming, interconnect, wholesale, MVNO, partner, and marketplace traffic. Reconcile rates, disputes, reports, missing/late/duplicate records, and partner exposure. | TMF635, TMF735, TMF668, TMF651, TMF736, TMF737, TMF738 | Roaming, Interconnect, And Wholesale Settlement must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Usage Consumption](usage-consumption.md) | Expose usage by customer, product, service, account, period, geography, service type, threshold, alert, and summary. Support care, self-care, charging, analytics, and revenue assurance. | TMF677 | Usage Consumption must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Usage Dispute Rerating And Tax Evidence](usage-dispute-rerating-and-tax-evidence.md) | Support usage disputes, rerating, tax jurisdiction evidence, customer explanation, and downstream bill adjustment handoff. | TMF635, TMF677, TMF678, TMF621, TMF681 | Usage Dispute Rerating And Tax Evidence must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |
| [Usage Ingestion And Mediation](usage-ingestion-and-mediation.md) | Ingest usage events, product usage, CDRs, resource usage, platform usage, and partner usage. Validate, enrich, deduplicate, route, replay, and manage mediation exceptions. | TMF635, TMF735, TMF771 | Usage Ingestion And Mediation must preserve lifecycle state, decision owner, correlation ID, exception queue, and reconciliation evidence for usage-to-cash, partner-to-settle, fraud/leakage control, charging policy handoff, and govern-to-comply CDR/tax evidence. |

## Implementation Guardrails

- Keep app-owned writes inside the app boundary; other apps use APIs, events, governed projections, workflow tasks, or certified data products.
- Preserve the TMF API references already identified in each feature file and label any non-TMF extension API explicitly.
- Validate usage source, event timestamp, product/customer/account reference, service/resource reference, CDR uniqueness, mediation enrichment, rating plan version, charge/tax jurisdiction, partner agreement, settlement period, privacy/retention policy, and fraud/leakage rule before accepting work that affects usage/CDR/charging/settlement/revenue-assurance context state.
- Record source channel, actor, tenant/market, related entity references, policy decision, before/after values, correlation ID, and evidence links for every material usage/CDR/charging/settlement/revenue-assurance context change.
- Route unresolved network, partner, charging, tax, billing, finance, fraud, catalog, care, policy, and data dependencies to visible queues with owner, severity, due date, retry/rollback/compensation path, and customer/revenue/compliance impact.
- Enforce CDR retention, privacy masking, lawful/regulatory evidence, tax jurisdiction evidence, roaming/interconnect audit, partner settlement evidence, revenue assurance controls, data residency, tenant isolation, legal hold, and export controls in UI, API, event, dashboard, export, and evidence-retrieval paths.

## Definition Of Feature Completion

A feature specification in this folder is implementation-ready only when product, architecture, QA, operations, data, security, and compliance owners can trace the feature from persona decision rights through API/event contracts, negative scenarios, NFRs, observability, evidence retention, and cross-app handoff closure.

## Feature Detail Review Alignment (2026-06-14)

Source: [Suite Feature Detail Review](../../feature-detail-review.md) and [Critical Feature Review Enhancements](../modules-and-features.md#critical-feature-review-enhancements-2026-06-14).

The 2026-06-14 review upgrades this app feature set with required scope: usage ingestion, mediation exceptions, rating, charging and tax handoff, replay and reconciliation, revenue assurance, and partner or wholesale settlement.

Apply this scope when refining the feature specifications in this folder:

- Add or update epics, stories, UI workbenches, APIs, events, app-owned data fields, DDL gaps, test cases, observability, runbooks, and definition-of-done evidence for the review scope.
- Preserve the app data ownership boundary. Cross-app access must use APIs, events, workflow tasks, governed projections, or certified data products rather than direct database sharing.
- If this scope needs technology beyond Angular, Spring Boot, PostgreSQL, and PrimeNG, offer open-source options with pros, cons, and a recommendation before implementation.
