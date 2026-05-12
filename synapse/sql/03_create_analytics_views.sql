-- ============================================================
-- 03_create_analytics_views.sql
-- Purpose:
-- Business-ready analytics views built on top of Gold views.
-- ============================================================

CREATE OR ALTER VIEW dbo.vw_sales_by_region AS
SELECT
    r.region_id,
    r.region_name,
    r.country,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_sales,
    AVG(o.total_amount) AS avg_order_value
FROM dbo.vw_gold_orders o
LEFT JOIN dbo.vw_gold_regions r
    ON o.region_id = r.region_id
GROUP BY
    r.region_id,
    r.region_name,
    r.country;


CREATE OR ALTER VIEW dbo.vw_customer_sales_summary AS
SELECT
    c.customer_id,
    c.customer_name,
    c.customer_segment,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value
FROM dbo.vw_gold_customers c
LEFT JOIN dbo.vw_gold_orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.customer_segment;


CREATE OR ALTER VIEW dbo.vw_product_sales_summary AS
SELECT
    p.product_id,
    p.product_name,
    p.product_category,
    COUNT(o.order_id) AS total_orders,
    SUM(o.quantity) AS total_quantity,
    SUM(o.total_amount) AS total_sales
FROM dbo.vw_gold_products p
LEFT JOIN dbo.vw_gold_orders o
    ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.product_category;