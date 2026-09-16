USE ecommerce_analytics;

-- Sales Summary View
CREATE OR REPLACE VIEW sales_summary AS
SELECT
    order_date,
    region,
    payment_method,
    order_status,
    quantity,
    net_sales,
    profit
FROM orders;


-- Product Performance View
CREATE OR REPLACE VIEW product_performance AS
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity) AS units_sold,
    ROUND(SUM(o.net_sales), 2) AS revenue,
    ROUND(SUM(o.profit), 2) AS profit
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category;


-- Customer Performance View
CREATE OR REPLACE VIEW customer_performance AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.net_sales), 2) AS total_spent,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
