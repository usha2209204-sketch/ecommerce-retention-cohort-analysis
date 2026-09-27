WITH customer_metrics AS (
    SELECT
        c.customer_id,
        DATE_PART('day', CURRENT_DATE - MAX(o.order_date)) AS recency_days,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(COALESCE(SUM(o.total_amount), 0), 2) AS monetary
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
       AND o.order_status = 'Completed'
    GROUP BY c.customer_id
),
rfm_scores AS (
    SELECT
        customer_id,
        CASE
            WHEN recency_days <= 30 THEN 5
            WHEN recency_days <= 60 THEN 4
            WHEN recency_days <= 90 THEN 3
            WHEN recency_days <= 180 THEN 2
            ELSE 1
        END AS recency_score,
        CASE
            WHEN frequency >= 5 THEN 5
            WHEN frequency >= 3 THEN 4
            WHEN frequency >= 2 THEN 3
            WHEN frequency = 1 THEN 2
            ELSE 1
        END AS frequency_score,
        CASE
            WHEN monetary >= 500 THEN 5
            WHEN monetary >= 300 THEN 4
            WHEN monetary >= 150 THEN 3
            WHEN monetary >= 75 THEN 2
            ELSE 1
        END AS monetary_score
    FROM customer_metrics
)
SELECT
    customer_id,
    recency_score,
    frequency_score,
    monetary_score,
    (recency_score * 100) + (frequency_score * 10) + monetary_score AS rfm_score,
    CASE
        WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'Champions'
        WHEN recency_score >= 3 AND frequency_score >= 3 AND monetary_score >= 3 THEN 'Loyal Customers'
        WHEN recency_score >= 3 AND frequency_score >= 3 AND monetary_score < 3 THEN 'Potential Loyalists'
        WHEN recency_score >= 2 AND frequency_score < 3 THEN 'At Risk'
        WHEN recency_score >= 3 AND frequency_score = 1 THEN 'New Customers'
        ELSE 'Need Attention'
    END AS rfm_segment
FROM rfm_scores
ORDER BY (recency_score * 100) + (frequency_score * 10) + monetary_score DESC;
