CREATE DATABASE growth_analytics;
USE growth_analytics;


CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    customername VARCHAR(60) NOT NULL,
    state VARCHAR(60) NOT NULL,
    city VARCHAR(60) NOT NULL
);

CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    profit DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    category VARCHAR(60) NOT NULL,
    sub_category VARCHAR(60) NOT NULL,

    CONSTRAINT fk_order FOREIGN KEY(order_id) REFERENCES orders(order_id)
);  

CREATE TABLE sales_target (
    target_id INT AUTO_INCREMENT PRIMARY KEY,
    month_of_order_date VARCHAR(20) NOT NULL,
    category VARCHAR(60) NOT NULL,
    target INT NOT NULL
);

SHOW TABLES;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM order_details;

SELECT COUNT(*) FROM sales_target;


SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM sales_target;