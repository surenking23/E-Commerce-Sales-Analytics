
USE ecommerce_analytics;

-- 1. Overall Sales Performance
SELECT
    ROUND(SUM(net_sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders;


-- 2. Top 10 Products by Revenue
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(SUM(o.net_sales), 2) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;


-- 3. Top 10 Customers by Spending
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(o.net_sales), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 10;


-- 4. Sales by Region
SELECT
    region,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY region
ORDER BY revenue DESC;


-- 5. Sales by Payment Method
SELECT
    payment_method,
    ROUND(SUM(net_sales), 2) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY revenue DESC;


-- 6. Orders by Status
SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- 7. Monthly Sales
SELECT
    DATE_FORMAT(
        STR_TO_DATE(order_date, '%d-%m-%y'),
        '%Y-%m'
    ) AS sales_month,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM orders
GROUP BY sales_month
ORDER BY sales_month;


-- 8. Customer Count by Region
SELECT
    region,
    COUNT(DISTINCT customer_id) AS customers
FROM orders
GROUP BY region
ORDER BY customers DESC;


-- 9. Repeat vs One-Time Customers
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
) customer_orders
GROUP BY customer_type;


-- 10. Average Order Value
SELECT
    ROUND(
        SUM(net_sales) / COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM orders;


-- 11. Top 10 Customers by Profit
SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_profit DESC
LIMIT 10;


-- 12. Top 10 Products by Quantity Sold
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity) AS units_sold
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY units_sold DESC
LIMIT 10;


-- 13. Top 10 Products by Profit
SELECT
    p.product_id,
    p.product_name,
    p.category,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_profit DESC
LIMIT 10;


-- 14. Category Performance
SELECT
    p.category,
    SUM(o.quantity) AS units_sold,
    ROUND(SUM(o.net_sales), 2) AS revenue,
    ROUND(SUM(o.profit), 2) AS profit
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- 15. Discount Impact on Profit
SELECT
    discount_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM orders
GROUP BY discount_pct
ORDER BY discount_pct;


-- 16. Overall Business KPIs
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(net_sales), 2) AS total_revenue,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(
        (SUM(profit) / NULLIF(SUM(net_sales), 0)) * 100,
        2
    ) AS profit_margin_percentage
FROM orders;


-- 17. Best-Performing Region
SELECT
    region,
    ROUND(SUM(net_sales), 2) AS revenue
FROM orders
GROUP BY region
ORDER BY revenue DESC
LIMIT 1;


-- 18. Best-Selling Category
SELECT
    p.category,
    ROUND(SUM(o.net_sales), 2) AS revenue
FROM orders o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC
LIMIT 1;


-- 19. Order Status Performance
SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(net_sales), 2) AS revenue,
    ROUND(SUM(profit), 2) AS profit
FROM orders
GROUP BY order_status
ORDER BY revenue DESC;
