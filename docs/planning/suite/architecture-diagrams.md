# BSS Commercial Architecture Diagrams

Reviewed: 2026-06-14

## Purpose

Use these diagrams when building the BSS Commercial suite and its apps. They turn the suite/app detail documents into architecture views for customer, offer, sales, order, billing, risk, usage, charging, and settlement implementation.

Primary sources:

- [Implementation File Usage Guide](implementation-file-usage-guide.md)
- [Tech And UI Guidance](tech-and-ui-guidance.md)
- [Data Model](data-model.md)
- [Journey Coverage](journey-coverage.md)
- App `implementation-file-usage.md`, `README.md`, `modules-and-features.md`, `personas-and-user-journeys.md`, and `features/` detail packs
- [TMF API To DDL Traceability Matrix](../tmf-api-to-ddl-traceability-matrix.md)
- `database/postgres/suites/ts_bss_commercial/`

## Suite Architecture

```mermaid
flowchart LR
  subgraph Channels["Commercial Channels"]
    Care["Care and contact center"]
    Sales["Retail, dealer, enterprise sales, and partner sales"]
    Digital["Self-care, web, mobile, marketplace, and APIs"]
    BackOffice["Billing, finance, fraud, collections, and settlement operations"]
  end

  subgraph Suite["BSS Commercial Suite"]
    C360["Customer And Party 360"]
    Offer["Product And Offer Studio"]
    Marketing["Marketing, Campaign, And Customer Journey"]
    CPQ["Sales, CPQ, And Cart"]
    Order["Order Management Hub"]
    Billing["Billing, Payments, And Account Operations"]
    Risk["Credit, Fraud, And Collections"]
    Usage["Usage, Charging, And Revenue Settlement"]
  end

  subgraph APIs["Suite API And Event Contracts"]
    TMF["TMF APIs: customer, party, account, privacy, catalog, quote, cart, order, bill, payment, usage, CDR, settlement, trouble ticket"]
    Extensions["Extension APIs for commercial workbenches, risk decisions, revenue assurance, rerating, and partner settlement operations"]
    Events["Customer, consent, offer, quote, cart, order, bill, payment, usage, fraud, collections, dispute, and settlement events"]
  end

  subgraph Data["ts_bss_commercial"]
    C360DB["customer_party_360 schema"]
    OfferDB["product_offer_studio schema"]
    MarketingDB["marketing_journey schema"]
    CPQDB["sales_cpq_cart schema"]
    OrderDB["order_management_hub schema"]
    BillingDB["billing_payments schema"]
    RiskDB["credit_fraud_collections schema"]
    UsageDB["usage_revenue_settlement schema"]
  end

  subgraph External["Cross-Suite And External Boundaries"]
    Strategy["Strategy serviceability, geography, capacity, and launch context"]
    OSS["OSS inventory, fulfillment, activation, field, and assurance"]
    DigitalSuite["Digital self-care, partner, and marketplace"]
    Platform["Identity, policy, workflow, API platform, data products, test"]
    Finance["ERP, tax, payment gateway, credit bureau, fraud provider, clearinghouse"]
  end

  Channels --> C360
  Channels --> CPQ
  Channels --> Billing
  Channels --> Risk
  C360 --> CPQ
  Offer --> CPQ
  Marketing --> CPQ
  CPQ --> Order
  Order --> Billing
  Order --> OSS
  OSS --> Billing
  Usage --> Billing
  Billing --> Risk
  Usage --> Risk
  Risk --> Order
  DigitalSuite --> C360
  DigitalSuite --> CPQ
  DigitalSuite --> Order
  Strategy --> CPQ

  Suite --> TMF
  Suite --> Extensions
  Suite --> Events

  C360 --> C360DB
  Offer --> OfferDB
  Marketing --> MarketingDB
  CPQ --> CPQDB
  Order --> OrderDB
  Billing --> BillingDB
  Risk --> RiskDB
  Usage --> UsageDB

  Events --> Platform
  Usage --> Finance
  Billing --> Finance
  Risk --> Finance
```

## Suite Build Flow

```mermaid
sequenceDiagram
  autonumber
  participant Channel as Channel or API consumer
  participant C360 as Customer And Party 360
  participant Offer as Product And Offer Studio
  participant CPQ as Sales, CPQ, And Cart
  participant Order as Order Management Hub
  participant OSS as OSS Fulfillment And Inventory
  participant Billing as Billing And Payments
  participant Usage as Usage And Settlement
  participant Risk as Credit, Fraud, Collections
  participant Platform as Events, workflow, data, audit

  Channel->>C360: Create or select party, customer, account, consent
  Channel->>Offer: Browse eligible product offers and prices
  Channel->>CPQ: Qualify, recommend, quote, and cart
  CPQ->>Order: Submit product order with snapshots
  Order->>OSS: Handoff service/resource orders and fulfillment dependencies
  OSS-->>Order: Return fulfillment, inventory, appointment, activation state
  Order->>Billing: Handoff billing actions and order-to-bill evidence
  Usage->>Billing: Send rated usage, consumption, and settlement evidence
  Billing->>Risk: Send overdue, dispute, payment, and restriction context
  Risk-->>Order: Return credit, fraud, restriction, or recovery decision
  Order-->>Channel: Publish customer-visible order status
  C360-->>Platform: Publish customer, consent, interaction, document events
  Order-->>Platform: Publish order, fallout, and decomposition events
  Billing-->>Platform: Publish bill, payment, balance, and adjustment events
```

## App Architecture: Customer And Party 360

```mermaid
flowchart LR
  Inputs["Party, customer, account, consent, identity, interaction, document, care, loyalty, KYC, and privacy requests"]
  UI["Customer/account workbench, hierarchy view, consent/privacy panels, interaction timeline, care case queue, document evidence views"]
  API["TMF632/TMF669/TMF629/TMF666/TMF644/TMF681/TMF683/TMF667/TMF621/TMF658 APIs plus delegated admin and evidence queries"]
  Domain["Party master, customer profile, account hierarchy, identity/access/consent, interaction/communication/document, care case, loyalty"]
  Data["customer_party_360 schema: party, customer, account hierarchy, consent, interaction, communication, document metadata, care case, loyalty, event_outbox"]
  Consumers["Sales, order, billing, care, assurance, self-care, partner, marketing, analytics"]
  Tests["Contract, consent/masking, hierarchy, delegated authority, interaction audit, complaint escalation, accessibility tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Product And Offer Studio

```mermaid
flowchart LR
  Inputs["Product strategy, service/resource specs, pricing, promotions, tax, agreement terms, launch readiness, catalog governance"]
  UI["Catalog workbench, offer editor, pricing/promotion grid, configuration modeler, agreement/version timeline, launch readiness board"]
  API["TMF620/TMF671/TMF760/TMF651/TMF633/TMF634 APIs plus launch, sunset, tax, and governance extension commands"]
  Domain["Product catalog, pricing/promotion/discount, product configuration, agreement and contract, catalog governance, offer launch, sunset and migration"]
  Data["product_offer_studio schema: product specs, offerings, prices, promotions, configuration models, agreement templates, catalog versions, event_outbox"]
  Consumers["CPQ, order, marketing, partner marketplace, self-care, service/resource design, billing, settlement"]
  Tests["Catalog contract, effective date, pricing eligibility, versioning, launch readiness, sunset/grandfathering, contract snapshot tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Marketing, Campaign, And Customer Journey

```mermaid
flowchart LR
  Inputs["Customer, consent, product, usage, billing, order, care, loyalty, churn, and channel signals"]
  UI["Segment/audience builder, campaign planner, journey canvas, retention treatment queue, contact-policy decision evidence"]
  API["TMF629/TMF632/TMF637/TMF677/TMF644/TMF620/TMF671/TMF679/TMF680/TMF681/TMF683/TMF663/TMF622/TMF621 APIs"]
  Domain["Segment and audience, campaign planning and targeting, journey orchestration, retention and loyalty treatment, contact policy and consent enforcement"]
  Data["marketing_journey schema: segments, audience snapshots, campaigns, journey states, treatment decisions, contact policy decisions, performance snapshots, event_outbox"]
  Consumers["Sales, self-care, care, notification, analytics, product, loyalty, billing"]
  Tests["Consent enforcement, suppression, eligibility, journey state, contact frequency, treatment outcome, campaign performance tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Sales, CPQ, And Cart

```mermaid
flowchart LR
  Inputs["Customer/account, product offer, price, promotion, serviceability, inventory, risk, appointment, partner, dealer, and channel context"]
  UI["Opportunity board, qualification result, guided selling, quote editor, cart, pre-order checks, e-signature, dealer/commission views"]
  API["TMF679/TMF645/TMF680/TMF648/TMF663/TMF699/TMF668/TMF651/TMF622/TMF678/TMF736/TMF737/TMF738 APIs"]
  Domain["Product offering qualification, recommendation and guided selling, quote management, shopping cart, sales opportunity, channel/dealer/commission support"]
  Data["sales_cpq_cart schema: opportunities, attribution, qualifications, recommendation usage, quotes, quote item snapshots, carts, cart item snapshots, event_outbox"]
  Consumers["Order Management Hub, billing, partner marketplace, marketing, revenue settlement, analytics"]
  Tests["Qualification, quote pricing, cart checkout, stale snapshot, risk/serviceability failure, commission trigger, API contract, E2E journey tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Order Management Hub

```mermaid
flowchart LR
  Inputs["Quote, cart, partner, self-care, care, API channel, customer, catalog, appointment, risk, serviceability, and billing context"]
  UI["Order intake, decomposition graph, milestone timeline, jeopardy dashboard, fallout queue, amendment/cancellation/rollback workbench"]
  API["TMF622/TMF641/TMF652/TMF701/TMF621 APIs plus decomposition, dependency, compensation, promise-date, and bulk-project commands"]
  Domain["Product order capture, order decomposition, orchestration and jeopardy, fallout and exception, amendment/cancellation/rollback, reconciliation"]
  Data["order_management_hub schema: product orders, order items, decomposition plans, jeopardy, fallout, reference snapshots, event_outbox"]
  Consumers["OSS fulfillment, inventory, field, billing, care, self-care, partner, assurance, data products"]
  Tests["Product order contract, decomposition, idempotency, jeopardy, fallout, cancellation, compensation, order-to-bill handoff tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Billing, Payments, And Account Operations

```mermaid
flowchart LR
  Inputs["Customer/account, product/order, usage, payment gateway, tax, finance, dispute, collections, and hardship context"]
  UI["Billing account workbench, bill presentment, payment capture, prepay balance, adjustment/collections queue, invoice and subledger views"]
  API["TMF666/TMF678/TMF676/TMF670/TMF654 APIs plus bill-cycle, invoice, adjustment, refund, chargeback, deposit, and hardship commands"]
  Domain["Billing account, customer bill, payment and payment method, prepay balance, bill cycle/invoice, collections and adjustment"]
  Data["billing_payments schema: billing accounts, bill cycles, bills, bill items, payments, payment allocations, payment method references, prepay balances, adjustments, event_outbox"]
  Consumers["Customer care, self-care, collections, finance/ERP, usage settlement, revenue assurance, reporting"]
  Tests["Financial audit, payment token, bill cycle, rebill, allocation, adjustment approval, refund/chargeback, retention, masking tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Credit, Fraud, And Collections

```mermaid
flowchart LR
  Inputs["Customer, account, quote, order, bill, payment, usage, identity, bureau, fraud provider, collections, dispute, and legal evidence"]
  UI["Risk decision workbench, fraud case board, collections treatment queue, dispute/recovery case, restriction/reconnection controls, evidence vault"]
  API["TMF629/TMF666/TMF679/TMF696/TMF720/TMF622/TMF676/TMF677/TMF735/TMF621/TMF678/TMF681/TMF644/TMF637/TMF638/TMF640 APIs"]
  Domain["Credit risk and eligibility, fraud detection/case management, collections strategy, deposit/credit/hardship, restriction/reconnection, dispute/recovery"]
  Data["credit_fraud_collections schema: credit decisions, risk exposure, fraud cases, collections cases, restriction decisions, disputes, case evidence, event_outbox"]
  Consumers["Sales, order, billing, fulfillment activation, care, security operations, finance, regulatory reporting"]
  Tests["Decision model version, appeal/correction, sensitive evidence access, fraud escalation, collections policy, restriction handoff, legal hold tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Usage, Charging, And Revenue Settlement

```mermaid
flowchart LR
  Inputs["Network usage, CDRs, product usage, resource usage, partner traffic, rating, charging, tax, billing, order, inventory, payment, and settlement evidence"]
  UI["Usage ingestion monitor, mediation exception queue, consumption summary, revenue assurance workbench, partner settlement, rerating/tax evidence"]
  API["TMF635/TMF735/TMF771/TMF677/TMF696/TMF678/TMF736/TMF737/TMF738/TMF620/TMF668/TMF651 APIs"]
  Domain["Usage ingestion and mediation, usage consumption, revenue assurance, partner revenue sharing, rating/charging/tax integration, roaming/interconnect/wholesale settlement"]
  Data["usage_revenue_settlement schema: ingestion batches, mediation exceptions, CDR transactions, consumption summaries, assurance cases, sharing models/reports, settlement exceptions, event_outbox"]
  Consumers["Billing, fraud, partner marketplace, finance, data products, assurance, self-care"]
  Tests["High-volume ingestion, partitioning, idempotency, replay, mediation, rerating, settlement, tax evidence, financial reconciliation tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## Build Use

Use the suite diagram to decide commercial lifecycle ownership. Use each app diagram to create app-specific Angular routes, Spring Boot APIs, PostgreSQL entities, event contracts, privacy/audit policies, and release tests without crossing app schema write boundaries.
