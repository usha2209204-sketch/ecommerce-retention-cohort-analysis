WITH category_summary AS (
    SELECT
        p.category,
        COUNT(DISTINCT oi.order_id) AS total_orders,
        ROUND(SUM(oi.line_total), 2) AS revenue,
        ROUND(AVG(oi.line_total), 2) AS avg_item_value,
        COUNT(DISTINCT o.customer_id) AS unique_customers
    FROM order_items oi
    JOIN orders o
      ON oi.order_id = o.order_id
    JOIN products p
      ON oi.product_id = p.product_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.category
)
SELECT *
FROM category_summary
ORDER BY revenue DESC;

SELECT
    p.product_name,
    p.category,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    ROUND(SUM(oi.line_total), 2) AS total_revenue,
    ROUND(AVG(oi.line_total), 2) AS avg_order_item_value
FROM order_items oi
JOIN orders o
  ON oi.order_id = o.order_id
JOIN products p
  ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 10;
