SELECT
    c.customer_id,
    c.signup_date,
    MIN(o.order_date) AS first_order_date,
    MAX(o.order_date) AS last_order_date,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(COALESCE(SUM(o.total_amount), 0), 2) AS total_revenue,
    ROUND(COALESCE(AVG(o.total_amount), 0), 2) AS avg_order_value,
    CASE WHEN COUNT(DISTINCT o.order_id) > 1 THEN 1 ELSE 0 END AS repeat_customer,
    ROUND(COALESCE(SUM(o.total_amount), 0), 2) AS customer_lifetime_value
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
   AND o.order_status = 'Completed'
GROUP BY c.customer_id, c.signup_date
ORDER BY total_revenue DESC;
