CREATE DATABASE quickcommerce;
SHOW DATABASES;
CREATE TABLE quickcommerce.orders_raw (
    order_id            VARCHAR(12) PRIMARY KEY,
    customer_id         VARCHAR(10),
    platform            VARCHAR(30),
    order_datetime_raw  VARCHAR(10),
    delivery_time_min   INT,
    product_category    VARCHAR(30),
    order_value_inr     INT,
    customer_feedback   VARCHAR(100),
    service_rating      TINYINT,
    delivery_delay      VARCHAR(3),
    refund_requested    VARCHAR(3)
);
DESCRIBE quickcommerce.orders_raw;