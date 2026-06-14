-- TelcoSuite starter DDL for BSS Commercial
-- Target database: ts_bss_commercial
-- Source model: planning/suite-details/02-bss-commercial/data-model.md
-- Migration type: Flyway SQL migration, run while connected to ts_bss_commercial.
-- Purpose: create app schemas, starter tables, standard controls, and app event outboxes.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS customer_party_360;
COMMENT ON SCHEMA customer_party_360 IS 'App-owned schema for Customer And Party 360 in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS product_offer_studio;
COMMENT ON SCHEMA product_offer_studio IS 'App-owned schema for Product And Offer Studio in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS marketing_journey;
COMMENT ON SCHEMA marketing_journey IS 'App-owned schema for Marketing, Campaign, And Customer Journey in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS sales_cpq_cart;
COMMENT ON SCHEMA sales_cpq_cart IS 'App-owned schema for Sales, CPQ, And Cart in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS order_management_hub;
COMMENT ON SCHEMA order_management_hub IS 'App-owned schema for Order Management Hub in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS billing_payments;
COMMENT ON SCHEMA billing_payments IS 'App-owned schema for Billing, Payments, And Account Operations in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS credit_fraud_collections;
COMMENT ON SCHEMA credit_fraud_collections IS 'App-owned schema for Credit, Fraud, And Collections in BSS Commercial.';
CREATE SCHEMA IF NOT EXISTS usage_revenue_settlement;
COMMENT ON SCHEMA usage_revenue_settlement IS 'App-owned schema for Usage, Charging, And Revenue Settlement in BSS Commercial.';

CREATE TABLE IF NOT EXISTS customer_party_360.party (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__party_canonica_7c1a8530 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__party_version_66296a39 CHECK (version > 0),
    CONSTRAINT ck_customer__party_validity_672f88c0 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__party_canonica_8782c7b1 ON customer_party_360.party (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__party_status_bfa52c0c ON customer_party_360.party (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__party_updated_778b7fab ON customer_party_360.party (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__party_source_c5d4e45a ON customer_party_360.party (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__party_attrgin_5eae4360 ON customer_party_360.party USING gin (attributes);
COMMENT ON TABLE customer_party_360.party IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.party.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.party.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.party.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.party_role (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__party_role_canonica_acaa8689 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__party_role_version_3078be2b CHECK (version > 0),
    CONSTRAINT ck_customer__party_role_validity_8dad540a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__party_role_canonica_65da598f ON customer_party_360.party_role (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__party_role_status_7dbccb9b ON customer_party_360.party_role (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__party_role_updated_207e74b9 ON customer_party_360.party_role (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__party_role_source_04d19de9 ON customer_party_360.party_role (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__party_role_attrgin_15f26b5e ON customer_party_360.party_role USING gin (attributes);
COMMENT ON TABLE customer_party_360.party_role IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.party_role.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.party_role.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.party_role.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.customer (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__customer_canonica_6a8ff2aa UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__customer_version_3ebebd62 CHECK (version > 0),
    CONSTRAINT ck_customer__customer_validity_8740684a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__customer_canonica_aa687eec ON customer_party_360.customer (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__customer_status_f9c6e951 ON customer_party_360.customer (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__customer_updated_7706b6e2 ON customer_party_360.customer (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__customer_source_a9347bc6 ON customer_party_360.customer (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__customer_attrgin_86cd29ce ON customer_party_360.customer USING gin (attributes);
COMMENT ON TABLE customer_party_360.customer IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.customer.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.customer.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.customer.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.customer_account_hierarchy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__customer_account_hierarchy_canonica_196bf8a0 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__customer_account_hierarchy_version_2055aa2d CHECK (version > 0),
    CONSTRAINT ck_customer__customer_account_hierarchy_validity_c363c798 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__customer_account_hierarchy_canonica_f9c29b6c ON customer_party_360.customer_account_hierarchy (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__customer_account_hierarchy_status_5251718b ON customer_party_360.customer_account_hierarchy (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__customer_account_hierarchy_updated_e385587b ON customer_party_360.customer_account_hierarchy (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__customer_account_hierarchy_source_a4a814ec ON customer_party_360.customer_account_hierarchy (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__customer_account_hierarchy_attrgin_ce9ff26c ON customer_party_360.customer_account_hierarchy USING gin (attributes);
COMMENT ON TABLE customer_party_360.customer_account_hierarchy IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.customer_account_hierarchy.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.customer_account_hierarchy.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.customer_account_hierarchy.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.customer_identity_link (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__customer_identity_link_canonica_1cdad3bb UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__customer_identity_link_version_d9ca7560 CHECK (version > 0),
    CONSTRAINT ck_customer__customer_identity_link_validity_6cedac0b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__customer_identity_link_canonica_1d53ca0c ON customer_party_360.customer_identity_link (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__customer_identity_link_status_da19db3a ON customer_party_360.customer_identity_link (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__customer_identity_link_updated_902c1886 ON customer_party_360.customer_identity_link (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__customer_identity_link_source_29f1b98e ON customer_party_360.customer_identity_link (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__customer_identity_link_attrgin_04f89d8c ON customer_party_360.customer_identity_link USING gin (attributes);
COMMENT ON TABLE customer_party_360.customer_identity_link IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.customer_identity_link.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.customer_identity_link.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.customer_identity_link.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.consent (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__consent_canonica_ca54a52e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__consent_version_18e2b316 CHECK (version > 0),
    CONSTRAINT ck_customer__consent_validity_7738b1e9 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__consent_canonica_dbb47d3c ON customer_party_360.consent (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__consent_status_65790d0b ON customer_party_360.consent (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__consent_updated_19433219 ON customer_party_360.consent (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__consent_source_d3c34826 ON customer_party_360.consent (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__consent_attrgin_87b490d3 ON customer_party_360.consent USING gin (attributes);
COMMENT ON TABLE customer_party_360.consent IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.consent.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.consent.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.consent.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.privacy_preference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__privacy_preference_canonica_487e72a1 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__privacy_preference_version_ef0b71f2 CHECK (version > 0),
    CONSTRAINT ck_customer__privacy_preference_validity_888c5f6f CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__privacy_preference_canonica_703f21a0 ON customer_party_360.privacy_preference (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__privacy_preference_status_787d063f ON customer_party_360.privacy_preference (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__privacy_preference_updated_d3e6fe29 ON customer_party_360.privacy_preference (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__privacy_preference_source_af2e4cf7 ON customer_party_360.privacy_preference (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__privacy_preference_attrgin_a405b0d5 ON customer_party_360.privacy_preference USING gin (attributes);
COMMENT ON TABLE customer_party_360.privacy_preference IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.privacy_preference.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.privacy_preference.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.privacy_preference.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.interaction (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__interaction_canonica_4df71ac9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__interaction_version_f3d7215b CHECK (version > 0),
    CONSTRAINT ck_customer__interaction_validity_980cdfa3 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__interaction_canonica_8c1905ab ON customer_party_360.interaction (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__interaction_status_85f8b4d4 ON customer_party_360.interaction (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__interaction_updated_b6201bb0 ON customer_party_360.interaction (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__interaction_source_520a2d8f ON customer_party_360.interaction (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__interaction_attrgin_114e350e ON customer_party_360.interaction USING gin (attributes);
COMMENT ON TABLE customer_party_360.interaction IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.interaction.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.interaction.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.interaction.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.communication_record (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__communication_record_canonica_466949f6 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__communication_record_version_739299c4 CHECK (version > 0),
    CONSTRAINT ck_customer__communication_record_validity_43c82eb4 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__communication_record_canonica_9331f0d8 ON customer_party_360.communication_record (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__communication_record_status_a0a7ee70 ON customer_party_360.communication_record (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__communication_record_updated_0fe70330 ON customer_party_360.communication_record (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__communication_record_source_cc843ec9 ON customer_party_360.communication_record (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__communication_record_attrgin_f11fe738 ON customer_party_360.communication_record USING gin (attributes);
COMMENT ON TABLE customer_party_360.communication_record IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.communication_record.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.communication_record.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.communication_record.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.customer_document_metadata (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__customer_document_metadata_canonica_50d06274 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__customer_document_metadata_version_e65e3cba CHECK (version > 0),
    CONSTRAINT ck_customer__customer_document_metadata_validity_3708aada CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__customer_document_metadata_canonica_ea400fa6 ON customer_party_360.customer_document_metadata (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__customer_document_metadata_status_ec6c6357 ON customer_party_360.customer_document_metadata (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__customer_document_metadata_updated_b3d6867f ON customer_party_360.customer_document_metadata (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__customer_document_metadata_source_475546a6 ON customer_party_360.customer_document_metadata (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__customer_document_metadata_attrgin_4a3877f8 ON customer_party_360.customer_document_metadata USING gin (attributes);
COMMENT ON TABLE customer_party_360.customer_document_metadata IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.customer_document_metadata.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.customer_document_metadata.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.customer_document_metadata.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.care_case (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__care_case_canonica_9f4b6246 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__care_case_version_9e1ac283 CHECK (version > 0),
    CONSTRAINT ck_customer__care_case_validity_da8b2854 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__care_case_canonica_c8bcbf13 ON customer_party_360.care_case (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__care_case_status_caf00268 ON customer_party_360.care_case (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__care_case_updated_698c7e4e ON customer_party_360.care_case (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__care_case_source_655e2744 ON customer_party_360.care_case (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__care_case_attrgin_12313e92 ON customer_party_360.care_case USING gin (attributes);
COMMENT ON TABLE customer_party_360.care_case IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.care_case.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.care_case.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.care_case.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.loyalty_membership (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__loyalty_membership_canonica_112a9191 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__loyalty_membership_version_99e0198c CHECK (version > 0),
    CONSTRAINT ck_customer__loyalty_membership_validity_3cf00c07 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__loyalty_membership_canonica_d33cd086 ON customer_party_360.loyalty_membership (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__loyalty_membership_status_d8eb3fbc ON customer_party_360.loyalty_membership (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__loyalty_membership_updated_e13d19c8 ON customer_party_360.loyalty_membership (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__loyalty_membership_source_9b148017 ON customer_party_360.loyalty_membership (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__loyalty_membership_attrgin_fb9dd6ea ON customer_party_360.loyalty_membership USING gin (attributes);
COMMENT ON TABLE customer_party_360.loyalty_membership IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.loyalty_membership.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.loyalty_membership.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.loyalty_membership.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.external_reference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_customer__external_reference_canonica_87621071 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_customer__external_reference_version_71318efd CHECK (version > 0),
    CONSTRAINT ck_customer__external_reference_validity_2aeb32aa CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_customer__external_reference_canonica_824c1bb8 ON customer_party_360.external_reference (canonical_id);
CREATE INDEX IF NOT EXISTS ix_customer__external_reference_status_5fe2abed ON customer_party_360.external_reference (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_customer__external_reference_updated_6ed8a451 ON customer_party_360.external_reference (updated_at);
CREATE INDEX IF NOT EXISTS ix_customer__external_reference_source_df9a5426 ON customer_party_360.external_reference (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_customer__external_reference_attrgin_73e19b0a ON customer_party_360.external_reference USING gin (attributes);
COMMENT ON TABLE customer_party_360.external_reference IS 'Starter table for Customer And Party 360. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN customer_party_360.external_reference.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN customer_party_360.external_reference.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN customer_party_360.external_reference.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS customer_party_360.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_customer__event_outbox_status_87d3ca78 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_customer__event_outbox_publish_23598738 ON customer_party_360.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_customer__event_outbox_eventkey_05cc0fb5 ON customer_party_360.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_customer__event_outbox_agg_9ab68b32 ON customer_party_360.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE customer_party_360.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS product_offer_studio.product_specification (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_product_specification_canonica_e07211b1 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_product_specification_version_15810cb7 CHECK (version > 0),
    CONSTRAINT ck_product_o_product_specification_validity_12d5fd98 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_product_specification_canonica_12dfa308 ON product_offer_studio.product_specification (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_product_specification_status_8f516507 ON product_offer_studio.product_specification (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_product_specification_updated_b8dd9647 ON product_offer_studio.product_specification (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_product_specification_source_3f03c61d ON product_offer_studio.product_specification (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_product_specification_attrgin_c68f141f ON product_offer_studio.product_specification USING gin (attributes);
COMMENT ON TABLE product_offer_studio.product_specification IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.product_specification.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.product_specification.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.product_specification.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.product_offering (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_product_offering_canonica_e618ad68 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_product_offering_version_9899466a CHECK (version > 0),
    CONSTRAINT ck_product_o_product_offering_validity_5fb7814d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_product_offering_canonica_8af8c1ad ON product_offer_studio.product_offering (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_product_offering_status_4a27f7b7 ON product_offer_studio.product_offering (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_product_offering_updated_db044dba ON product_offer_studio.product_offering (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_product_offering_source_8e820a03 ON product_offer_studio.product_offering (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_product_offering_attrgin_ff34003e ON product_offer_studio.product_offering USING gin (attributes);
COMMENT ON TABLE product_offer_studio.product_offering IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.product_offering.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.product_offering.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.product_offering.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.product_bundle (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_product_bundle_canonica_379002de UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_product_bundle_version_61cb21e7 CHECK (version > 0),
    CONSTRAINT ck_product_o_product_bundle_validity_c0142782 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_product_bundle_canonica_094d5180 ON product_offer_studio.product_bundle (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_product_bundle_status_9e97ca4a ON product_offer_studio.product_bundle (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_product_bundle_updated_b4cc8312 ON product_offer_studio.product_bundle (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_product_bundle_source_e1089831 ON product_offer_studio.product_bundle (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_product_bundle_attrgin_16a4032e ON product_offer_studio.product_bundle USING gin (attributes);
COMMENT ON TABLE product_offer_studio.product_bundle IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.product_bundle.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.product_bundle.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.product_bundle.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.product_price (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_product_price_canonica_9043d891 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_product_price_version_9624c5e3 CHECK (version > 0),
    CONSTRAINT ck_product_o_product_price_validity_1aabe725 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_product_price_canonica_e6f52ced ON product_offer_studio.product_price (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_product_price_status_d3296529 ON product_offer_studio.product_price (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_product_price_updated_277784af ON product_offer_studio.product_price (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_product_price_source_1d94beab ON product_offer_studio.product_price (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_product_price_attrgin_b5772671 ON product_offer_studio.product_price USING gin (attributes);
COMMENT ON TABLE product_offer_studio.product_price IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.product_price.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.product_price.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.product_price.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.promotion (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_promotion_canonica_1ac6fedb UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_promotion_version_75425190 CHECK (version > 0),
    CONSTRAINT ck_product_o_promotion_validity_8ef5514e CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_promotion_canonica_e5e33ffe ON product_offer_studio.promotion (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_promotion_status_fb16e477 ON product_offer_studio.promotion (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_promotion_updated_c0b9b2a7 ON product_offer_studio.promotion (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_promotion_source_afb66bd6 ON product_offer_studio.promotion (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_promotion_attrgin_df0de5f9 ON product_offer_studio.promotion USING gin (attributes);
COMMENT ON TABLE product_offer_studio.promotion IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.promotion.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.promotion.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.promotion.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.product_configuration_model (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_product_configuration_mode_canonica_de1f1a10 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_product_configuration_mode_version_2b427707 CHECK (version > 0),
    CONSTRAINT ck_product_o_product_configuration_mode_validity_6343df05 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_product_configuration_mode_canonica_64cc1523 ON product_offer_studio.product_configuration_model (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_product_configuration_mode_status_e0d20f40 ON product_offer_studio.product_configuration_model (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_product_configuration_mode_updated_36f100ce ON product_offer_studio.product_configuration_model (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_product_configuration_mode_source_f1ed57f0 ON product_offer_studio.product_configuration_model (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_product_configuration_mode_attrgin_3d6b622e ON product_offer_studio.product_configuration_model USING gin (attributes);
COMMENT ON TABLE product_offer_studio.product_configuration_model IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.product_configuration_model.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.product_configuration_model.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.product_configuration_model.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.agreement_template (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_agreement_template_canonica_5e7168a2 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_agreement_template_version_ad32f83c CHECK (version > 0),
    CONSTRAINT ck_product_o_agreement_template_validity_0ef79b37 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_agreement_template_canonica_2f7f74b7 ON product_offer_studio.agreement_template (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_agreement_template_status_7614f78a ON product_offer_studio.agreement_template (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_agreement_template_updated_f3db2637 ON product_offer_studio.agreement_template (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_agreement_template_source_c79a038a ON product_offer_studio.agreement_template (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_agreement_template_attrgin_d4746e35 ON product_offer_studio.agreement_template USING gin (attributes);
COMMENT ON TABLE product_offer_studio.agreement_template IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.agreement_template.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.agreement_template.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.agreement_template.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.commercial_term_version (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_commercial_term_version_canonica_a556f224 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_commercial_term_version_version_9451c3cf CHECK (version > 0),
    CONSTRAINT ck_product_o_commercial_term_version_validity_943dc72d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_commercial_term_version_canonica_6afc1962 ON product_offer_studio.commercial_term_version (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_commercial_term_version_status_81706b69 ON product_offer_studio.commercial_term_version (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_commercial_term_version_updated_e13f1316 ON product_offer_studio.commercial_term_version (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_commercial_term_version_source_fc499791 ON product_offer_studio.commercial_term_version (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_commercial_term_version_attrgin_d4831dcb ON product_offer_studio.commercial_term_version USING gin (attributes);
COMMENT ON TABLE product_offer_studio.commercial_term_version IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.commercial_term_version.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.commercial_term_version.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.commercial_term_version.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.catalog_version (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_product_o_catalog_version_canonica_23991428 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_product_o_catalog_version_version_dfa823b2 CHECK (version > 0),
    CONSTRAINT ck_product_o_catalog_version_validity_f72b4e8b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_product_o_catalog_version_canonica_5cf7bf5c ON product_offer_studio.catalog_version (canonical_id);
CREATE INDEX IF NOT EXISTS ix_product_o_catalog_version_status_f087da5f ON product_offer_studio.catalog_version (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_product_o_catalog_version_updated_0a77c406 ON product_offer_studio.catalog_version (updated_at);
CREATE INDEX IF NOT EXISTS ix_product_o_catalog_version_source_3c823bb2 ON product_offer_studio.catalog_version (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_product_o_catalog_version_attrgin_609f7a20 ON product_offer_studio.catalog_version USING gin (attributes);
COMMENT ON TABLE product_offer_studio.catalog_version IS 'Starter table for Product And Offer Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN product_offer_studio.catalog_version.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN product_offer_studio.catalog_version.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN product_offer_studio.catalog_version.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS product_offer_studio.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_product_o_event_outbox_status_17fbf53d CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_product_o_event_outbox_publish_b21b879c ON product_offer_studio.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_product_o_event_outbox_eventkey_2d7983f7 ON product_offer_studio.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_product_o_event_outbox_agg_5de97f93 ON product_offer_studio.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE product_offer_studio.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS marketing_journey.segment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_segment_canonica_d2d25f15 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_segment_version_c19c3916 CHECK (version > 0),
    CONSTRAINT ck_marketing_segment_validity_202d6b70 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_segment_canonica_68ebb1a4 ON marketing_journey.segment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_segment_status_f126557d ON marketing_journey.segment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_segment_updated_a0bfc5aa ON marketing_journey.segment (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_segment_source_f7d391f2 ON marketing_journey.segment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_segment_attrgin_84f3b7c6 ON marketing_journey.segment USING gin (attributes);
COMMENT ON TABLE marketing_journey.segment IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.segment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.segment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.segment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.audience_snapshot (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_audience_snapshot_canonica_3a1d5a5f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_audience_snapshot_version_1cfbb612 CHECK (version > 0),
    CONSTRAINT ck_marketing_audience_snapshot_validity_61cca861 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_audience_snapshot_canonica_2ce8f853 ON marketing_journey.audience_snapshot (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_audience_snapshot_status_9d63c3a3 ON marketing_journey.audience_snapshot (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_audience_snapshot_updated_3f3d8a3b ON marketing_journey.audience_snapshot (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_audience_snapshot_source_404683c4 ON marketing_journey.audience_snapshot (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_audience_snapshot_attrgin_d6df5148 ON marketing_journey.audience_snapshot USING gin (attributes);
COMMENT ON TABLE marketing_journey.audience_snapshot IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.audience_snapshot.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.audience_snapshot.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.audience_snapshot.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.campaign (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_campaign_canonica_772be2c9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_campaign_version_3043e78a CHECK (version > 0),
    CONSTRAINT ck_marketing_campaign_validity_a95af7a9 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_campaign_canonica_a256f39d ON marketing_journey.campaign (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_status_c546639c ON marketing_journey.campaign (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_updated_e2dcca77 ON marketing_journey.campaign (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_source_2694557b ON marketing_journey.campaign (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_attrgin_e40a67a9 ON marketing_journey.campaign USING gin (attributes);
COMMENT ON TABLE marketing_journey.campaign IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.campaign.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.campaign.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.campaign.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.journey_definition (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_journey_definition_canonica_67c03e4b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_journey_definition_version_dc266ba1 CHECK (version > 0),
    CONSTRAINT ck_marketing_journey_definition_validity_c7a70c42 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_journey_definition_canonica_60e89ec3 ON marketing_journey.journey_definition (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_journey_definition_status_f7913154 ON marketing_journey.journey_definition (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_journey_definition_updated_8cce2014 ON marketing_journey.journey_definition (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_journey_definition_source_bc200512 ON marketing_journey.journey_definition (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_journey_definition_attrgin_3cf11f7c ON marketing_journey.journey_definition USING gin (attributes);
COMMENT ON TABLE marketing_journey.journey_definition IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.journey_definition.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.journey_definition.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.journey_definition.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.journey_state (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_journey_state_canonica_8e35c9f0 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_journey_state_version_6bf2f34a CHECK (version > 0),
    CONSTRAINT ck_marketing_journey_state_validity_4da7946c CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_journey_state_canonica_e6ada2ed ON marketing_journey.journey_state (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_journey_state_status_3654db73 ON marketing_journey.journey_state (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_journey_state_updated_df2f7abd ON marketing_journey.journey_state (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_journey_state_source_23cdd905 ON marketing_journey.journey_state (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_journey_state_attrgin_ea021231 ON marketing_journey.journey_state USING gin (attributes);
COMMENT ON TABLE marketing_journey.journey_state IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.journey_state.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.journey_state.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.journey_state.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.treatment_decision (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_treatment_decision_canonica_e72f2ceb UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_treatment_decision_version_42c9ed02 CHECK (version > 0),
    CONSTRAINT ck_marketing_treatment_decision_validity_e6245ca5 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_treatment_decision_canonica_9f2351bf ON marketing_journey.treatment_decision (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_treatment_decision_status_1d5150b8 ON marketing_journey.treatment_decision (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_treatment_decision_updated_d3e5dff0 ON marketing_journey.treatment_decision (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_treatment_decision_source_85335231 ON marketing_journey.treatment_decision (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_treatment_decision_attrgin_56a107be ON marketing_journey.treatment_decision USING gin (attributes);
COMMENT ON TABLE marketing_journey.treatment_decision IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.treatment_decision.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.treatment_decision.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.treatment_decision.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.contact_policy_decision (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_contact_policy_decision_canonica_5a5729ac UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_contact_policy_decision_version_d99b1fd1 CHECK (version > 0),
    CONSTRAINT ck_marketing_contact_policy_decision_validity_bcbb6320 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_contact_policy_decision_canonica_f8d50fa8 ON marketing_journey.contact_policy_decision (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_contact_policy_decision_status_5aac9d17 ON marketing_journey.contact_policy_decision (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_contact_policy_decision_updated_f60de9e0 ON marketing_journey.contact_policy_decision (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_contact_policy_decision_source_8ca40d02 ON marketing_journey.contact_policy_decision (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_contact_policy_decision_attrgin_6a251020 ON marketing_journey.contact_policy_decision USING gin (attributes);
COMMENT ON TABLE marketing_journey.contact_policy_decision IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.contact_policy_decision.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.contact_policy_decision.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.contact_policy_decision.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.campaign_performance_snapshot (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_marketing_campaign_performance_snaps_canonica_594286f7 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_marketing_campaign_performance_snaps_version_9ab9933c CHECK (version > 0),
    CONSTRAINT ck_marketing_campaign_performance_snaps_validity_a8003bf1 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_marketing_campaign_performance_snaps_canonica_02966403 ON marketing_journey.campaign_performance_snapshot (canonical_id);
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_performance_snaps_status_668bd805 ON marketing_journey.campaign_performance_snapshot (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_performance_snaps_updated_e203d067 ON marketing_journey.campaign_performance_snapshot (updated_at);
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_performance_snaps_source_c85efbfb ON marketing_journey.campaign_performance_snapshot (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_marketing_campaign_performance_snaps_attrgin_a8abab8b ON marketing_journey.campaign_performance_snapshot USING gin (attributes);
COMMENT ON TABLE marketing_journey.campaign_performance_snapshot IS 'Starter table for Marketing, Campaign, And Customer Journey. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN marketing_journey.campaign_performance_snapshot.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN marketing_journey.campaign_performance_snapshot.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN marketing_journey.campaign_performance_snapshot.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS marketing_journey.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_marketing_event_outbox_status_438fdccd CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_marketing_event_outbox_publish_e81dab1f ON marketing_journey.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_marketing_event_outbox_eventkey_7eaac286 ON marketing_journey.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_marketing_event_outbox_agg_fb4e6e24 ON marketing_journey.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE marketing_journey.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.sales_opportunity (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_sales_opportunity_canonica_024124cf UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_sales_opportunity_version_a2746971 CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_sales_opportunity_validity_44881437 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_sales_opportunity_canonica_99fdd9c7 ON sales_cpq_cart.sales_opportunity (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_sales_opportunity_status_cc95865d ON sales_cpq_cart.sales_opportunity (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_sales_opportunity_updated_c466a146 ON sales_cpq_cart.sales_opportunity (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_sales_opportunity_source_95e69ce5 ON sales_cpq_cart.sales_opportunity (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_sales_opportunity_attrgin_6ee9076e ON sales_cpq_cart.sales_opportunity USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.sales_opportunity IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.sales_opportunity.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.sales_opportunity.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.sales_opportunity.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.channel_attribution (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_channel_attribution_canonica_9b88681b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_channel_attribution_version_ca49e830 CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_channel_attribution_validity_f8d3f58c CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_channel_attribution_canonica_929a4189 ON sales_cpq_cart.channel_attribution (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_channel_attribution_status_33ad4fe1 ON sales_cpq_cart.channel_attribution (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_channel_attribution_updated_41b43449 ON sales_cpq_cart.channel_attribution (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_channel_attribution_source_8117855e ON sales_cpq_cart.channel_attribution (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_channel_attribution_attrgin_d3515cb3 ON sales_cpq_cart.channel_attribution USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.channel_attribution IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.channel_attribution.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.channel_attribution.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.channel_attribution.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.commission_trigger_context (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_commission_trigger_context_canonica_0b637ca4 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_commission_trigger_context_version_627505ab CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_commission_trigger_context_validity_73d9550c CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_commission_trigger_context_canonica_d4c92d44 ON sales_cpq_cart.commission_trigger_context (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_commission_trigger_context_status_c13de4c3 ON sales_cpq_cart.commission_trigger_context (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_commission_trigger_context_updated_0a24e164 ON sales_cpq_cart.commission_trigger_context (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_commission_trigger_context_source_453792b3 ON sales_cpq_cart.commission_trigger_context (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_commission_trigger_context_attrgin_2f80d5e8 ON sales_cpq_cart.commission_trigger_context USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.commission_trigger_context IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.commission_trigger_context.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.commission_trigger_context.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.commission_trigger_context.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.offering_qualification (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_offering_qualification_canonica_3c7e9ddc UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_offering_qualification_version_c5e15bd3 CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_offering_qualification_validity_dbe96a72 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_offering_qualification_canonica_f410cec7 ON sales_cpq_cart.offering_qualification (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_offering_qualification_status_342d1069 ON sales_cpq_cart.offering_qualification (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_offering_qualification_updated_9b0815f6 ON sales_cpq_cart.offering_qualification (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_offering_qualification_source_2b5d8032 ON sales_cpq_cart.offering_qualification (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_offering_qualification_attrgin_7b73b426 ON sales_cpq_cart.offering_qualification USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.offering_qualification IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.offering_qualification.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.offering_qualification.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.offering_qualification.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.recommendation_usage (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_recommendation_usage_canonica_68de10c8 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_recommendation_usage_version_b0305fdf CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_recommendation_usage_validity_aeb275c9 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_recommendation_usage_canonica_19e4df5b ON sales_cpq_cart.recommendation_usage (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_recommendation_usage_status_f43d3eb4 ON sales_cpq_cart.recommendation_usage (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_recommendation_usage_updated_98f805f8 ON sales_cpq_cart.recommendation_usage (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_recommendation_usage_source_ef971384 ON sales_cpq_cart.recommendation_usage (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_recommendation_usage_attrgin_4d0ea326 ON sales_cpq_cart.recommendation_usage USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.recommendation_usage IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.recommendation_usage.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.recommendation_usage.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.recommendation_usage.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.quote (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_quote_canonica_686af89b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_quote_version_e9d100b6 CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_quote_validity_d6938855 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_canonica_12a3a189 ON sales_cpq_cart.quote (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_status_60fbcef5 ON sales_cpq_cart.quote (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_updated_fa010a88 ON sales_cpq_cart.quote (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_source_39061e16 ON sales_cpq_cart.quote (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_attrgin_4899cc9a ON sales_cpq_cart.quote USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.quote IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.quote.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.quote.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.quote.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.quote_item_snapshot (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_quote_item_snapshot_canonica_cf85111f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_quote_item_snapshot_version_640ef194 CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_quote_item_snapshot_validity_31404873 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_item_snapshot_canonica_530ac133 ON sales_cpq_cart.quote_item_snapshot (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_item_snapshot_status_8643fa62 ON sales_cpq_cart.quote_item_snapshot (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_item_snapshot_updated_1c87287b ON sales_cpq_cart.quote_item_snapshot (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_item_snapshot_source_3df3dfdd ON sales_cpq_cart.quote_item_snapshot (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_quote_item_snapshot_attrgin_ac513ee3 ON sales_cpq_cart.quote_item_snapshot USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.quote_item_snapshot IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.quote_item_snapshot.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.quote_item_snapshot.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.quote_item_snapshot.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.shopping_cart (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_shopping_cart_canonica_33f0971c UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_shopping_cart_version_0863fdd9 CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_shopping_cart_validity_3b45c46d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_shopping_cart_canonica_849d0256 ON sales_cpq_cart.shopping_cart (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_shopping_cart_status_82ce6e9c ON sales_cpq_cart.shopping_cart (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_shopping_cart_updated_0c479c47 ON sales_cpq_cart.shopping_cart (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_shopping_cart_source_26355bde ON sales_cpq_cart.shopping_cart (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_shopping_cart_attrgin_8b8df019 ON sales_cpq_cart.shopping_cart USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.shopping_cart IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.shopping_cart.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.shopping_cart.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.shopping_cart.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.cart_item_snapshot (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_sales_cpq_cart_item_snapshot_canonica_17ed3abd UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_sales_cpq_cart_item_snapshot_version_b68ccfbe CHECK (version > 0),
    CONSTRAINT ck_sales_cpq_cart_item_snapshot_validity_6d87d7fd CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_cart_item_snapshot_canonica_82b5b6df ON sales_cpq_cart.cart_item_snapshot (canonical_id);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_cart_item_snapshot_status_cf07a0de ON sales_cpq_cart.cart_item_snapshot (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_cart_item_snapshot_updated_2626b491 ON sales_cpq_cart.cart_item_snapshot (updated_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_cart_item_snapshot_source_d91aeb28 ON sales_cpq_cart.cart_item_snapshot (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_sales_cpq_cart_item_snapshot_attrgin_5c52d08c ON sales_cpq_cart.cart_item_snapshot USING gin (attributes);
COMMENT ON TABLE sales_cpq_cart.cart_item_snapshot IS 'Starter table for Sales, CPQ, And Cart. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN sales_cpq_cart.cart_item_snapshot.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN sales_cpq_cart.cart_item_snapshot.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN sales_cpq_cart.cart_item_snapshot.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS sales_cpq_cart.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_sales_cpq_event_outbox_status_7fc857e2 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_sales_cpq_event_outbox_publish_f0ec800d ON sales_cpq_cart.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_event_outbox_eventkey_bce2370c ON sales_cpq_cart.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_sales_cpq_event_outbox_agg_8304cbe5 ON sales_cpq_cart.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE sales_cpq_cart.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS order_management_hub.product_order (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_order_man_product_order_canonica_251660d3 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_order_man_product_order_version_87c17ea3 CHECK (version > 0),
    CONSTRAINT ck_order_man_product_order_validity_fae38ded CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_order_man_product_order_canonica_941d0fd6 ON order_management_hub.product_order (canonical_id);
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_status_7845c191 ON order_management_hub.product_order (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_updated_a3a84e88 ON order_management_hub.product_order (updated_at);
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_source_75c35e67 ON order_management_hub.product_order (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_attrgin_c87f1f08 ON order_management_hub.product_order USING gin (attributes);
COMMENT ON TABLE order_management_hub.product_order IS 'Starter table for Order Management Hub. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN order_management_hub.product_order.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN order_management_hub.product_order.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN order_management_hub.product_order.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS order_management_hub.product_order_item (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_order_man_product_order_item_canonica_e70cf046 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_order_man_product_order_item_version_e8271f51 CHECK (version > 0),
    CONSTRAINT ck_order_man_product_order_item_validity_aa3211c1 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_order_man_product_order_item_canonica_032e430b ON order_management_hub.product_order_item (canonical_id);
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_item_status_0aaf7c45 ON order_management_hub.product_order_item (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_item_updated_00cd916a ON order_management_hub.product_order_item (updated_at);
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_item_source_9f250bf7 ON order_management_hub.product_order_item (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_order_man_product_order_item_attrgin_ab1e3543 ON order_management_hub.product_order_item USING gin (attributes);
COMMENT ON TABLE order_management_hub.product_order_item IS 'Starter table for Order Management Hub. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN order_management_hub.product_order_item.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN order_management_hub.product_order_item.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN order_management_hub.product_order_item.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS order_management_hub.order_decomposition_plan (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_order_man_order_decomposition_plan_canonica_ef7dd2b8 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_order_man_order_decomposition_plan_version_256d0724 CHECK (version > 0),
    CONSTRAINT ck_order_man_order_decomposition_plan_validity_8ca33839 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_order_man_order_decomposition_plan_canonica_f4f1ea2a ON order_management_hub.order_decomposition_plan (canonical_id);
CREATE INDEX IF NOT EXISTS ix_order_man_order_decomposition_plan_status_563a30c3 ON order_management_hub.order_decomposition_plan (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_order_man_order_decomposition_plan_updated_98050fc9 ON order_management_hub.order_decomposition_plan (updated_at);
CREATE INDEX IF NOT EXISTS ix_order_man_order_decomposition_plan_source_d0c3b87c ON order_management_hub.order_decomposition_plan (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_order_man_order_decomposition_plan_attrgin_d88ba185 ON order_management_hub.order_decomposition_plan USING gin (attributes);
COMMENT ON TABLE order_management_hub.order_decomposition_plan IS 'Starter table for Order Management Hub. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN order_management_hub.order_decomposition_plan.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN order_management_hub.order_decomposition_plan.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN order_management_hub.order_decomposition_plan.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS order_management_hub.order_jeopardy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_order_man_order_jeopardy_canonica_2f96585b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_order_man_order_jeopardy_version_3e1e0cdf CHECK (version > 0),
    CONSTRAINT ck_order_man_order_jeopardy_validity_d626fb48 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_order_man_order_jeopardy_canonica_a2af8a7b ON order_management_hub.order_jeopardy (canonical_id);
CREATE INDEX IF NOT EXISTS ix_order_man_order_jeopardy_status_1211f10c ON order_management_hub.order_jeopardy (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_order_man_order_jeopardy_updated_2a0407bb ON order_management_hub.order_jeopardy (updated_at);
CREATE INDEX IF NOT EXISTS ix_order_man_order_jeopardy_source_e26aab63 ON order_management_hub.order_jeopardy (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_order_man_order_jeopardy_attrgin_b21f4669 ON order_management_hub.order_jeopardy USING gin (attributes);
COMMENT ON TABLE order_management_hub.order_jeopardy IS 'Starter table for Order Management Hub. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN order_management_hub.order_jeopardy.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN order_management_hub.order_jeopardy.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN order_management_hub.order_jeopardy.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS order_management_hub.order_fallout (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_order_man_order_fallout_canonica_e7384ee6 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_order_man_order_fallout_version_3d9a062a CHECK (version > 0),
    CONSTRAINT ck_order_man_order_fallout_validity_9388d1fc CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_order_man_order_fallout_canonica_d92df6a4 ON order_management_hub.order_fallout (canonical_id);
CREATE INDEX IF NOT EXISTS ix_order_man_order_fallout_status_c5821a44 ON order_management_hub.order_fallout (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_order_man_order_fallout_updated_deb5f942 ON order_management_hub.order_fallout (updated_at);
CREATE INDEX IF NOT EXISTS ix_order_man_order_fallout_source_aeb223f7 ON order_management_hub.order_fallout (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_order_man_order_fallout_attrgin_b945c57a ON order_management_hub.order_fallout USING gin (attributes);
COMMENT ON TABLE order_management_hub.order_fallout IS 'Starter table for Order Management Hub. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN order_management_hub.order_fallout.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN order_management_hub.order_fallout.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN order_management_hub.order_fallout.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS order_management_hub.order_reference_snapshot (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_order_man_order_reference_snapshot_canonica_fa1a015e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_order_man_order_reference_snapshot_version_b8fc1b7b CHECK (version > 0),
    CONSTRAINT ck_order_man_order_reference_snapshot_validity_b7e6b044 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_order_man_order_reference_snapshot_canonica_2b905722 ON order_management_hub.order_reference_snapshot (canonical_id);
CREATE INDEX IF NOT EXISTS ix_order_man_order_reference_snapshot_status_da749761 ON order_management_hub.order_reference_snapshot (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_order_man_order_reference_snapshot_updated_a9b9e811 ON order_management_hub.order_reference_snapshot (updated_at);
CREATE INDEX IF NOT EXISTS ix_order_man_order_reference_snapshot_source_8f72ff65 ON order_management_hub.order_reference_snapshot (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_order_man_order_reference_snapshot_attrgin_9527174a ON order_management_hub.order_reference_snapshot USING gin (attributes);
COMMENT ON TABLE order_management_hub.order_reference_snapshot IS 'Starter table for Order Management Hub. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN order_management_hub.order_reference_snapshot.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN order_management_hub.order_reference_snapshot.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN order_management_hub.order_reference_snapshot.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS order_management_hub.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_order_man_event_outbox_status_58f8838f CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_order_man_event_outbox_publish_b189304d ON order_management_hub.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_order_man_event_outbox_eventkey_54fe03df ON order_management_hub.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_order_man_event_outbox_agg_ea934b9a ON order_management_hub.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE order_management_hub.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS billing_payments.billing_account_operation (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_billing_account_operation_canonica_4972ca68 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_billing_account_operation_version_3ac78079 CHECK (version > 0),
    CONSTRAINT ck_billing_p_billing_account_operation_validity_5055ee9b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_billing_account_operation_canonica_19a35827 ON billing_payments.billing_account_operation (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_account_operation_status_7c1ec7fe ON billing_payments.billing_account_operation (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_account_operation_updated_cf27d40f ON billing_payments.billing_account_operation (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_account_operation_source_25cad14e ON billing_payments.billing_account_operation (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_account_operation_attrgin_43736769 ON billing_payments.billing_account_operation USING gin (attributes);
COMMENT ON TABLE billing_payments.billing_account_operation IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.billing_account_operation.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.billing_account_operation.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.billing_account_operation.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.bill_cycle (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_bill_cycle_canonica_0a59f2b7 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_bill_cycle_version_a00717ff CHECK (version > 0),
    CONSTRAINT ck_billing_p_bill_cycle_validity_7d08289a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_bill_cycle_canonica_e0696ee7 ON billing_payments.bill_cycle (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_cycle_status_2522c9d8 ON billing_payments.bill_cycle (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_cycle_updated_ffe53ef4 ON billing_payments.bill_cycle (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_cycle_source_201b388b ON billing_payments.bill_cycle (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_cycle_attrgin_440a5dfc ON billing_payments.bill_cycle USING gin (attributes);
COMMENT ON TABLE billing_payments.bill_cycle IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.bill_cycle.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.bill_cycle.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.bill_cycle.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.customer_bill (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_customer_bill_canonica_cacd70d4 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_customer_bill_version_65d48af2 CHECK (version > 0),
    CONSTRAINT ck_billing_p_customer_bill_validity_331498ba CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_customer_bill_canonica_0e7f3b99 ON billing_payments.customer_bill (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_customer_bill_status_da32ed8b ON billing_payments.customer_bill (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_customer_bill_updated_c10fcd5c ON billing_payments.customer_bill (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_customer_bill_source_87cdeebe ON billing_payments.customer_bill (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_customer_bill_attrgin_43b67fe8 ON billing_payments.customer_bill USING gin (attributes);
COMMENT ON TABLE billing_payments.customer_bill IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.customer_bill.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.customer_bill.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.customer_bill.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.bill_item (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_bill_item_canonica_abeaa233 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_bill_item_version_389f458c CHECK (version > 0),
    CONSTRAINT ck_billing_p_bill_item_validity_de812b76 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_bill_item_canonica_82cd2d54 ON billing_payments.bill_item (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_item_status_362fd864 ON billing_payments.bill_item (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_item_updated_fb81affd ON billing_payments.bill_item (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_item_source_02b5c009 ON billing_payments.bill_item (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_bill_item_attrgin_b0598082 ON billing_payments.bill_item USING gin (attributes);
COMMENT ON TABLE billing_payments.bill_item IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.bill_item.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.bill_item.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.bill_item.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.payment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_payment_canonica_d3f9b89f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_payment_version_2f442a99 CHECK (version > 0),
    CONSTRAINT ck_billing_p_payment_validity_3dee5fff CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_payment_canonica_83070eeb ON billing_payments.payment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_status_a6c63bc9 ON billing_payments.payment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_updated_1dc31f68 ON billing_payments.payment (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_source_fb2d4b26 ON billing_payments.payment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_attrgin_aeda6032 ON billing_payments.payment USING gin (attributes);
COMMENT ON TABLE billing_payments.payment IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.payment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.payment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.payment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.payment_allocation (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_payment_allocation_canonica_70312908 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_payment_allocation_version_a66c734c CHECK (version > 0),
    CONSTRAINT ck_billing_p_payment_allocation_validity_aef799ab CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_payment_allocation_canonica_2a221398 ON billing_payments.payment_allocation (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_allocation_status_6de65b8f ON billing_payments.payment_allocation (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_allocation_updated_b343e471 ON billing_payments.payment_allocation (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_allocation_source_8d5a428e ON billing_payments.payment_allocation (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_allocation_attrgin_470885ff ON billing_payments.payment_allocation USING gin (attributes);
COMMENT ON TABLE billing_payments.payment_allocation IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.payment_allocation.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.payment_allocation.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.payment_allocation.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.payment_method_reference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_payment_method_reference_canonica_0cb1611b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_payment_method_reference_version_23298e46 CHECK (version > 0),
    CONSTRAINT ck_billing_p_payment_method_reference_validity_1b628cba CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_payment_method_reference_canonica_69d93bd4 ON billing_payments.payment_method_reference (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_method_reference_status_a2e9d9e6 ON billing_payments.payment_method_reference (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_method_reference_updated_8e5dbc46 ON billing_payments.payment_method_reference (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_method_reference_source_6530c838 ON billing_payments.payment_method_reference (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_payment_method_reference_attrgin_2e99102d ON billing_payments.payment_method_reference USING gin (attributes);
COMMENT ON TABLE billing_payments.payment_method_reference IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.payment_method_reference.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.payment_method_reference.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.payment_method_reference.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.prepay_balance (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_prepay_balance_canonica_346d8094 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_prepay_balance_version_973b2512 CHECK (version > 0),
    CONSTRAINT ck_billing_p_prepay_balance_validity_4301a55b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_prepay_balance_canonica_801006a2 ON billing_payments.prepay_balance (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_prepay_balance_status_1819e7e3 ON billing_payments.prepay_balance (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_prepay_balance_updated_a8a985e2 ON billing_payments.prepay_balance (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_prepay_balance_source_e1acb659 ON billing_payments.prepay_balance (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_prepay_balance_attrgin_99c711aa ON billing_payments.prepay_balance USING gin (attributes);
COMMENT ON TABLE billing_payments.prepay_balance IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.prepay_balance.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.prepay_balance.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.prepay_balance.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.billing_adjustment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_billing_p_billing_adjustment_canonica_a8c6e246 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_billing_p_billing_adjustment_version_90171ab9 CHECK (version > 0),
    CONSTRAINT ck_billing_p_billing_adjustment_validity_e76c5390 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_billing_p_billing_adjustment_canonica_31fa3b5e ON billing_payments.billing_adjustment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_adjustment_status_06472ecc ON billing_payments.billing_adjustment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_adjustment_updated_3893581e ON billing_payments.billing_adjustment (updated_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_adjustment_source_3cf9a941 ON billing_payments.billing_adjustment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_billing_p_billing_adjustment_attrgin_8ca377ef ON billing_payments.billing_adjustment USING gin (attributes);
COMMENT ON TABLE billing_payments.billing_adjustment IS 'Starter table for Billing, Payments, And Account Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN billing_payments.billing_adjustment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN billing_payments.billing_adjustment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN billing_payments.billing_adjustment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS billing_payments.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_billing_p_event_outbox_status_76266965 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_billing_p_event_outbox_publish_a6ae2b29 ON billing_payments.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_event_outbox_eventkey_b0a64a62 ON billing_payments.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_billing_p_event_outbox_agg_be159769 ON billing_payments.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE billing_payments.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.credit_decision (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_credit_decision_canonica_d95b5413 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_credit_decision_version_23f3247c CHECK (version > 0),
    CONSTRAINT ck_credit_fr_credit_decision_validity_9a1ea2e5 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_credit_decision_canonica_5153a6e4 ON credit_fraud_collections.credit_decision (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_credit_decision_status_042983a1 ON credit_fraud_collections.credit_decision (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_credit_decision_updated_f9404662 ON credit_fraud_collections.credit_decision (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_credit_decision_source_6f5468f4 ON credit_fraud_collections.credit_decision (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_credit_decision_attrgin_1cf47a70 ON credit_fraud_collections.credit_decision USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.credit_decision IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.credit_decision.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.credit_decision.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.credit_decision.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.risk_exposure (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_risk_exposure_canonica_ff898963 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_risk_exposure_version_be2ce944 CHECK (version > 0),
    CONSTRAINT ck_credit_fr_risk_exposure_validity_117292f5 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_risk_exposure_canonica_94f4bd4e ON credit_fraud_collections.risk_exposure (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_risk_exposure_status_76d6a4a9 ON credit_fraud_collections.risk_exposure (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_risk_exposure_updated_46beee17 ON credit_fraud_collections.risk_exposure (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_risk_exposure_source_59e1a728 ON credit_fraud_collections.risk_exposure (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_risk_exposure_attrgin_4776d263 ON credit_fraud_collections.risk_exposure USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.risk_exposure IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.risk_exposure.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.risk_exposure.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.risk_exposure.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.fraud_case (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_fraud_case_canonica_f4b708fc UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_fraud_case_version_d5f43529 CHECK (version > 0),
    CONSTRAINT ck_credit_fr_fraud_case_validity_5a800cec CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_fraud_case_canonica_83c4fe1b ON credit_fraud_collections.fraud_case (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_fraud_case_status_8d9b3485 ON credit_fraud_collections.fraud_case (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_fraud_case_updated_ddee53ee ON credit_fraud_collections.fraud_case (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_fraud_case_source_28ad436c ON credit_fraud_collections.fraud_case (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_fraud_case_attrgin_c169b2a1 ON credit_fraud_collections.fraud_case USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.fraud_case IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.fraud_case.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.fraud_case.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.fraud_case.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.collections_case (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_collections_case_canonica_036279d8 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_collections_case_version_eabd1440 CHECK (version > 0),
    CONSTRAINT ck_credit_fr_collections_case_validity_c787055d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_collections_case_canonica_731a1896 ON credit_fraud_collections.collections_case (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_collections_case_status_01a61d0f ON credit_fraud_collections.collections_case (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_collections_case_updated_b565c9fa ON credit_fraud_collections.collections_case (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_collections_case_source_73134f0c ON credit_fraud_collections.collections_case (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_collections_case_attrgin_dbcfe522 ON credit_fraud_collections.collections_case USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.collections_case IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.collections_case.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.collections_case.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.collections_case.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.restriction_reconnection_decision (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_restriction_reconnection_d_canonica_760b9655 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_restriction_reconnection_d_version_7b8d0ca5 CHECK (version > 0),
    CONSTRAINT ck_credit_fr_restriction_reconnection_d_validity_4421571a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_restriction_reconnection_d_canonica_33af7dd9 ON credit_fraud_collections.restriction_reconnection_decision (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_restriction_reconnection_d_status_c5ab75e4 ON credit_fraud_collections.restriction_reconnection_decision (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_restriction_reconnection_d_updated_06a6083c ON credit_fraud_collections.restriction_reconnection_decision (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_restriction_reconnection_d_source_13e35c20 ON credit_fraud_collections.restriction_reconnection_decision (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_restriction_reconnection_d_attrgin_6dce3ec3 ON credit_fraud_collections.restriction_reconnection_decision USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.restriction_reconnection_decision IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.restriction_reconnection_decision.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.restriction_reconnection_decision.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.restriction_reconnection_decision.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.dispute_recovery_case (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_dispute_recovery_case_canonica_4a96449c UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_dispute_recovery_case_version_c4139f57 CHECK (version > 0),
    CONSTRAINT ck_credit_fr_dispute_recovery_case_validity_9c153844 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_dispute_recovery_case_canonica_7529c8b0 ON credit_fraud_collections.dispute_recovery_case (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_dispute_recovery_case_status_89953187 ON credit_fraud_collections.dispute_recovery_case (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_dispute_recovery_case_updated_7744210c ON credit_fraud_collections.dispute_recovery_case (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_dispute_recovery_case_source_873788c4 ON credit_fraud_collections.dispute_recovery_case (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_dispute_recovery_case_attrgin_611200b2 ON credit_fraud_collections.dispute_recovery_case USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.dispute_recovery_case IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.dispute_recovery_case.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.dispute_recovery_case.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.dispute_recovery_case.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.case_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_credit_fr_case_evidence_canonica_f6e6e435 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_credit_fr_case_evidence_version_f5e2a30a CHECK (version > 0),
    CONSTRAINT ck_credit_fr_case_evidence_validity_d42cb548 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_case_evidence_canonica_fc1a75a4 ON credit_fraud_collections.case_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_credit_fr_case_evidence_status_a64d0b9c ON credit_fraud_collections.case_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_credit_fr_case_evidence_updated_46f9107a ON credit_fraud_collections.case_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_case_evidence_source_409616bf ON credit_fraud_collections.case_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_credit_fr_case_evidence_attrgin_1d70d478 ON credit_fraud_collections.case_evidence USING gin (attributes);
COMMENT ON TABLE credit_fraud_collections.case_evidence IS 'Starter table for Credit, Fraud, And Collections. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN credit_fraud_collections.case_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN credit_fraud_collections.case_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN credit_fraud_collections.case_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS credit_fraud_collections.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_credit_fr_event_outbox_status_b35d0c2e CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_credit_fr_event_outbox_publish_e31fab28 ON credit_fraud_collections.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_event_outbox_eventkey_0bc79242 ON credit_fraud_collections.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_credit_fr_event_outbox_agg_81df9466 ON credit_fraud_collections.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE credit_fraud_collections.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.usage_ingestion_batch (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_usage_ingestion_batch_canonica_6198e6db UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_usage_ingestion_batch_version_e3019c89 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_usage_ingestion_batch_validity_18f01f13 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_usage_ingestion_batch_canonica_cf7cdb2c ON usage_revenue_settlement.usage_ingestion_batch (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_usage_ingestion_batch_status_4517b373 ON usage_revenue_settlement.usage_ingestion_batch (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_usage_ingestion_batch_updated_f60b0bd1 ON usage_revenue_settlement.usage_ingestion_batch (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_usage_ingestion_batch_source_3f815292 ON usage_revenue_settlement.usage_ingestion_batch (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_usage_ingestion_batch_attrgin_e7cb38fb ON usage_revenue_settlement.usage_ingestion_batch USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.usage_ingestion_batch IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.usage_ingestion_batch.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.usage_ingestion_batch.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.usage_ingestion_batch.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.mediation_exception (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_mediation_exception_canonica_4d2d3322 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_mediation_exception_version_4f0a7695 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_mediation_exception_validity_e284b868 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_mediation_exception_canonica_0fb27780 ON usage_revenue_settlement.mediation_exception (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_mediation_exception_status_0ef506a4 ON usage_revenue_settlement.mediation_exception (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_mediation_exception_updated_6155def8 ON usage_revenue_settlement.mediation_exception (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_mediation_exception_source_451c9fbb ON usage_revenue_settlement.mediation_exception (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_mediation_exception_attrgin_77fbeed9 ON usage_revenue_settlement.mediation_exception USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.mediation_exception IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.mediation_exception.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.mediation_exception.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.mediation_exception.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.cdr_transaction (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_cdr_transaction_canonica_0329ff3d UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_cdr_transaction_version_8ef8e928 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_cdr_transaction_validity_7a3d6224 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_cdr_transaction_canonica_3e4554a1 ON usage_revenue_settlement.cdr_transaction (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_cdr_transaction_status_cb19c176 ON usage_revenue_settlement.cdr_transaction (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_cdr_transaction_updated_b203eed6 ON usage_revenue_settlement.cdr_transaction (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_cdr_transaction_source_ce84c6f0 ON usage_revenue_settlement.cdr_transaction (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_cdr_transaction_attrgin_97874f7f ON usage_revenue_settlement.cdr_transaction USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.cdr_transaction IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.cdr_transaction.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.cdr_transaction.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.cdr_transaction.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.consumption_summary (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_consumption_summary_canonica_4d3973eb UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_consumption_summary_version_bb60a873 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_consumption_summary_validity_02df8e47 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_consumption_summary_canonica_0b0774dd ON usage_revenue_settlement.consumption_summary (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_consumption_summary_status_8aa862cf ON usage_revenue_settlement.consumption_summary (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_consumption_summary_updated_012b6d06 ON usage_revenue_settlement.consumption_summary (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_consumption_summary_source_4935452b ON usage_revenue_settlement.consumption_summary (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_consumption_summary_attrgin_72290c58 ON usage_revenue_settlement.consumption_summary USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.consumption_summary IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.consumption_summary.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.consumption_summary.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.consumption_summary.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.revenue_assurance_case (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_revenue_assurance_case_canonica_f86f90e5 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_revenue_assurance_case_version_c4574316 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_revenue_assurance_case_validity_160b57a7 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_assurance_case_canonica_1221f9cd ON usage_revenue_settlement.revenue_assurance_case (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_assurance_case_status_ce9ab16a ON usage_revenue_settlement.revenue_assurance_case (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_assurance_case_updated_281b8db4 ON usage_revenue_settlement.revenue_assurance_case (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_assurance_case_source_a7a72165 ON usage_revenue_settlement.revenue_assurance_case (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_assurance_case_attrgin_d1e3ac3c ON usage_revenue_settlement.revenue_assurance_case USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.revenue_assurance_case IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_assurance_case.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_assurance_case.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_assurance_case.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.revenue_sharing_model (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_revenue_sharing_model_canonica_d0f08cdc UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_revenue_sharing_model_version_02dd3ea2 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_revenue_sharing_model_validity_77612289 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_model_canonica_b7b97839 ON usage_revenue_settlement.revenue_sharing_model (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_model_status_47b3f4b4 ON usage_revenue_settlement.revenue_sharing_model (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_model_updated_c9e4ae75 ON usage_revenue_settlement.revenue_sharing_model (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_model_source_162323ee ON usage_revenue_settlement.revenue_sharing_model (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_model_attrgin_2c5ed605 ON usage_revenue_settlement.revenue_sharing_model USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.revenue_sharing_model IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_sharing_model.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_sharing_model.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_sharing_model.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.revenue_sharing_report (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_revenue_sharing_report_canonica_67e6a28e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_revenue_sharing_report_version_c7bb7020 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_revenue_sharing_report_validity_5399ffc3 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_report_canonica_4b631553 ON usage_revenue_settlement.revenue_sharing_report (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_report_status_c1e7182e ON usage_revenue_settlement.revenue_sharing_report (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_report_updated_8e5732b7 ON usage_revenue_settlement.revenue_sharing_report (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_report_source_b227e7ca ON usage_revenue_settlement.revenue_sharing_report (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_revenue_sharing_report_attrgin_ff989f13 ON usage_revenue_settlement.revenue_sharing_report USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.revenue_sharing_report IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_sharing_report.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_sharing_report.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.revenue_sharing_report.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.roaming_interconnect_settlement_exception (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_usage_rev_roaming_interconnect_settl_canonica_152e8b1f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_usage_rev_roaming_interconnect_settl_version_af42c185 CHECK (version > 0),
    CONSTRAINT ck_usage_rev_roaming_interconnect_settl_validity_53fe64d8 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_roaming_interconnect_settl_canonica_d1ba01af ON usage_revenue_settlement.roaming_interconnect_settlement_exception (canonical_id);
CREATE INDEX IF NOT EXISTS ix_usage_rev_roaming_interconnect_settl_status_47befc2f ON usage_revenue_settlement.roaming_interconnect_settlement_exception (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_usage_rev_roaming_interconnect_settl_updated_5fc01e90 ON usage_revenue_settlement.roaming_interconnect_settlement_exception (updated_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_roaming_interconnect_settl_source_28b20157 ON usage_revenue_settlement.roaming_interconnect_settlement_exception (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_usage_rev_roaming_interconnect_settl_attrgin_8e7b021e ON usage_revenue_settlement.roaming_interconnect_settlement_exception USING gin (attributes);
COMMENT ON TABLE usage_revenue_settlement.roaming_interconnect_settlement_exception IS 'Starter table for Usage, Charging, And Revenue Settlement. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN usage_revenue_settlement.roaming_interconnect_settlement_exception.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN usage_revenue_settlement.roaming_interconnect_settlement_exception.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN usage_revenue_settlement.roaming_interconnect_settlement_exception.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS usage_revenue_settlement.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_usage_rev_event_outbox_status_5c7be26b CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_usage_rev_event_outbox_publish_8382ed17 ON usage_revenue_settlement.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_event_outbox_eventkey_8ccf9cc6 ON usage_revenue_settlement.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_usage_rev_event_outbox_agg_f107b26e ON usage_revenue_settlement.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE usage_revenue_settlement.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';


GRANT USAGE ON SCHEMA customer_party_360 TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA customer_party_360 TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA customer_party_360 TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA customer_party_360 GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA customer_party_360 GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA product_offer_studio TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA product_offer_studio TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA product_offer_studio TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA product_offer_studio GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA product_offer_studio GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA marketing_journey TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA marketing_journey TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA marketing_journey TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA marketing_journey GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA marketing_journey GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA sales_cpq_cart TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA sales_cpq_cart TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA sales_cpq_cart TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA sales_cpq_cart GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA sales_cpq_cart GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA order_management_hub TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA order_management_hub TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA order_management_hub TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA order_management_hub GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA order_management_hub GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA billing_payments TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA billing_payments TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA billing_payments TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA billing_payments GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA billing_payments GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA credit_fraud_collections TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA credit_fraud_collections TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA credit_fraud_collections TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA credit_fraud_collections GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA credit_fraud_collections GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA usage_revenue_settlement TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA usage_revenue_settlement TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA usage_revenue_settlement TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA usage_revenue_settlement GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA usage_revenue_settlement GRANT SELECT ON TABLES TO telcosuite_readonly;
