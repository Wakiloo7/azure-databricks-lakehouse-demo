-- ============================================================
-- 01_create_external_data_source.sql
-- Purpose:
-- Create Synapse Serverless SQL external data source for
-- querying curated Gold-layer data stored in ADLS Gen2.
-- ============================================================

-- Replace placeholders before deployment:
-- <storage_account>
-- <container>

CREATE DATABASE SCOPED CREDENTIAL ManagedIdentityCredential
WITH IDENTITY = 'Managed Identity';

CREATE EXTERNAL DATA SOURCE GoldLakehouseDataSource
WITH (
    LOCATION = 'abfss://<container>@<storage_account>.dfs.core.windows.net/gold/',
    CREDENTIAL = ManagedIdentityCredential
);

-- File format for Parquet Gold outputs
CREATE EXTERNAL FILE FORMAT ParquetFileFormat
WITH (
    FORMAT_TYPE = PARQUET
);