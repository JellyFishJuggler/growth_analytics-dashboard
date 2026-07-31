USE growth_analytics;

SELECT * FROM sales_analytics;


-- Overall Business Performance
SELECT  SUM(profit) AS total_profit, 
        SUM(amount) AS total_sales, 
        SUM(quantity) AS total_quantity
FROM sales_analytics;

-- monthly sales
SELECT
    year,
    month_num,
    month,
    SUM(amount) AS sales,
    SUM(profit) AS profit
FROM sales_analytics
GROUP BY year, month_num, month
ORDER BY year, month_num;

-- category performance
SELECT
    category,
    SUM(amount) AS sales,
    SUM(quantity) AS quantity,
    SUM(profit) AS profit
FROM sales_analytics
GROUP BY category
ORDER BY sales DESC;

-- sub category performance
SELECT
    sub_category,
    SUM(amount) AS sales,
    SUM(quantity) AS quantity,
    SUM(profit) AS profit
FROM sales_analytics
GROUP BY sub_category
ORDER BY sales DESC;

-- state wise sales
SELECT
    state,
    SUM(amount) AS sales,
    SUM(profit) AS profit
FROM sales_analytics
GROUP BY state
ORDER BY sales DESC;

-- top 10 customers
SELECT
    customername,
    SUM(amount) AS total_sales,
    SUM(profit) AS total_profit
FROM sales_analytics
GROUP BY customername
ORDER BY total_sales DESC
LIMIT 10;

-- loss making products
SELECT
    sub_category AS product_name,
    SUM(profit) AS total_loss
FROM sales_analytics
-- WHERE profit < 0
GROUP BY product_name
HAVING SUM(profit) < 0
ORDER BY total_loss ASC;


-- Target vs Actual
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
GROUP BY year, month_num, month, category
ORDER BY year, month_num;


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