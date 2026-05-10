-- Data quality checks for the Silver layer

-- 1. Check duplicate customer records
SELECT customer_id, COUNT(*) AS duplicate_count
FROM silver_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 2. Check orders without valid customers
SELECT o.order_id, o.customer_id
FROM silver_orders o
LEFT JOIN silver_customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- 3. Check orders with invalid amounts
SELECT *
FROM silver_orders
WHERE order_amount IS NULL
   OR order_amount <= 0;

-- 4. Check missing product references
SELECT o.order_id, o.product_id
FROM silver_orders o
LEFT JOIN silver_products p
    ON o.product_id = p.product_id
WHERE p.product_id IS NULL;