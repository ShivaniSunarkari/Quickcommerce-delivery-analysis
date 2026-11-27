DROP TABLE IF EXISTS quickcommerce.orders_clean;
CREATE TABLE quickcommerce.orders_clean AS
SELECT
    order_id,
    customer_id,
    platform,
    product_category,
    delivery_time_min,
    order_value_inr,
    service_rating,
    customer_feedback,
    CASE WHEN delivery_delay = 'Yes' THEN 1 ELSE 0 END AS is_delayed,
    CASE WHEN refund_requested = 'Yes' THEN 1 ELSE 0 END AS is_refund,
    CASE WHEN service_rating <= 2 THEN 'Negative'
         WHEN service_rating = 3  THEN 'Neutral'
         ELSE 'Positive' END AS rating_group,
    CASE customer_feedback
        WHEN 'Wrong item delivered.'                      THEN 'Order Accuracy'
        WHEN 'Items missing from order.'                  THEN 'Order Accuracy'
        WHEN 'Not fresh, disappointed.'                   THEN 'Product Quality'
        WHEN 'Very late delivery, not happy.'             THEN 'Delivery Speed'
        WHEN 'Delivery person was rude.'                  THEN 'Delivery Staff'
        WHEN 'Packaging could be better.'                 THEN 'Packaging'
        WHEN 'Horrible experience, never ordering again.' THEN 'General Dissatisfaction'
        WHEN 'Good quality products.'                     THEN 'Positive Feedback'
        WHEN 'Easy to order, loved it!'                   THEN 'Positive Feedback'
        WHEN 'Excellent experience!'                      THEN 'Positive Feedback'
        WHEN 'Very satisfied with the service.'           THEN 'Positive Feedback'
        WHEN 'Fast delivery, great service!'              THEN 'Positive Feedback'
        WHEN 'Quick and reliable!'                        THEN 'Positive Feedback'
        ELSE 'Unclassified'
    END AS feedback_theme,
    CASE WHEN delivery_time_min <= 20 THEN 'Fast (up to 20)'
         WHEN delivery_time_min <= 30 THEN 'Normal (21-30)'
         WHEN delivery_time_min <= 40 THEN 'Slow (31-40)'
         ELSE 'Delayed (over 40)' END AS delivery_band,
    CASE WHEN order_value_inr < 300  THEN 'Low'
         WHEN order_value_inr < 700  THEN 'Medium'
         WHEN order_value_inr < 1200 THEN 'High'
         ELSE 'Premium' END AS order_value_band
FROM quickcommerce.orders_raw;
ALTER TABLE quickcommerce.orders_clean ADD PRIMARY KEY (order_id);
SHOW TABLES FROM quickcommerce;
SELECT COUNT(*) FROM quickcommerce.orders_clean;