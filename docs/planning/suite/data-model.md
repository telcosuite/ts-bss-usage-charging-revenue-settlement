# BSS Commercial Data Model

This document defines the suite-level data model for BSS Commercial. It translates the product-suite data mastery decisions into one PostgreSQL suite database with app-owned schemas and TMF-aligned entity ownership.

## Suite Database Layout

Physical database: `ts_bss_commercial`

| App | Owning schema | Primary data role |
| --- | --- | --- |
| Customer And Party 360 | `customer_party_360` | Party, customer, account, consent, interaction, document, care context |
| Product And Offer Studio | `product_offer_studio` | Product catalog, offers, prices, promotions, agreement templates |
| Marketing, Campaign, And Customer Journey | `marketing_journey` | Segments, campaigns, treatments, journeys, contact policy decisions |
| Sales, CPQ, And Cart | `sales_cpq_cart` | Opportunity, qualification, quote, cart, sales transaction snapshots |
| Order Management Hub | `order_management_hub` | Product order, decomposition plan, commercial fallout |
| Billing, Payments, And Account Operations | `billing_payments` | Billing account operations, bills, payments, balances, adjustments |
| Credit, Fraud, And Collections | `credit_fraud_collections` | Credit decisions, fraud cases, collections, disputes, recovery cases |
| Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | Usage batches, CDRs, consumption summaries, revenue assurance, settlement |

## Data Modeling Rules

- Customer, party, account, consent, and interaction records are mastered in Customer And Party 360.
- Product catalog and offer definitions are mastered in Product And Offer Studio; sales and digital apps consume projections.
- Quotes, carts, and orders may snapshot customer, offer, price, serviceability, and risk context at transaction time.
- Billing, usage, payment, fraud, collections, and settlement records must preserve financial audit and retention evidence.
- Sensitive data must include masking, consent, purpose, tenant, brand, market, retention, and data-residency classification.

## Entity Mastery Matrix

| Entity family | Master app | Owning schema | TMF API anchors | Main consumers | Data role |
| --- | --- | --- | --- | --- | --- |
| Party | Customer And Party 360 | `customer_party_360` | TMF632 | Partner, sales, billing, care, assurance | Master |
| Party role | Customer And Party 360 | `customer_party_360` | TMF669 | Partner, account, delegated admin | Master |
| Customer | Customer And Party 360 | `customer_party_360` | TMF629 | Sales, order, billing, care, self-care, assurance | Master |
| Customer account hierarchy | Customer And Party 360 | `customer_party_360` | TMF666 | Billing, sales, enterprise admin | Master |
| Customer identity link | Customer And Party 360 | `customer_party_360` | TMF720, TMF691 | Platform IAM, self-care | Master relationship |
| Consent and privacy preference | Customer And Party 360 | `customer_party_360` | TMF644 | Marketing, notification, partner, self-care | Master |
| Interaction | Customer And Party 360 | `customer_party_360` | TMF683 | Care, billing, sales, compliance | Master interaction history |
| Communication record and customer correspondence | Customer And Party 360 | `customer_party_360` | TMF681 | Care, billing, sales, compliance | Master correspondence evidence |
| Customer document metadata | Customer And Party 360 | `customer_party_360` | TMF667 | Care, compliance, sales, partner | Master metadata |
| Care case and complaint | Customer And Party 360 | `customer_party_360` | TMF621, TMF683 | Assurance, billing, self-care | Master customer case |
| Loyalty membership | Customer And Party 360 | `customer_party_360` | TMF658 | Marketing, billing, sales, self-care | Master customer loyalty context |
| Product specification | Product And Offer Studio | `product_offer_studio` | TMF620 | CPQ, order, service design, partner | Master |
| Product offering and bundle | Product And Offer Studio | `product_offer_studio` | TMF620 | Sales, digital, partner, marketing | Master |
| Product price | Product And Offer Studio | `product_offer_studio` | TMF620 | CPQ, billing, charging boundary | Master |
| Promotion | Product And Offer Studio | `product_offer_studio` | TMF671 | Marketing, CPQ, digital | Master |
| Product configuration model | Product And Offer Studio | `product_offer_studio` | TMF760 | CPQ, order validation | Master |
| Agreement template and terms | Product And Offer Studio | `product_offer_studio` | TMF651 | Sales, billing, partner | Master template |
| Segment and audience snapshot | Marketing, Campaign, And Customer Journey | `marketing_journey` | TMF629, TMF637, TMF677, TMF644 | Campaigns, journeys, sales | Derived master |
| Campaign | Marketing, Campaign, And Customer Journey | `marketing_journey` | TMF671, TMF680, TMF681 | Sales, digital, analytics | Master |
| Journey definition and state | Marketing, Campaign, And Customer Journey | `marketing_journey` | TMF680, TMF683, TMF663, TMF622, TMF621 | Sales, care, digital | Master orchestration state |
| Treatment and contact-policy decision | Marketing, Campaign, And Customer Journey | `marketing_journey` | TMF644, TMF680, TMF681 | Sales, care, digital, notification | Master campaign decision |
| Opportunity | Sales, CPQ, And Cart | `sales_cpq_cart` | TMF699 | Marketing, partner, reporting | Master |
| Channel/dealer attribution and commission trigger context | Sales, CPQ, And Cart | `sales_cpq_cart` | TMF699, TMF668, TMF651, TMF736, TMF737, TMF738 | Partner, settlement, finance boundary | Master sales attribution context |
| Product offering qualification | Sales, CPQ, And Cart | `sales_cpq_cart` | TMF679, TMF645 | CPQ, order, digital | Transaction snapshot |
| Recommendation in sales context | Sales, CPQ, And Cart | `sales_cpq_cart` | TMF680 | Marketing, data, digital | Master recommendation usage in transaction |
| Quote | Sales, CPQ, And Cart | `sales_cpq_cart` | TMF648 | Order, billing, customer, partner | Master transaction |
| Shopping cart | Sales, CPQ, And Cart | `sales_cpq_cart` | TMF663 | Digital, partner, order | Master transaction |
| Product order | Order Management Hub | `order_management_hub` | TMF622 | Fulfillment, billing, care, assurance | Master |
| Product order decomposition plan | Order Management Hub | `order_management_hub` | TMF622, TMF641, TMF652, TMF701 | OSS fulfillment | Master commercial plan |
| Product order jeopardy and fallout | Order Management Hub | `order_management_hub` | TMF622, TMF621 | Care, fulfillment, reporting | Master commercial exception |
| Billing account operational state | Billing, Payments, And Account Operations | `billing_payments` | TMF666, TMF678 | Customer, care, collections | Master billing context |
| Customer bill | Billing, Payments, And Account Operations | `billing_payments` | TMF678 | Care, self-care, collections, settlement | Master |
| Payment and payment method reference | Billing, Payments, And Account Operations | `billing_payments` | TMF676, TMF670 | Billing, collections, self-care | Master lifecycle/reference |
| Prepay balance | Billing, Payments, And Account Operations | `billing_payments` | TMF654 | Charging, self-care, care | Master customer-facing view |
| Billing adjustment | Billing, Payments, And Account Operations | `billing_payments` | TMF678, TMF676 | Care, collections, finance boundary | Master adjustment |
| Credit decision and exposure | Credit, Fraud, And Collections | `credit_fraud_collections` | TMF696, TMF629, TMF666, TMF679 | Sales, order, billing | Master decision |
| Fraud case | Credit, Fraud, And Collections | `credit_fraud_collections` | TMF696, TMF720, TMF622, TMF676, TMF677, TMF735 | Billing, security, order | Master case |
| Collections and recovery case | Credit, Fraud, And Collections | `credit_fraud_collections` | TMF678, TMF676, TMF681, TMF644 | Billing, care, restriction execution | Master case |
| Restriction/reconnection decision | Credit, Fraud, And Collections | `credit_fraud_collections` | TMF637, TMF638, TMF640 | Billing, order, fulfillment, activation | Master commercial decision |
| Dispute and recovery case | Credit, Fraud, And Collections | `credit_fraud_collections` | TMF678, TMF676, TMF621 | Billing, care, settlement | Master case |
| Usage ingestion batch and mediation exception | Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | TMF635, TMF735, TMF771 | Billing, fraud, settlement, assurance | Master usage operation and exception |
| CDR transaction | Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | TMF735 | Billing, fraud, settlement, revenue assurance | Master transaction |
| Consumption summary | Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | TMF677 | Self-care, billing, care, analytics | Master aggregate |
| Revenue assurance case | Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | TMF696, TMF735, TMF678 | Billing, order, inventory | Master case |
| Revenue sharing model/report | Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | TMF736, TMF737, TMF738 | Partner, finance boundary | Master settlement |
| Roaming, interconnect, wholesale settlement exception | Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | TMF635, TMF735, TMF668, TMF651 | Partner, finance boundary, external clearinghouse | Master settlement exception |

## Schema-Ready App Physical Design

Candidate table names are starter names for app migrations. Each app must validate exact TMF API version, resource, operation, and field paths against `references/tmforum-open-apis/openapi-specs/` before creating DDL.

| Owning schema | Starter table groups and candidate tables | Key and relationship rules | Controls and storage notes |
| --- | --- | --- | --- |
| `customer_party_360` | Customer master: `party`, `party_role`, `customer`, `customer_account_hierarchy`, `customer_identity_link`, `consent`, `privacy_preference`, `interaction`, `communication_record`, `customer_document_metadata`, `care_case`, `loyalty_membership`, `external_reference`, `event_outbox` | Party/customer/account records use canonical UUIDs and alternate identifiers for external CRM/IAM/billing IDs. Communication records are customer correspondence evidence; notification delivery attempts remain platform-owned. | PII/CPNI by default. Store masking, consent purpose, market, tenant, brand, residency, retention, legal hold, and immutable interaction/correspondence history. |
| `product_offer_studio` | Commercial catalog: `product_specification`, `product_offering`, `product_bundle`, `product_price`, `promotion`, `product_configuration_model`, `agreement_template`, `commercial_term_version`, `catalog_version`, `event_outbox` | Catalog entities are versioned and effective-dated. Quote/order snapshots reference exact offer, price, promotion, configuration, and term versions. | Use typed columns for sellable lifecycle/status. Store TMF characteristics in controlled JSONB extension columns. |
| `marketing_journey` | Engagement: `segment`, `audience_snapshot`, `campaign`, `journey_definition`, `journey_state`, `treatment_decision`, `contact_policy_decision`, `campaign_performance_snapshot`, `event_outbox` | Segments and audiences store source customer/usage/product references and consent snapshot versions. Journey state references domain records but does not master them. | Store consent, purpose, suppression, eligibility, and contact frequency evidence. Audience snapshots need retention and refresh timestamp. |
| `sales_cpq_cart` | Sales transactions: `sales_opportunity`, `channel_attribution`, `commission_trigger_context`, `offering_qualification`, `recommendation_usage`, `quote`, `quote_item_snapshot`, `shopping_cart`, `cart_item_snapshot`, `event_outbox` | Quotes/carts use transaction UUIDs and snapshot customer, offer, price, serviceability, risk, and channel context. Commission triggers reference channel/dealer/partner IDs without owning accounting. | Keep transaction snapshots immutable after checkout/acceptance. Mask customer and payment context in lower environments. |
| `order_management_hub` | Product order: `product_order`, `product_order_item`, `order_decomposition_plan`, `order_jeopardy`, `order_fallout`, `order_reference_snapshot`, `event_outbox` | Product order is commercial master. Service/resource order IDs are cross-app references to OSS fulfillment execution. | Retain order history, decomposition versions, correlation IDs, fallout evidence, and customer-visible status history. |
| `billing_payments` | Revenue operations: `billing_account_operation`, `bill_cycle`, `customer_bill`, `bill_item`, `payment`, `payment_allocation`, `payment_method_reference`, `prepay_balance`, `billing_adjustment`, `event_outbox` | Bills/payments use financial-grade IDs and link to customer/account/order/usage snapshots. Payment method records store references/tokens, not raw sensitive payment data. | Financial retention, audit, reconciliation, masking, and legal hold required. Partition bills/payments by period where volume requires. |
| `credit_fraud_collections` | Risk and recovery: `credit_decision`, `risk_exposure`, `fraud_case`, `collections_case`, `restriction_reconnection_decision`, `dispute_recovery_case`, `case_evidence`, `event_outbox` | Decisions reference customer, account, order, bill, payment, usage, service, and activation IDs. Restriction/reconnection is a BSS decision; OSS executes the technical action. | Restricted data class. Store decision model version, evidence, actor, appeal/correction workflow, and privileged-access audit. |
| `usage_revenue_settlement` | Usage and settlement: `usage_ingestion_batch`, `mediation_exception`, `cdr_transaction`, `consumption_summary`, `revenue_assurance_case`, `revenue_sharing_model`, `revenue_sharing_report`, `roaming_interconnect_settlement_exception`, `event_outbox` | CDR and usage records reference product/customer/account/service/resource IDs by canonical ID and period. Settlement exceptions reference partner/agreement/usage batches. | High-volume usage/CDR tables must define period partitioning, replay/idempotency keys, retention, and financial reconciliation controls. |

## Consumed Cross-Suite Data

| Source suite/app | Consumed data | Storage rule |
| --- | --- | --- |
| Strategy, Investment, And Capacity | Serviceability, geography, capacity, planning scenarios | Store references, validity windows, and transaction snapshots |
| OSS Engineering, Inventory, And Fulfillment | Product/service/resource inventory, fulfillment state, appointments | Store projections and order handoff references |
| OSS Operations And Assurance | Tickets, incidents, SLA evidence, maintenance windows | Store customer-impact references and care/billing snapshots |
| Digital, Partner, And Ecosystem | Channel submissions, partner views, digital drafts | Store submitted transactions and references, not portal session masters |
| Enterprise Platform, Data, And Governance | Identity, policy, workflow, audit, data products | Store references and local evidence only |

## TMF Compliance Rules

- Use TMF632, TMF669, TMF629, TMF666, TMF644, TMF681, TMF683, TMF667, and TMF658 before adding local customer/party structures.
- Use TMF620, TMF671, TMF760, and TMF651 for product, offer, price, promotion, configuration, and terms.
- Use TMF679, TMF645, TMF648, TMF663, TMF699, TMF680, and TMF622 for sales, recommendations, and order transactions.
- Use TMF678, TMF676, TMF670, TMF654, TMF635, TMF677, TMF735, TMF736, TMF737, TMF738, TMF668, TMF651, and TMF771 for revenue operations, mediation, CDR, settlement, and wholesale exception handling.
- Extension fields must be classified as TMF characteristic, internal operational field, snapshot, projection, or reviewed non-TMF extension.

## Events And Projections

- Publish events for party changed, customer changed, consent changed, offer changed, quote changed, cart checked out, product order changed, bill issued, payment changed, usage batch processed, mediation exception changed, fraud case changed, collections case changed, restriction decision changed, dispute changed, and settlement changed.
- Each event must be registered with event name/version, event key, payload basis, outbox table, known consumers, replay retention, and masking controls before implementation.
- Consumers must correct source data through the owning BSS app and consume updated events or APIs.
- Financial and privacy projections must preserve lineage, masking policy, source ID, and retention class.

## App-Level Data Model Checklist

- Every table group names its master entity family and owning app.
- Candidate tables, primary keys, alternate identifiers, cross-app reference fields, and migration owner must be recorded before creating migrations.
- Each app must maintain TMF conformance, event contract, and privacy/retention/audit registers for every table group.
- Every API payload and persistent field is mapped to TMF first or explicitly classified as an extension.
- Transaction snapshots retain source IDs, source version, timestamp, and validity window.
- Sensitive data is masked and classified before UI/API exposure.
- Cross-app references do not become shadow masters.
