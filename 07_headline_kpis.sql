SELECT
    COUNT(*)                                          AS total_orders,
    COUNT(DISTINCT customer_id)                       AS total_customers,
    SUM(order_value_inr)                              AS total_order_value,
    ROUND(AVG(order_value_inr), 2)                    AS avg_order_value,
    ROUND(AVG(delivery_time_min), 2)                  AS avg_delivery_min,
    ROUND(100 * AVG(is_delayed), 2)                   AS delay_rate_pct,
    ROUND(100 * (1 - AVG(is_delayed)), 2)             AS on_time_rate_pct,
    ROUND(AVG(service_rating), 2)                     AS avg_rating,
    ROUND(100 * AVG(rating_group = 'Positive'), 2)    AS positive_pct,
    ROUND(100 * AVG(rating_group = 'Negative'), 2)    AS negative_pct,
    ROUND(100 * AVG(is_refund), 2)                    AS refund_rate_pct,
    SUM(CASE WHEN is_refund = 1 THEN order_value_inr ELSE 0 END) AS refund_order_value
FROM quickcommerce.orders_clean;