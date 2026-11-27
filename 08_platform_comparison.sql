SELECT
    platform,
    COUNT(*)                                   AS orders,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS order_share_pct,
    SUM(order_value_inr)                       AS total_order_value,
    ROUND(AVG(order_value_inr), 2)             AS avg_order_value,
    ROUND(AVG(delivery_time_min), 2)           AS avg_delivery_min,
    ROUND(100 * AVG(is_delayed), 2)            AS delay_rate_pct,
    ROUND(AVG(service_rating), 2)              AS avg_rating,
    ROUND(100 * AVG(is_refund), 2)             AS refund_rate_pct
FROM quickcommerce.orders_clean
GROUP BY platform
ORDER BY orders DESC;