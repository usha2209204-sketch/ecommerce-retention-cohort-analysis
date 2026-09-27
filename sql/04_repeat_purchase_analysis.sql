WITH repeat_customers AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND((SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END)::numeric / COUNT(*)) * 100, 2) AS repeat_purchase_rate_pct,
    ROUND(AVG(order_count), 2) AS avg_orders_per_customer
FROM repeat_customers;
