-- joining of orders and order details
USE growth_analytics;

SELECT * FROM sales_target;
SELECT * FROM order_details;
SELECT * FROM orders;


CREATE OR REPLACE VIEW sales_analytics AS
SELECT  o.order_id, 
        o.order_date, 
        o.customername, 
        o.state, o.city, 
        od.category, 
        od.sub_category, 
        od.quantity, 
        od.amount, 
        od.profit,
        YEAR(o.order_date) AS year,
        MONTHNAME(o.order_date) AS month,
        MONTH(o.order_date) AS month_num,
        QUARTER(o.order_date) AS quarter,
        DAY(o.order_date) AS day,
        ROUND((od.profit/od.amount) * 100, 2) AS profit_margin,
        st.target,
        (od.amount - st.target) AS variance,
        ROUND((od.amount/st.target) * 100, 2) AS achievement_percentage
FROM orders o 
JOIN order_details od
ON o.order_id = od.order_id


LEFT JOIN sales_target st
ON MONTH(st.month_of_order_date) = MONTH(o.order_date)
AND st.category = od.category;

SELECT * FROM sales_analytics;
