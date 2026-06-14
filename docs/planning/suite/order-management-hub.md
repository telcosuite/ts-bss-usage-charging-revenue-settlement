# Order Management Hub

## Purpose

Own the commercial product order lifecycle and coordinate decomposition, orchestration, jeopardy, and fallout across BSS, OSS, billing, logistics, field, and partner systems.

## Primary Personas

- Order manager: monitors product order progress, jeopardy, and exceptions.
- Sales/care user: needs customer-visible order status and amendment options.
- Fulfillment coordinator: receives decomposed service/resource work.
- Billing operations user: validates billing actions and order-to-bill handoff.
- Partner operations user: monitors partner-delivered order components.

## Core Workflow

1. Receive product order from quote, cart, partner, self-care, care, or API channel.
2. Validate customer, account, product, pricing, configuration, appointment, risk, and serviceability context.
3. Decompose product order into service orders, resource orders, work orders, shipments, partner tasks, and billing actions.
4. Track order milestones, dependencies, jeopardy, holds, retries, and customer-visible status.
5. Detect fallout, route manual tasks, amend, cancel, retry, or compensate work.
6. Close order after fulfillment, inventory, billing, and customer communication handoff.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Product Order Capture | Create and manage add, modify, disconnect, suspend, resume, transfer, relocation, renewal, number port-in, number port-out, SIM/eSIM swap, ownership transfer, and cancellation actions from all channels. Validate commercial, identity, risk, serviceability, regulatory, and operational context. | [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder) |
| Order Decomposition | Convert product order lines into service orders, resource orders, work orders, shipments, activation tasks, partner tasks, and billing actions using catalog realization rules. | [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder), [TMF641](../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder), [TMF652](../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement), [TMF701](../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow) |
| Order Orchestration And Jeopardy | Track dependencies, SLA, due dates, milestones, parallel steps, holds, retries, escalations, status, customer communications, and operational dashboards. | [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder), [TMF701](../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow) |
| Order Fallout And Exception | Detect validation, inventory, capacity, activation, billing, appointment, shipping, and partner failures. Provide queues for resolution, reassignment, cancellation, amendment, retry, and root-cause analytics. | [TMF622](../../../references/tmforum-open-apis/openapi-specs/TMF622_ProductOrder), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |

## Data Ownership

Owns product order, product order item state, commercial order milestones, decomposition plan, customer-visible status, order jeopardy, and order fallout records. Fulfillment execution state remains in OSS fulfillment apps.

## First Release Scope

Deliver product order intake, validation, decomposition, status, and fallout queue. Add complex multi-party order orchestration, compensation, and in-flight flexibility after simple order flows work reliably.
