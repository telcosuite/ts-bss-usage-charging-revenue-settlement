# BSS Commercial Implementation File Usage Guide

Reviewed: 2026-06-14

## Purpose

This guide explains how to use the planning, TMF, UI, data, and DDL files for the BSS Commercial suite while building its apps.

Suite focus: commercial customer, offer, sales, order, billing, credit, usage, charging, and settlement work.

## Suite-Level Files

| File | Use it for |
| --- | --- |
| [README.md](README.md) | Suite navigation and app list. |
| [tech-and-ui-guidance.md](tech-and-ui-guidance.md) | Suite-specific Angular, PrimeNG, layout, navigation, density, and UI consistency guidance. |
| [data-model.md](data-model.md) | Suite database ownership, app schemas, data mastery, cross-app sharing, and physical model guidance. |
| [journey-coverage.md](journey-coverage.md) | Cross-app suite journeys and end-to-end flow validation. |
| [../build-artifact-usage-guide.md](../build-artifact-usage-guide.md) | Global explanation of how all generated files fit together. |
| [../suite-app-coverage-control-matrix.md](../suite-app-coverage-control-matrix.md) | Build-readiness status across all suites and apps. |
| [../tmf-api-to-ddl-traceability-matrix.md](../tmf-api-to-ddl-traceability-matrix.md) | API-level TMF-to-schema/table coverage. |
| [../../../database/postgres/README.md](../../../database/postgres/README.md) | Database execution model and migration usage. |

## Database And Migration Use

Physical database: `ts_bss_commercial`

Run migrations in order inside this suite database. `V001` creates app schemas and starter tables. Each V002+ migration refines one app with promoted TMF fields, support tables, event contracts, and privacy/retention/audit policies.

| Migration | Path |
| --- | --- |
| `V001__create_app_schemas_and_starter_tables.sql` | `database/postgres/suites/ts_bss_commercial/V001__create_app_schemas_and_starter_tables.sql` |
| `V002__refine_customer_party_360_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V002__refine_customer_party_360_tmf_core.sql` |
| `V003__refine_product_offer_studio_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V003__refine_product_offer_studio_tmf_core.sql` |
| `V004__refine_order_management_hub_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V004__refine_order_management_hub_tmf_core.sql` |
| `V005__refine_billing_payments_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V005__refine_billing_payments_tmf_core.sql` |
| `V006__refine_usage_revenue_settlement_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `V007__refine_marketing_journey_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V007__refine_marketing_journey_tmf_core.sql` |
| `V008__refine_sales_cpq_cart_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V008__refine_sales_cpq_cart_tmf_core.sql` |
| `V009__refine_credit_fraud_collections_tmf_core.sql` | `database/postgres/suites/ts_bss_commercial/V009__refine_credit_fraud_collections_tmf_core.sql` |

## App File Map

| App | Schema | App usage guide | TMF review | App migration | Primary TMF/API areas |
| --- | --- | --- | --- | --- | --- |
| Billing, Payments, And Account Operations | `billing_payments` | [billing-payments-account-operations/implementation-file-usage.md](billing-payments-account-operations/implementation-file-usage.md) | [billing-payments.md](../tmf-api-ddl-reviews/billing-payments.md) | `V005__refine_billing_payments_tmf_core.sql` | TMF666, TMF678, TMF676, TMF670, TMF654 |
| Credit, Fraud, And Collections | `credit_fraud_collections` | [credit-fraud-collections/implementation-file-usage.md](credit-fraud-collections/implementation-file-usage.md) | [credit-fraud-collections.md](../tmf-api-ddl-reviews/credit-fraud-collections.md) | `V009__refine_credit_fraud_collections_tmf_core.sql` | TMF629, TMF666, TMF679, TMF696, TMF720, TMF622, TMF676, TMF677, TMF735, TMF621, TMF678, TMF681, TMF644, TMF637, TMF638, TMF640 |
| Customer And Party 360 | `customer_party_360` | [customer-and-party-360/implementation-file-usage.md](customer-and-party-360/implementation-file-usage.md) | [customer-party-360-foundation.md](../tmf-api-ddl-reviews/customer-party-360-foundation.md) | `V002__refine_customer_party_360_tmf_core.sql` | TMF632, TMF669, TMF629, TMF683, TMF666, TMF720, TMF691, TMF672, TMF644, TMF681, TMF667, TMF621, TMF658, TMF680 |
| Marketing, Campaign, And Customer Journey | `marketing_journey` | [marketing-campaign-customer-journey/implementation-file-usage.md](marketing-campaign-customer-journey/implementation-file-usage.md) | [marketing-journey.md](../tmf-api-ddl-reviews/marketing-journey.md) | `V007__refine_marketing_journey_tmf_core.sql` | TMF629, TMF632, TMF637, TMF677, TMF644, TMF620, TMF671, TMF679, TMF680, TMF681, TMF683, TMF663, TMF622, TMF621, TMF658, TMF678 |
| Order Management Hub | `order_management_hub` | [order-management-hub/implementation-file-usage.md](order-management-hub/implementation-file-usage.md) | [order-management-hub.md](../tmf-api-ddl-reviews/order-management-hub.md) | `V004__refine_order_management_hub_tmf_core.sql` | TMF622, TMF641, TMF652, TMF701, TMF621 |
| Product And Offer Studio | `product_offer_studio` | [product-and-offer-studio/implementation-file-usage.md](product-and-offer-studio/implementation-file-usage.md) | [product-offer-studio.md](../tmf-api-ddl-reviews/product-offer-studio.md) | `V003__refine_product_offer_studio_tmf_core.sql` | TMF620, TMF671, TMF760, TMF651, TMF633, TMF634 |
| Sales, CPQ, And Cart | `sales_cpq_cart` | [sales-cpq-cart/implementation-file-usage.md](sales-cpq-cart/implementation-file-usage.md) | [sales-cpq-cart.md](../tmf-api-ddl-reviews/sales-cpq-cart.md) | `V008__refine_sales_cpq_cart_tmf_core.sql` | TMF679, TMF645, TMF680, TMF648, TMF663, TMF699, TMF668, TMF651, TMF622, TMF678, TMF736, TMF737, TMF738 |
| Usage, Charging, And Revenue Settlement | `usage_revenue_settlement` | [usage-charging-revenue-settlement/implementation-file-usage.md](usage-charging-revenue-settlement/implementation-file-usage.md) | [usage-revenue-settlement.md](../tmf-api-ddl-reviews/usage-revenue-settlement.md) | `V006__refine_usage_revenue_settlement_tmf_core.sql` | TMF635, TMF735, TMF771, TMF677, TMF696, TMF678, TMF736, TMF737, TMF738, TMF620, TMF668, TMF651 |

## Suite Build Workflow

1. Start with this guide and the suite `data-model.md` to confirm database, schema, and ownership boundaries.
2. Use `tech-and-ui-guidance.md` before any Angular work so all apps share the TelcoSuite design language.
3. Build apps in the priority order from [../tmf-api-ddl-reviews/backlog.md](../tmf-api-ddl-reviews/backlog.md), unless delivery priorities explicitly change.
4. For each app, open its `implementation-file-usage.md` and follow its checklist.
5. Apply `V001`, then the app's V002+ migration, before implementing repositories/entities that depend on promoted columns or support tables.
6. Emit events through the app `event_outbox` and use the app `event_contract` table as the baseline register.
7. Enforce table handling with the app `privacy_retention_policy` table and add jurisdiction-specific rules before release.
8. Keep cross-app interactions out of database writes; use APIs, events, governed views, workflow tasks, or data products.

## Suite Delivery Gate

The suite is implementation-ready when each app keeps these artifacts aligned: app overview, modules/features, personas/journeys, TMF review, V002+ DDL, endpoint contract tests, event behavior, and privacy/audit controls.
