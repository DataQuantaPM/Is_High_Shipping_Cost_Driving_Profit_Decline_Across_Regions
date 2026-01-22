---------------------
-- Data Quality Check
---------------------


-- Missing Value Checks
SELECT
  SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
  SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit,
  SUM(CASE WHEN order_details_id  IS NULL THEN 1 ELSE 0 END) AS missing_order_details_id,
  SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS missing_discount,
  SUM(CASE WHEN shipping_cost IS NULL THEN 1 ELSE 0 END) AS missing_shipping_cost
FROM order_details

SELECT 
  SUM(CASE WHEN order_id  IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
  SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
  SUM(CASE WHEN ship_mode IS NULL THEN 1 ELSE 0 END) AS missing_ship_mode
FROM orders

SELECT 
  SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
  SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name
FROM customers

SELECT
  SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS missing_name
FROM categories

SELECT 
  SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country
FROM locations




