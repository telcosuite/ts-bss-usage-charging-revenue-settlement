# Credit, Fraud, And Collections App

## Purpose

Assess credit exposure, detect fraud, manage collections strategies, coordinate service restriction/reconnection, and resolve disputes or recovery actions.

## Primary Personas

- Credit risk analyst: manages credit class, deposits, exposure, and approval rules.
- Fraud operations analyst: investigates suspicious identity, order, payment, usage, roaming, dealer, and device activity.
- Collections user: manages dunning, promises to pay, recovery, write-off, and restrictions.
- Care supervisor: approves exceptions and customer-impacting actions.
- Compliance user: reviews evidence, policy adherence, and regulatory protections.

## Core Workflow

1. Assess credit risk during onboarding, quote, order, device financing, product changes, and enterprise account review.
2. Detect fraud from identity, order, payment, usage, CDR, device, location, partner, and dealer signals.
3. Open cases, gather evidence, assign actions, and trigger holds, verification, reversals, tickets, or restrictions.
4. Execute collections strategies with communication, payment promises, dunning, restriction, reconnection, and recovery steps.
5. Resolve disputes, apply approved adjustments, and feed root causes to revenue assurance and process improvement.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Credit Risk And Eligibility | Assess credit during onboarding, quote, order, device financing, and product changes. Manage credit class, deposits, spending limits, exposure, account flags, approvals, and enterprise exposure. | [TMF629](../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement), [TMF666](../../../references/tmforum-open-apis/openapi-specs/TMF666_AccountManagement), [TMF679](../../../references/tmforum-open-apis/openapi-specs/TMF679_ProductOfferingQualification), [TMF696](../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement) |
| Fraud Detection And Case Management | Detect subscription, payment, account takeover, SIM swap, usage, roaming, dealer, device, and revenue bypass fraud. Manage investigation queues, evidence, actions, escalations, and closure. | [TMF720](../../../references/tmforum-open-apis/openapi-specs/TMF720_DigitalIdentity), [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder), [TMF676](../../../references/tmforum-open-apis/openapi-specs/TMF676_PaymentManagement), [TMF677](../../../references/tmforum-open-apis/openapi-specs/TMF677_UsageConsumption), [TMF735](../../../references/tmforum-open-apis/openapi-specs/TMF735_CDRTransactionManagement), [TMF696](../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |
| Collections Strategy | Define dunning paths, reminders, treatments, payment promises, restrictions, reconnection, write-off, recovery, segmentation, regulatory constraints, and coordination with care and billing. | [TMF678](../../../references/tmforum-open-apis/openapi-specs/TMF678_CustomerBill), [TMF676](../../../references/tmforum-open-apis/openapi-specs/TMF676_PaymentManagement), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF644](../../../references/tmforum-open-apis/openapi-specs/TMF644_Privacy) |
| Service Restriction And Reconnection | Trigger suspension, barring, throttling, feature restriction, restoration, and reconnection. Track exemptions, customer impact, approvals, and regulatory protections. | [TMF637](../../../references/tmforum-open-apis/openapi-specs/TMF637_ProductInventory), [TMF638](../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF640](../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication) |
| Dispute And Recovery | Manage bill, payment, usage, settlement, device, contract, and partner disputes. Track evidence, investigation, communication, adjustment, settlement, and recovery. | [TMF678](../../../references/tmforum-open-apis/openapi-specs/TMF678_CustomerBill), [TMF676](../../../references/tmforum-open-apis/openapi-specs/TMF676_PaymentManagement), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |

## Data Ownership

Owns credit decisions, fraud cases, risk signals, collections treatments, restriction/reconnection decisions, dispute cases, recovery actions, and investigation evidence.

## First Release Scope

Start with credit eligibility hooks, collections strategy, dispute cases, and manual fraud case management. Add automated fraud models, device reputation, bureau integrations, and advanced recovery analytics after data quality matures.

