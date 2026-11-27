SELECT
    order_value_band,
    COUNT(*)                                          AS orders,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)  AS order_share_pct,
    SUM(is_refund)                                    AS refund_orders,
    ROUND(100 * AVG(is_refund), 2)                    AS refund_rate_pct,
    SUM(order_value_inr)                              AS total_order_value,
    SUM(CASE WHEN is_refund = 1 THEN order_value_inr ELSE 0 END) AS refund_order_value,
    ROUND(100 * SUM(CASE WHEN is_refund = 1 THEN order_value_inr ELSE 0 END)
          / SUM(SUM(CASE WHEN is_refund = 1 THEN order_value_inr ELSE 0 END)) OVER (), 2) AS refund_value_share_pct
FROM quickcommerce.orders_clean
GROUP BY order_value_band
ORDER BY MIN(order_value_inr);