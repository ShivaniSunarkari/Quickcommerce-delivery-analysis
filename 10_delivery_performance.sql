SELECT
    delivery_band,
    MIN(delivery_time_min)   AS from_min,
    MAX(delivery_time_min)   AS to_min,
    COUNT(*)                 AS orders,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS share_pct,
    ROUND(100 * SUM(COUNT(*)) OVER (ORDER BY MIN(delivery_time_min)) / SUM(COUNT(*)) OVER (), 2) AS cumulative_pct
FROM quickcommerce.orders_clean
GROUP BY delivery_band
ORDER BY from_min;

WITH ranked AS (
    SELECT
        delivery_time_min,
        ROW_NUMBER() OVER (ORDER BY delivery_time_min) AS rn,
        COUNT(*) OVER ()                               AS n
    FROM quickcommerce.orders_clean
)
SELECT
    MIN(CASE WHEN rn >= 0.50 * n THEN delivery_time_min END) AS median_min,
    MIN(CASE WHEN rn >= 0.90 * n THEN delivery_time_min END) AS p90_min,
    MIN(CASE WHEN rn >= 0.95 * n THEN delivery_time_min END) AS p95_min,
    MIN(CASE WHEN rn >= 0.99 * n THEN delivery_time_min END) AS p99_min,
    MAX(delivery_time_min)                                   AS slowest_min
FROM ranked;