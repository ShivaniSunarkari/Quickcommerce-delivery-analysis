CREATE OR REPLACE VIEW quickcommerce.customer_summary AS
SELECT
    customer_id,
    COUNT(*)                          AS orders,
    SUM(order_value_inr)              AS total_spend,
    ROUND(AVG(service_rating), 2)     AS avg_rating,
    SUM(is_refund)                    AS refund_orders,
    NTILE(4) OVER (ORDER BY SUM(order_value_inr) DESC, customer_id) AS spend_quartile,
    CASE WHEN AVG(service_rating) < 3 THEN 'Unhappy (avg below 3)'
         WHEN AVG(service_rating) < 4 THEN 'Mixed (3 to 3.99)'
         ELSE 'Happy (4+)' END        AS experience
FROM quickcommerce.orders_clean
GROUP BY customer_id;
