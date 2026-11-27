SELECT
    COUNT(*)                          AS total_orders,
    COUNT(DISTINCT customer_id)       AS customers,
    ROUND(AVG(delivery_time_min), 2)  AS avg_delivery_min,
    ROUND(AVG(order_value_inr), 2)    AS avg_order_value,
    ROUND(AVG(service_rating), 2)     AS avg_rating
FROM quickcommerce.orders_raw;