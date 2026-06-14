# Product And Offer Studio App

## Purpose

Create and govern sellable telecom offers, bundles, prices, promotions, product configurations, agreements, and catalog launch readiness.

## Primary Personas

- Product manager: defines offers, bundles, eligibility, lifecycle, and launch plans.
- Pricing manager: owns recurring, usage, one-time, penalty, device, discount, and promotional price structures.
- Commercial operations user: governs release windows, approvals, and channel publication.
- Catalog governance user: checks product-to-service/resource realization and launch readiness.

## Core Workflow

1. Define product specifications, offerings, bundles, and categories.
2. Define pricing, promotions, discounts, and approval rules.
3. Define configurable options, compatibility, defaults, and guided-selling constraints.
4. Attach agreements, contract terms, commitments, penalties, renewals, and entitlements.
5. Validate catalog readiness against service/resource design, fulfillment, billing, campaign, and channels.
6. Publish versioned offers to CPQ, digital commerce, partner marketplace, billing, and fulfillment.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Product Catalog | Manage product specs, offerings, bundles, categories, lifecycle, versioning, characteristics, relationships, constraints, effective dates, retirement, and commercial metadata. | [TMF620](../../../references/tmforum-open-apis/openapi-specs/TMF620_ProductCatalog) |
| Pricing, Promotion, And Discount | Manage recurring, one-time, usage, deposit, penalty, device, installation, and discount prices. Define promotions, eligibility, validity, approval rules, and price override controls. | [TMF671](../../../references/tmforum-open-apis/openapi-specs/TMF671_Promotion), [TMF620](../../../references/tmforum-open-apis/openapi-specs/TMF620_ProductCatalog) |
| Product Configuration | Define configurable options, default configurations, compatibility rules, product constraints, guided selling, quote/cart/order validation, and service/resource design links. | [TMF760](../../../references/tmforum-open-apis/openapi-specs/TMF760_ProductConfigurationManagement) |
| Agreement And Contract | Manage agreements, master service agreements, contract terms, commitments, penalties, renewals, entitlements, enterprise child agreements, and links to quotes/orders/bills. | [TMF651](../../../references/tmforum-open-apis/openapi-specs/TMF651_AgreementManagement) |
| Catalog Governance | Manage catalog workflows, approvals, testing, release windows, publication channels, dependency validation, service/resource spec mapping, and retirement readiness. | [TMF620](../../../references/tmforum-open-apis/openapi-specs/TMF620_ProductCatalog), [TMF633](../../../references/tmforum-open-apis/openapi-specs/TMF633_ServiceCatalog), [TMF634](../../../references/tmforum-open-apis/openapi-specs/TMF634_ResourceCatalog) |

## Data Ownership

Owns commercial product models, product offerings, bundles, price definitions, promotion definitions, product configuration models, agreement templates, catalog release state, and catalog governance evidence.

## First Release Scope

Deliver product/offering catalog, price and promotion model, configuration constraints, catalog approval, and publication APIs. Add richer commercial simulation, offer experiments, and automated catalog test certification later.

