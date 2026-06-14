# Marketing, Campaign, And Customer Journey App

## Purpose

Plan and orchestrate telecom-specific campaigns, customer journeys, retention treatments, audience segments, and contact-policy decisions.

## Primary Personas

- Marketing manager: plans campaigns and audience strategies.
- Campaign manager: configures launch windows, offers, channels, budgets, and performance tracking.
- Retention manager: manages save offers, churn actions, and loyalty treatments.
- Customer experience owner: designs assisted and digital journeys.
- Compliance user: verifies consent, suppression, frequency caps, and contact rules.

## Core Workflow

1. Build segments and audiences from customer, product, usage, billing, assurance, serviceability, loyalty, and channel behavior.
2. Plan campaign objectives, eligible offers, promotions, channels, launch windows, budgets, and success metrics.
3. Orchestrate journeys across communication, recommendation, cart, order, ticket, appointment, billing, and care actions.
4. Enforce consent, contact policy, suppression, regulatory rules, and vulnerable-customer protections.
5. Measure conversion, churn reduction, save rate, channel effectiveness, and customer experience outcomes.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Segment And Audience | Define customer, prospect, household, enterprise, partner, and account segments. Use product holding, usage, serviceability, billing, assurance, churn, loyalty, and channel signals. Govern refresh, consent eligibility, suppression, and exports. | [TMF629](../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement), [TMF632](../../../references/tmforum-open-apis/openapi-specs/TMF632_PartyManagement), [TMF637](../../../references/tmforum-open-apis/openapi-specs/TMF637_ProductInventory), [TMF677](../../../references/tmforum-open-apis/openapi-specs/TMF677_UsageConsumption), [TMF644](../../../references/tmforum-open-apis/openapi-specs/TMF644_Privacy) |
| Campaign Planning And Offer Targeting | Plan acquisition, upsell, cross-sell, retention, win-back, migration, device, loyalty, and enterprise campaigns. Connect campaigns to offers, promotions, eligibility, channels, dates, approvals, A/B tests, holdouts, and metrics. | [TMF620](../../../references/tmforum-open-apis/openapi-specs/TMF620_ProductCatalog), [TMF671](../../../references/tmforum-open-apis/openapi-specs/TMF671_Promotion), [TMF679](../../../references/tmforum-open-apis/openapi-specs/TMF679_ProductOfferingQualification), [TMF680](../../../references/tmforum-open-apis/openapi-specs/TMF680_Recommendation), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication) |
| Journey Orchestration | Design onboarding, buying, renewal, upgrade, relocation, complaint, care, payment recovery, and retention journeys. Track state, next-best action, abandonment, conversion, fallout, and customer experience signals. | [TMF680](../../../references/tmforum-open-apis/openapi-specs/TMF680_Recommendation), [TMF683](../../../references/tmforum-open-apis/openapi-specs/TMF683_PartyInteraction), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF663](../../../references/tmforum-open-apis/openapi-specs/TMF663_ShoppingCart), [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |
| Retention And Loyalty Treatment | Define churn-risk treatments, save offers, renewal treatments, loyalty benefits, service recovery gestures, eligibility, approval, acceptance, cost, and outcome. | [TMF658](../../../references/tmforum-open-apis/openapi-specs/TMF658_LoyaltyManagement), [TMF680](../../../references/tmforum-open-apis/openapi-specs/TMF680_Recommendation), [TMF671](../../../references/tmforum-open-apis/openapi-specs/TMF671_Promotion), [TMF678](../../../references/tmforum-open-apis/openapi-specs/TMF678_CustomerBill), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |
| Contact Policy And Consent Enforcement | Enforce consent, communication preferences, quiet hours, frequency caps, suppression lists, regulatory rules, customer-protection policies, and auditable contact decisions. | [TMF644](../../../references/tmforum-open-apis/openapi-specs/TMF644_Privacy), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF629](../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement), [TMF683](../../../references/tmforum-open-apis/openapi-specs/TMF683_PartyInteraction) |

## Data Ownership

Owns segments, audience snapshots, campaign definitions, journey definitions, treatment rules, contact-policy decisions, and journey state. Consent remains mastered by Customer And Party 360.

## First Release Scope

Deliver audience segmentation, campaign-offer linkage, contact-policy check, and journey state tracking. Integrate with external martech only where needed, while keeping telecom eligibility and contact policy in our suite.

