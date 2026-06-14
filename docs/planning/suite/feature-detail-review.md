# BSS Commercial Feature Detail Review

Reviewed: 2026-06-14

## Purpose

This document records the critical Suite 02 feature review across all BSS Commercial apps. It explains where the existing feature docs were strong, where they were too generic, and what was enhanced before implementation starts.

## Review Inputs

| Input | How it was used |
| --- | --- |
| [Suite Data Model](data-model.md) | Checked commercial data mastery, app schema ownership, transaction snapshots, financial audit, privacy, and cross-app references. |
| [Suite Tech And UI Guidance](tech-and-ui-guidance.md) | Checked dense enterprise workbench needs, shared commercial context patterns, and open-source technology decision points. |
| [Implementation File Usage Guide](implementation-file-usage-guide.md) | Checked whether feature scope points builders to TMF reviews, V002+ migrations, event contracts, endpoint tests, and privacy controls. |
| [Suite Journey Coverage](journey-coverage.md) | Checked lead-to-cash, MACD/returns, and revenue-close journeys for handoff and exception gaps. |
| App `modules-and-features.md` files | Reviewed each app's feature baseline and enhanced app-specific implementation gaps directly. |
| App `personas-and-user-journeys.md` files | Checked persona workflows for care, sales, order, billing, risk, finance, partner, and marketing users. |
| TMF API to DDL review files | Checked whether feature enhancements preserve TMF payload compatibility, app-owned schema boundaries, events, and privacy policies. |

## Critical Findings

| Area | Finding | Action taken |
| --- | --- | --- |
| Feature specificity | Existing app feature docs covered the right modules but repeated generic lifecycle behavior across many modules. | Added concrete commercial workbenches, decision points, screens, APIs, events, and first-release scope per app. |
| Customer and consent controls | Customer, marketing, sales, and care flows need explicit masking, consent, KYC, preference, vulnerability, and purpose-limitation behavior. | Added app-level controls for identity resolution, consent-safe engagement, quote/order snapshots, and role-aware UI exposure. |
| Transaction integrity | Quote, cart, order, billing, usage, payment, and settlement features need immutable snapshots, idempotency, correlation IDs, and reversal behavior. | Added requirements for transaction snapshot packs, checkout gates, order decomposition control, payment reconciliation, usage replay, and settlement evidence. |
| Financial and risk governance | Billing, credit, fraud, collections, disputes, revenue assurance, and partner settlement need auditable decisions and close/reconciliation controls. | Added financial-grade exception boards, approval gates, evidence packs, restriction/reconnection safeguards, and revenue assurance case handling. |
| Open-source tech decisions | Search, rules/decisioning, event streaming, document/evidence storage, and analytics may be needed but should not be forced. | Added decision prompts that require open-source options, pros/cons, and explicit owner choice before adoption. |

## App Review Summary

| App | Critical enhancement focus | Updated file |
| --- | --- | --- |
| Customer And Party 360 | Identity resolution, KYC/document evidence, consent and privacy, customer/account context, complaint and care timeline. | [customer-and-party-360/modules-and-features.md](customer-and-party-360/modules-and-features.md) |
| Product And Offer Studio | Catalog versioning, price/promotion governance, configuration validation, launch readiness, agreement/terms control. | [product-and-offer-studio/modules-and-features.md](product-and-offer-studio/modules-and-features.md) |
| Sales, CPQ, And Cart | Qualification, serviceability/risk gating, guided selling, quote/cart snapshots, approval and channel attribution. | [sales-cpq-cart/modules-and-features.md](sales-cpq-cart/modules-and-features.md) |
| Order Management Hub | Product order intake, decomposition, orchestration, jeopardy, fallout, cancellation/amendment, OSS handoff. | [order-management-hub/modules-and-features.md](order-management-hub/modules-and-features.md) |
| Billing, Payments, And Account Operations | Billing account operations, bill-cycle control, payment allocation, disputes, adjustments, collections handoff. | [billing-payments-account-operations/modules-and-features.md](billing-payments-account-operations/modules-and-features.md) |
| Usage, Charging, And Revenue Settlement | Usage ingestion, mediation exceptions, rating/charging/tax handoff, revenue assurance, partner/wholesale settlement. | [usage-charging-revenue-settlement/modules-and-features.md](usage-charging-revenue-settlement/modules-and-features.md) |
| Credit, Fraud, And Collections | Credit decisions, fraud case management, collections treatments, restriction/reconnection, dispute recovery. | [credit-fraud-collections/modules-and-features.md](credit-fraud-collections/modules-and-features.md) |
| Marketing, Campaign, And Customer Journey | Audience governance, campaign targeting, consent enforcement, journey orchestration, retention and loyalty treatments. | [marketing-campaign-customer-journey/modules-and-features.md](marketing-campaign-customer-journey/modules-and-features.md) |

## Suite 02 Build Implications

1. Build Customer And Party 360 before sales, care, billing, marketing, or risk flows that need canonical party/customer/account context.
2. Build Product And Offer Studio before CPQ so eligibility, pricing, terms, configuration, and launch readiness are controlled.
3. Build Sales, CPQ, And Cart and Order Management Hub as a paired lead-to-order flow with immutable quote/cart/order snapshots.
4. Build Billing, Payments, Usage, and Settlement around financial close, replay, reconciliation, and audit from the first release.
5. Build Credit, Fraud, And Collections as a decision/evidence system that drives actions through APIs/workflows, not manual back-channel restriction.
6. Build Marketing after customer, consent, catalog, and product inventory projections are dependable enough to avoid unsafe targeting.

## Remaining Build-Time Questions

| Question | Why it must be decided during implementation |
| --- | --- |
| Does customer/order/billing search need a dedicated search engine? | PostgreSQL search should be tried first; high-volume fuzzy search may need an open-source search engine decision. |
| Should eligibility, pricing, credit, fraud, and collections use a decision engine? | Start simple unless rule complexity, audit, and non-developer rule ownership require a rules/decision platform. |
| What eventing platform is needed for usage, order, payment, and risk events? | PostgreSQL outbox is the baseline; high-volume streaming needs a separate open-source broker decision. |
| Where should KYC, contract, invoice, dispute, and evidence files live? | PostgreSQL stores metadata; large or immutable evidence may need an object store such as MinIO. |
| Which financial and privacy endpoint contract tests are mandatory first? | Lead-to-cash and revenue-close flows cannot release without TMF conformance, masking, audit, idempotency, and reconciliation tests. |

## Recommendation

Suite 02 is now stronger for implementation planning. The next suite should be reviewed the same way: preserve the baseline, add app-specific commercial workflows, keep data mastery clear, identify open-source technology decisions, and make first-release scope explicit.
