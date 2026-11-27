SELECT
    customer_feedback,
    service_rating,
    COUNT(*) AS orders
FROM quickcommerce.orders_raw
GROUP BY customer_feedback, service_rating
ORDER BY service_rating, orders DESC;