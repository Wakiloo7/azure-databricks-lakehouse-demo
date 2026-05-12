-- ============================================================
-- 02_create_gold_external_views.sql
-- Purpose:
-- Expose Databricks Gold-layer outputs through Synapse SQL views.
-- ============================================================

-- Gold Customers View
CREATE OR ALTER VIEW dbo.vw_gold_customers AS
SELECT
    customer_id,
    customer_name,
    region_id,
    customer_segment,
    created_date,
    updated_date
FROM
    OPENROWSET(
        BULK 'customers/',
        DATA_SOURCE = 'GoldLakehouseDataSource',
        FORMAT = 'PARQUET'
    ) AS customers;


-- Gold Products View
CREATE OR ALTER VIEW dbo.vw_gold_products AS
SELECT
    product_id,
    product_name,
    product_category,
    product_price,
    created_date,
    updated_date
FROM
    OPENROWSET(
        BULK 'products/',
        DATA_SOURCE = 'GoldLakehouseDataSource',
        FORMAT = 'PARQUET'
    ) AS products;


-- Gold Orders View
CREATE OR ALTER VIEW dbo.vw_gold_orders AS
SELECT
    order_id,
    customer_id,
    product_id,
    region_id,
    order_date,
    quantity,
    unit_price,
    total_amount
FROM
    OPENROWSET(
        BULK 'orders/',
        DATA_SOURCE = 'GoldLakehouseDataSource',
        FORMAT = 'PARQUET'
    ) AS orders;


-- Gold Regions View
CREATE OR ALTER VIEW dbo.vw_gold_regions AS
SELECT
    region_id,
    region_name,
    country,
    market
FROM
    OPENROWSET(
        BULK 'regions/',
        DATA_SOURCE = 'GoldLakehouseDataSource',
        FORMAT = 'PARQUET'
    ) AS regions;