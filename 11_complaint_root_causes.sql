SELECT
    feedback_theme,
    COUNT(*)                                          AS complaints,
    ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2)  AS pct_of_complaints,
    ROUND(100 * SUM(COUNT(*)) OVER (ORDER BY COUNT(*) DESC) / SUM(COUNT(*)) OVER (), 2) AS cumulative_pct,
    ROUND(AVG(order_value_inr), 2)                    AS avg_order_value,
    SUM(order_value_inr)                              AS refund_order_value,
    ROUND(100 * SUM(order_value_inr) / SUM(SUM(order_value_inr)) OVER (), 2) AS pct_of_refund_value
FROM quickcommerce.orders_clean
WHERE rating_group = 'Negative'
GROUP BY feedback_theme
ORDER BY complaints DESC;