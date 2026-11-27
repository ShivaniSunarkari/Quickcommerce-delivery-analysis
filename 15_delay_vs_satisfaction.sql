SELECT
    delivery_band,
    COUNT(*)                                                 AS orders,
    ROUND(AVG(service_rating), 2)                            AS avg_rating,
    ROUND(100 * AVG(rating_group = 'Negative'), 2)           AS negative_pct,
    ROUND(100 * AVG(rating_group = 'Positive'), 2)           AS positive_pct,
    ROUND(100 * AVG(feedback_theme = 'Delivery Speed'), 2)   AS very_late_complaint_pct
FROM quickcommerce.orders_clean
GROUP BY delivery_band
ORDER BY MIN(delivery_time_min);

SELECT
    CASE WHEN is_delayed = 1 THEN 'Delayed (over 40)' ELSE 'On time (40 or less)' END AS delivery_status,
    COUNT(*)                                                 AS orders,
    SUM(feedback_theme = 'Delivery Speed')                   AS very_late_complaints,
    ROUND(100 * AVG(feedback_theme = 'Delivery Speed'), 2)   AS very_late_pct
FROM quickcommerce.orders_clean
GROUP BY is_delayed
ORDER BY is_delayed;