# Sales, CPQ, And Cart App

## Purpose

Support assisted and digital selling from qualification through recommendation, quote, cart, approval, and product order submission.

## Primary Personas

- Sales representative: builds quotes and closes opportunities.
- Retail agent: checks eligibility, configures offers, and submits carts.
- Dealer/channel manager: monitors dealer attribution, channel performance, and commission triggers.
- Contact center agent: handles upgrades, moves, disconnects, and retention actions.
- Digital commerce user: self-serves browse, configure, checkout, and change journeys.
- Sales manager: reviews approvals, discounts, pipeline, and conversion.

## Core Workflow

1. Qualify products using customer, location, serviceability, capacity, catalog, campaign, and policy context.
2. Recommend offers, upgrades, add-ons, retention treatments, or alternatives.
3. Configure quote and cart items with prices, discounts, appointments, contracts, and dependencies.
4. Route exceptions and discounts for approval.
5. Capture channel, dealer, partner, campaign, and commission attribution.
6. Convert accepted quote or cart into a product order.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Product Offering Qualification | Check sellability by customer, address, site, channel, date, serviceability, capacity, risk, product state, campaign, and regulation. Return qualified products, alternatives, and disqualification reasons. | [TMF679](../../../references/tmforum-open-apis/openapi-specs/TMF679_ProductOfferingQualification), [TMF645](../../../references/tmforum-open-apis/openapi-specs/TMF645_ServiceQualification) |
| Recommendation And Guided Selling | Recommend offers, bundles, upgrades, add-ons, retention actions, and next-best offers using customer, product, usage, campaign, serviceability, inventory, and pricing context. | [TMF680](../../../references/tmforum-open-apis/openapi-specs/TMF680_Recommendation) |
| Quote Management | Create, price, revise, approve, accept, reject, expire, and convert quotes. Support enterprise, multi-site, discount approvals, assumptions, dependencies, and quote terms. | [TMF648](../../../references/tmforum-open-apis/openapi-specs/TMF648_QuoteManagement) |
| Shopping Cart | Manage cart items, add/change/disconnect actions, configuration, pricing, eligibility, checkout readiness, appointments, dependencies, and conversion to product order. | [TMF663](../../../references/tmforum-open-apis/openapi-specs/TMF663_ShoppingCart) |
| Sales Opportunity | Track leads, opportunities, pipeline, activities, stages, forecast, channel, partner source, expected close date, and links to customers, quotes, agreements, and orders. | [TMF699](../../../references/tmforum-open-apis/openapi-specs/TMF699_Sales) |
| Channel, Dealer, And Commission Support | Track channel, dealer, agent, reseller, campaign, and partner attribution for quotes, carts, and orders. Support commission eligibility, clawback signals, channel performance, sales targets, dealer quality controls, and handoff to partner settlement or finance systems. | [TMF699](../../../references/tmforum-open-apis/openapi-specs/TMF699_Sales), [TMF668](../../../references/tmforum-open-apis/openapi-specs/TMF668_PartnershipType), [TMF651](../../../references/tmforum-open-apis/openapi-specs/TMF651_AgreementManagement), [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder), [TMF678](../../../references/tmforum-open-apis/openapi-specs/TMF678_CustomerBill), [TMF736](../../../references/tmforum-open-apis/openapi-specs/TMF736_RevenueSharingAlgorithmManagement), [TMF737](../../../references/tmforum-open-apis/openapi-specs/TMF737_RevenueSharingReportManagement), [TMF738](../../../references/tmforum-open-apis/openapi-specs/TMF738_RevenueSharingModelManagement) |

## Data Ownership

Owns qualification requests/results, recommendations used in sales context, quotes, carts, sales opportunities, channel attribution, dealer attribution, commission trigger context, approval state, and checkout readiness. Customer, catalog, serviceability, inventory, campaign, billing, and risk data are referenced.

## First Release Scope

Deliver product qualification, quote, cart, pricing display, discount approval, channel/dealer attribution, and product order submission. Add advanced enterprise CPQ, guided solution design, commission automation, and AI-assisted selling later.
