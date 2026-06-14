# Usage, Charging, And Revenue Settlement TMF API To DDL Review

Reviewed: 2026-06-14

Status: Complete for baseline app implementation. Endpoint-specific contract tests and final story-level field promotion still happen during build.

## Scope

This review covers `usage_revenue_settlement` in suite database `ts_bss_commercial`. It uses the local TMF Open API reference set, the suite data model, the API-to-DDL traceability matrix, and the V001 starter DDL.

The review confirms that the app can move into implementation with a V002 typed DDL baseline while preserving full TMF payload compatibility through validated `tmf_payload`, typed common TMF columns, and normalized support tables.

## TMF API Baseline Selection

| TMF API | Local baseline spec | Resources/path roots reviewed | V001 table groups |
| --- | --- | --- | --- |
| TMF635 | `references/tmforum-open-apis/openapi-specs/TMF635_UsageManagement/TMF635-Product_Usage_Management-v5.0.0.oas.yaml` | `exportJob`, `productUsage` | usage_ingestion_batch; open_gateway_usage_view references |
| TMF735 | `references/tmforum-open-apis/openapi-specs/TMF735_CDRTransactionManagement/TMF735-CDR_Transaction_Management-v5.0.0.oas.yaml` | `cdrTransaction` | cdr_transaction; usage_ingestion_batch; revenue_assurance_case |
| TMF771 | `references/tmforum-open-apis/openapi-specs/TMF771_ResourceUsage/TMF771-Resource_Usage_Management-v5.0.0.oas.yaml` | `resourceUsage`, `resourceUsageSpecification` | capacity_source_snapshot; usage_ingestion_batch; capacity_exhaustion_forecast |
| TMF677 | `references/tmforum-open-apis/openapi-specs/TMF677_UsageConsumption/TMF677-Usage_Consumption-v5.1.0.oas.yaml` | `queryUsageConsumption`, `usageConsumptionReport` | consumption_summary; demand_signal_snapshot references |
| TMF696 | `references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json` | `partyRoleProductOfferingRiskAssessment`, `partyRoleRiskAssessment`, `productOfferingRiskAssessment`, `productOrderRiskAssessment`, `shoppingCartRiskAssessment` | rule_definition; decision_definition; credit_decision; risk_exposure; compliance_control |
| TMF678 | `references/tmforum-open-apis/openapi-specs/TMF678_CustomerBill/TMF678-CustomerBill-v5.0.0.oas.yaml` | `appliedCustomerBillingRate`, `billCycle`, `customerBill`, `customerBillOnDemand` | customer_bill; bill_item; billing_adjustment; revenue_margin_scenario references |
| TMF736 | `references/tmforum-open-apis/openapi-specs/TMF736_RevenueSharingAlgorithmManagement/TMF736-Revenue_Sharing_Algorithm_Management-v5.0.0.oas.yaml` | `partyRevSharingAlgorithm` | revenue_sharing_model; commission_trigger_context references |
| TMF737 | `references/tmforum-open-apis/openapi-specs/TMF737_RevenueSharingReportManagement/TMF737-Revenue_Sharing_Report_Management-v5.0.0.oas.yaml` | `partyRevSharingReport` | revenue_sharing_report; commission_trigger_context references |
| TMF738 | `references/tmforum-open-apis/openapi-specs/TMF738_RevenueSharingModelManagement/TMF738-Revenue_Sharing_Model_Management-v5.0.0.oas.yaml` | `partyRevSharingModel` | revenue_sharing_model; revenue_sharing_report |
| TMF620 | `references/tmforum-open-apis/openapi-specs/TMF620_ProductCatalog/TMF620-Product_Catalog_Management-v5.0.0.oas.yaml` | `category`, `exportJob`, `importJob`, `productCatalog`, `productOffering`, `productOfferingPrice`, `productSpecification` | product_specification; product_offering; product_bundle; marketplace_listing; partner_catalog_submission |
| TMF668 | `references/tmforum-open-apis/openapi-specs/TMF668_PartnershipType/TMF668_Partnership_Type_v4.0.0_swagger.json` | `partnership`, `partnershipSpecification` | partnership_type; partner_profile_extension; api_subscription references |
| TMF651 | `references/tmforum-open-apis/openapi-specs/TMF651_AgreementManagement/TMF651_Agreement_Management_API_v4.0.0_swagger.json` | `agreement`, `agreementSpecification` | agreement_template; commercial_term_version; partner agreement references |

## Current DDL Coverage

Current starter DDL is in `database/postgres/suites/ts_bss_commercial/V001__create_app_schemas_and_starter_tables.sql` under schema `usage_revenue_settlement`.

| Current table | TMF purpose | V002 decision |
| --- | --- | --- |
| `usage_revenue_settlement.usage_ingestion_batch` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.mediation_exception` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.cdr_transaction` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.consumption_summary` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.revenue_assurance_case` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.revenue_sharing_model` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.revenue_sharing_report` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.roaming_interconnect_settlement_exception` | Starter table for Usage, Charging, And Revenue Settlement; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| `usage_revenue_settlement.event_outbox` | App outbox for domain and TMF notification events. | Keep and refine through `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |

## Resource To Table Decisions

| TMF API/resource | Master or anchor table | Path coverage | Promoted field candidates | Field handling strategy |
| --- | --- | --- | --- | --- |
| TMF635 `exportJob` | `usage_revenue_settlement.usage_ingestion_batch` | `/exportJob`, `/exportJob/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF635 `productUsage` | `usage_revenue_settlement.usage_ingestion_batch` | `/productUsage`, `/productUsage/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF735 `cdrTransaction` | `usage_revenue_settlement.cdr_transaction` | `/cdrTransaction`, `/cdrTransaction/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF771 `resourceUsage` | `usage_revenue_settlement.usage_ingestion_batch` | `/resourceUsage`, `/resourceUsage/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF771 `resourceUsageSpecification` | `usage_revenue_settlement.usage_ingestion_batch` | `/resourceUsageSpecification`, `/resourceUsageSpecification/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF677 `queryUsageConsumption` | `usage_revenue_settlement.consumption_summary` | `/queryUsageConsumption`, `/queryUsageConsumption/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF677 `usageConsumptionReport` | `usage_revenue_settlement.consumption_summary` | `/usageConsumptionReport`, `/usageConsumptionReport/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF696 `partyRoleProductOfferingRiskAssessment` | `usage_revenue_settlement.usage_ingestion_batch` | `/partyRoleProductOfferingRiskAssessment`, `/partyRoleProductOfferingRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `partyRole`, `place`, `productOffering`, `riskAssessmentResult` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `partyRoleRiskAssessment` | `usage_revenue_settlement.usage_ingestion_batch` | `/partyRoleRiskAssessment`, `/partyRoleRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `riskAssessmentResult`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `productOfferingRiskAssessment` | `usage_revenue_settlement.usage_ingestion_batch` | `/productOfferingRiskAssessment`, `/productOfferingRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `partyRole`, `place`, `productOffering`, `riskAssessmentResult` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `productOrderRiskAssessment` | `usage_revenue_settlement.usage_ingestion_batch` | `/productOrderRiskAssessment`, `/productOrderRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `productOrder`, `riskAssessmentResult`, `@baseType` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `shoppingCartRiskAssessment` | `usage_revenue_settlement.usage_ingestion_batch` | `/shoppingCartRiskAssessment`, `/shoppingCartRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `riskAssessmentResult`, `shoppingCart`, `@baseType` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF678 `appliedCustomerBillingRate` | `usage_revenue_settlement.usage_ingestion_batch` | `/appliedCustomerBillingRate`, `/appliedCustomerBillingRate/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF678 `billCycle` | `usage_revenue_settlement.usage_ingestion_batch` | `/billCycle`, `/billCycle/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF678 `customerBill` | `usage_revenue_settlement.usage_ingestion_batch` | `/customerBill`, `/customerBill/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF678 `customerBillOnDemand` | `usage_revenue_settlement.usage_ingestion_batch` | `/customerBillOnDemand`, `/customerBillOnDemand/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF736 `partyRevSharingAlgorithm` | `usage_revenue_settlement.revenue_sharing_model` | `/partyRevSharingAlgorithm`, `/partyRevSharingAlgorithm/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF737 `partyRevSharingReport` | `usage_revenue_settlement.revenue_sharing_report` | `/partyRevSharingReport`, `/partyRevSharingReport/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF738 `partyRevSharingModel` | `usage_revenue_settlement.revenue_sharing_model` | `/partyRevSharingModel`, `/partyRevSharingModel/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `category` | `usage_revenue_settlement.usage_ingestion_batch` | `/category`, `/category/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `exportJob` | `usage_revenue_settlement.usage_ingestion_batch` | `/exportJob`, `/exportJob/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `importJob` | `usage_revenue_settlement.usage_ingestion_batch` | `/importJob`, `/importJob/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `productCatalog` | `usage_revenue_settlement.usage_ingestion_batch` | `/productCatalog`, `/productCatalog/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `productOffering` | `usage_revenue_settlement.usage_ingestion_batch` | `/productOffering`, `/productOffering/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `productOfferingPrice` | `usage_revenue_settlement.usage_ingestion_batch` | `/productOfferingPrice`, `/productOfferingPrice/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF620 `productSpecification` | `usage_revenue_settlement.usage_ingestion_batch` | `/productSpecification`, `/productSpecification/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF668 `partnership` | `usage_revenue_settlement.usage_ingestion_batch` | `/partnership`, `/partnership/{id}` | `id`, `href`, `description`, `name`, `partner`, `specification`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF668 `partnershipSpecification` | `usage_revenue_settlement.usage_ingestion_batch` | `/partnershipSpecification`, `/partnershipSpecification/{id}` | `id`, `href`, `description`, `name`, `roleSpecification`, `@baseType`, `@schemaLocation`, `@type` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF651 `agreement` | `usage_revenue_settlement.usage_ingestion_batch` | `/agreement`, `/agreement/{id}` | `id`, `href`, `agreementType`, `description`, `documentNumber`, `initialDate`, `name`, `statementOfIntent` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF651 `agreementSpecification` | `usage_revenue_settlement.usage_ingestion_batch` | `/agreementSpecification`, `/agreementSpecification/{id}` | `id`, `href`, `description`, `isBundle`, `lastUpdate`, `lifecycleStatus`, `name`, `version` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |

## V002 DDL Refinement

Migration: `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql`

The migration adds this implementation baseline for the app:

| Area | Decision |
| --- | --- |
| Common TMF fields | Add reusable typed columns such as `tmf_id`, `tmf_href`, `tmf_type`, `tmf_base_type`, `tmf_schema_location`, `tmf_referred_type`, `tmf_name`, `tmf_description`, `tmf_lifecycle_status`, `tmf_state`, dates, priority, and external ID to every V001 app table. |
| Full TMF compatibility | Keep the V001 `tmf_payload` column as the complete validated TMF resource snapshot for fields that are not yet promoted to typed columns. |
| Characteristics and references | Add normalized `tmf_characteristic`, `tmf_resource_reference`, `tmf_external_identifier`, `tmf_related_party`, `tmf_note`, `tmf_attachment`, and `tmf_relationship` support tables. |
| API/resource map | Add `tmf_api_resource_map` rows for the selected local TMF APIs and resource roots. |
| Event contracts | Add baseline event contract rows for create, update, state-change, and delete events per reviewed API resource. |
| Privacy and audit | Add table-level privacy, retention, legal-hold, residency, masking, and audit policy rows. |
| High-volume candidates | `usage_revenue_settlement.usage_ingestion_batch`, `usage_revenue_settlement.cdr_transaction`, `usage_revenue_settlement.event_outbox` |

## Event Contract Baseline

Events are registered in `usage_revenue_settlement.event_contract` using `usage_revenue_settlement.event_outbox` as the publication basis. Consumers must be added when integrations are designed; no app should directly write another app schema.

## Privacy, Retention, And Audit Baseline

| Table | Data classification | Retention class | Audit level |
| --- | --- | --- | --- |
| `usage_revenue_settlement.usage_ingestion_batch` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.mediation_exception` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.cdr_transaction` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.consumption_summary` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.revenue_assurance_case` | confidential | business_lifecycle | standard-high |
| `usage_revenue_settlement.revenue_sharing_model` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.revenue_sharing_report` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.roaming_interconnect_settlement_exception` | internal | operational_telemetry | standard |
| `usage_revenue_settlement.event_outbox` | internal | operational_telemetry | standard |

## Build Gate Result

| Gate item | Result |
| --- | --- |
| API/resource review | Complete for baseline implementation |
| V002 typed DDL | Complete: `database/postgres/suites/ts_bss_commercial/V006__refine_usage_revenue_settlement_tmf_core.sql` |
| Event contract register | Baseline complete |
| Privacy/retention/audit classification | Baseline complete |
| Remaining implementation control | Validate exact endpoint operations and contract tests as Angular/Spring Boot features are built |
