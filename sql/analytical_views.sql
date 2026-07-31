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


CREATE OR REPLACE VIEW sales_state_map AS
SELECT
    state,
    SUM(amount) AS sales,
    CASE state
        WHEN 'Maharashtra' THEN 'IN-MH'
        WHEN 'Uttar Pradesh' THEN 'IN-UP'
        WHEN 'Punjab' THEN 'IN-PB'
        WHEN 'Madhya Pradesh' THEN 'IN-MP'
        WHEN 'Gujarat' THEN 'IN-GJ'
        WHEN 'Tamil Nadu' THEN 'IN-TN'
        WHEN 'Sikkim' THEN 'IN-SK'
        WHEN 'Bihar' THEN 'IN-BR'
        WHEN 'Delhi' THEN 'IN-DL'
        WHEN 'Jammu and Kashmir' THEN 'IN-JK'
        WHEN 'Andhra Pradesh' THEN 'IN-AP'
        WHEN 'Rajasthan' THEN 'IN-RJ'
        WHEN 'Haryana' THEN 'IN-HR'
        WHEN 'Karnataka' THEN 'IN-KA'
        WHEN 'West Bengal' THEN 'IN-WB'
        WHEN 'Nagaland' THEN 'IN-NL'
        WHEN 'Goa' THEN 'IN-GA'
        WHEN 'Himachal Pradesh' THEN 'IN-HP'
        WHEN 'Kerala' THEN 'IN-KL'
    END AS iso_code
FROM sales_analytics
GROUP BY state;

SELECT * FROM sales_state_map;


CREATE OR REPLACE VIEW target_vs_actual AS
SELECT
    year,
    month_num,
    month,
    category,
    SUM(amount) AS actual_sales,
    MAX(target) AS target,
    ROUND(SUM(amount) - MAX(target), 2) AS variance,
    ROUND((SUM(amount) / MAX(target)) * 100, 2) AS achievement_percentage
FROM sales_analytics
GROUP BY year, month_num, month, category;

SELECT * FROM target_vs_actual;