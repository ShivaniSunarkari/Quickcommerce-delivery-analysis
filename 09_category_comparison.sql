SELECT
    product_category,
    COUNT(*)                                       AS orders,
    SUM(order_value_inr)                           AS total_order_value,
    ROUND(100 * SUM(order_value_inr) / SUM(SUM(order_value_inr)) OVER (), 2) AS value_share_pct,
    RANK() OVER (ORDER BY SUM(order_value_inr) DESC) AS value_rank,
    ROUND(AVG(order_value_inr), 2)                 AS avg_order_value,
    ROUND(100 * AVG(is_delayed), 2)                AS delay_rate_pct,
    ROUND(AVG(service_rating), 2)                  AS avg_rating,
    ROUND(100 * AVG(is_refund), 2)                 AS refund_rate_pct,
    SUM(CASE WHEN is_refund = 1 THEN order_value_inr ELSE 0 END) AS refund_order_value
FROM quickcommerce.orders_clean
GROUP BY product_category
ORDER BY total_order_value DESC;