# Customer And Party 360 App

## Purpose

Provide the commercial master view of parties, customers, accounts, identities, consents, interactions, documents, care cases, complaints, and loyalty context across residential, SMB, enterprise, wholesale, partner, government, and internal users.

## Primary Personas

- Care agent: needs a complete customer and account view to resolve requests.
- Account manager: manages enterprise structures, contacts, sites, contracts, and hierarchies.
- Compliance user: reviews identity, consent, privacy, documents, and access history.
- Contact center agent: records interactions and sees next-best action context.
- Care supervisor: manages escalations, complaints, promises, and regulatory response deadlines.
- Back-office user: corrects customer, party, account, document, and relationship data.

## Core Workflow

1. Create or locate party and customer records.
2. Link parties to roles, customers, accounts, contacts, and organizations.
3. Manage identity, access, consent, communication preference, and privacy state.
4. Record interactions, documents, complaints, care cases, and correspondence against the right customer/account/order/ticket.
5. Track promises, escalations, ownership, regulatory deadlines, and customer outcomes.
6. Surface loyalty, recommendations, risk flags, products, orders, bills, tickets, and service impacts.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Party Master | Manage individuals, organizations, contact media, identifications, relationships, household/enterprise/partner/supplier structures, lifecycle states, and reusable party records. | [TMF632](../../../references/tmforum-open-apis/openapi-specs/TMF632_PartyManagement), [TMF669](../../../references/tmforum-open-apis/openapi-specs/TMF669_PartyRole) |
| Customer Profile | Manage customer records, segment, status, risk flags, preferences, customer relationships, customer timeline, and links to products, orders, bills, tickets, documents, interactions, and agreements. | [TMF629](../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement), [TMF683](../../../references/tmforum-open-apis/openapi-specs/TMF683_PartyInteraction) |
| Account Hierarchy | Manage customer accounts, billing accounts, financial accounts, parent-child structures, cost centers, site ownership, authorized users, account ownership, and links to bills/payments/products/orders. | [TMF666](../../../references/tmforum-open-apis/openapi-specs/TMF666_AccountManagement) |
| Identity, Access, And Consent | Manage digital identity, federated identity, portal access, delegated administration, roles, permissions, consent, communication preference, privacy constraints, and audit trails. | [TMF720](../../../references/tmforum-open-apis/openapi-specs/TMF720_DigitalIdentity), [TMF691](../../../references/tmforum-open-apis/openapi-specs/TMF691_FederatedIdentity), [TMF672](../../../references/tmforum-open-apis/openapi-specs/TMF672_UserRolesPermissions), [TMF644](../../../references/tmforum-open-apis/openapi-specs/TMF644_Privacy) |
| Interaction, Communication, And Document | Capture calls, chat, email, retail, partner, field, and digital interactions. Manage notifications, templates, correspondence, attachments, contracts, evidence, and document links. | [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF683](../../../references/tmforum-open-apis/openapi-specs/TMF683_PartyInteraction), [TMF667](../../../references/tmforum-open-apis/openapi-specs/TMF667_Document) |
| Customer Care Case And Complaint | Manage care cases, complaints, escalations, promises, vulnerable-customer flags, regulatory response deadlines, complaint evidence, root cause, resolution commitments, and handoff to trouble tickets, billing disputes, orders, assurance, or field work. | [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket), [TMF683](../../../references/tmforum-open-apis/openapi-specs/TMF683_PartyInteraction), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF667](../../../references/tmforum-open-apis/openapi-specs/TMF667_Document), [TMF629](../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement), [TMF644](../../../references/tmforum-open-apis/openapi-specs/TMF644_Privacy) |
| Loyalty And Engagement | Track loyalty membership, points, benefits, tiers, retention offers, engagement context, next-best action inputs, and links to promotions, billing, care, and product offers. | [TMF658](../../../references/tmforum-open-apis/openapi-specs/TMF658_LoyaltyManagement), [TMF680](../../../references/tmforum-open-apis/openapi-specs/TMF680_Recommendation) |

## Data Ownership

Owns party, customer, account, identity-to-customer links, consent state, interaction records, communication evidence, document metadata, care case and complaint context, and loyalty membership context. Product inventory, bills, orders, tickets, and payments are referenced through their owning apps.

## First Release Scope

Deliver party/customer/account master, consent and communication preference, interaction timeline, document links, care case/complaint context, and customer search. Add loyalty, delegated administration, and advanced enterprise hierarchy management after core care and order flows are live.
