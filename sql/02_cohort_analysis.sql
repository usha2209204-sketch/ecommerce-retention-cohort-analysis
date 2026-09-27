WITH customer_months AS (
    SELECT
        c.customer_id,
        DATE_TRUNC('month', c.signup_date)::date AS cohort_month,
        DATE_TRUNC('month', MIN(o.order_date))::date AS first_order_month
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
       AND o.order_status = 'Completed'
    GROUP BY c.customer_id, c.signup_date
),
cohort_sizes AS (
    SELECT cohort_month, COUNT(*) AS cohort_size
    FROM customer_months
    GROUP BY cohort_month
),
retention AS (
    SELECT
        cm.cohort_month,
        EXTRACT(MONTH FROM AGE(cm.first_order_month, cm.cohort_month)) AS month_index,
        COUNT(*) AS retained_customers
    FROM customer_months cm
    GROUP BY cm.cohort_month, EXTRACT(MONTH FROM AGE(cm.first_order_month, cm.cohort_month))
)
SELECT
    r.cohort_month,
    r.month_index,
    r.retained_customers,
    cs.cohort_size,
    ROUND((r.retained_customers::numeric / cs.cohort_size) * 100, 2) AS retention_rate_pct
FROM retention r
JOIN cohort_sizes cs
    ON r.cohort_month = cs.cohort_month
ORDER BY r.cohort_month, r.month_index;
