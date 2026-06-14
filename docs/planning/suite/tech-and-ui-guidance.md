# BSS Commercial Tech And UI Guidance

This document guides implementation of the BSS Commercial suite. It applies the shared [Technology Stack Guidance](../../technology-stack-guidance.md) and [TelcoSuite UI Design System](../../telcosuite-ui-design-system.md) to customer, catalog, marketing, sales, order, billing, risk, usage, charging, and settlement apps.

## Apps Covered

| App | Implementation focus |
| --- | --- |
| Customer And Party 360 | Party, customer, account, consent, interaction, document, and customer context |
| Product And Offer Studio | Product catalog, offers, prices, agreements, promotions, and launch readiness |
| Marketing, Campaign, And Customer Journey | Segmentation, campaign planning, eligibility, journeys, and engagement intent |
| Sales, CPQ, And Cart | Qualification, quote, cart, negotiation, configuration, and sales handoff |
| Order Management Hub | Product order lifecycle, decomposition intent, amendments, cancellations, jeopardy, and fallout |
| Billing, Payments, And Account Operations | Billing account operations, bills, balances, payments, adjustments, and disputes |
| Credit, Fraud, And Collections | Credit profile, fraud case, risk signals, collections, and treatment workflows |
| Usage, Charging, And Revenue Settlement | Usage ingestion, CDR governance, charging handoff, revenue assurance, and settlement |

## Recommended Build Order

1. Customer And Party 360.
2. Product And Offer Studio.
3. Sales, CPQ, And Cart.
4. Order Management Hub.
5. Billing, Payments, And Account Operations.
6. Usage, Charging, And Revenue Settlement.
7. Credit, Fraud, And Collections.
8. Marketing, Campaign, And Customer Journey.

This order establishes customer and catalog foundations before sales, order, revenue, risk, and campaign optimization flows.

## Suite Technology Posture

Use Angular, Spring Boot, and PostgreSQL as the default implementation stack. PostgreSQL should own customer, catalog, quote, cart, order, bill, payment, usage-summary, risk, and settlement operational state according to each app's data ownership boundary.

BSS apps will integrate with external payment gateways, tax engines, charging platforms, credit bureaus, fraud providers, document stores, and ERP boundaries. Treat those as integration targets, not reasons to bypass app-owned APIs or private databases. If a new open source technology is needed for search, eventing, document storage, or analytics, present options with pros and cons and ask for a decision.

## Suite UI Posture

The suite should feel like a polished commercial operations cockpit: dense customer/account context, clear commercial actions, fast search, strong lifecycle state, and controlled access to sensitive data.

Use compact operational workbenches for care, sales, order, billing, and risk teams. Use dashboard layouts for revenue, campaign, fraud, collections, and order health summaries. Mask sensitive data by role in both light and dark modes.

## Shared Suite Components

| Shared pattern | Use across apps |
| --- | --- |
| Customer/account context header | Customer, account, billing account, party role, segment, risk, and consent indicators |
| Commercial lifecycle badge | Lead, quote, cart, order, bill, payment, dispute, risk, and settlement state |
| Product/offer summary | Offer, price, commitment, eligibility, promotion, agreement, and channel context |
| Interaction timeline | Customer contacts, documents, order events, billing events, disputes, and cases |
| Commercial work queue | Sales tasks, order fallout, billing exceptions, fraud cases, collections actions |
| Financial summary panel | Balance, bill status, payment status, adjustment, dispute, credit, and settlement summaries |
| Policy and consent banner | Consent, privacy, KYC, delegated authority, vulnerability, and purpose-limitation indicators |

## Standard Page Templates

Use TelcoSuite page templates consistently:

- List and workbench for customers, offers, quotes, carts, orders, bills, cases, disputes, usage batches, and settlements.
- Record detail for customer, account, offer, quote, order, bill, payment, risk case, and settlement records.
- Wizard or guided flow for onboarding, quote creation, order submission, billing adjustment, dispute handling, and collections treatment.
- Dashboard for sales pipeline, order health, billing operations, revenue assurance, fraud risk, and campaign performance.
- Configuration pages for catalog rules, pricing, eligibility, campaigns, risk policy, collection treatments, and settlement rules.

## Data, API, And Integration Guidance

- Keep customer, catalog, sales, order, billing, usage, risk, and settlement data ownership clear and app-local.
- Use TMF APIs first for external and cross-suite exposure; document extension APIs when TMF resources do not fit.
- Publish lifecycle events for customer, consent, offer, quote, cart, order, bill, payment, usage, risk, dispute, and settlement changes.
- Use governed projections for customer/account context in other apps rather than direct database access.
- Apply tenant, market, brand, language, currency, privacy, masking, retention, and data-residency controls consistently.

## Candidate Extra Technology Decision Areas

These categories may require a decision when implementation starts:

| Need | Why it may arise | Decision rule |
| --- | --- | --- |
| Enterprise search | Customer, account, order, bill, offer, and case lookup at scale | Try PostgreSQL search first; ask before adding a search engine. |
| Event streaming | High-volume order, usage, billing, payment, and risk events | Ask before adding a broker or streaming platform. |
| Document or evidence storage | KYC, contracts, invoices, disputes, and compliance evidence | Evaluate open source storage options before adoption. |
| Decisioning or rules | Eligibility, pricing, fraud, credit, collections, and campaigns | Prefer Spring/PostgreSQL rules first; ask before adding a decision engine. |
| Analytics and revenue assurance | Usage, settlement, leakage, campaign, and collections analytics | Decide whether governed read models are enough before adding analytics engines. |

## App Readiness Checklist

- Uses shared customer/account, lifecycle, timeline, work queue, and financial summary patterns.
- Supports role-aware masking, privacy, consent, KYC, retention, and audit controls.
- Defines app-owned write models and consumed customer/catalog/order/billing projections.
- Provides compact operational workbenches for high-volume users.
- Provides dashboard views only where KPI, trend, or exception monitoring is needed.
- Supports responsive sales, approval, care, and lightweight billing/risk tasks.
- Documents any non-primary technology need with open source options, pros and cons, and a decision request.
