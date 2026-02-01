

/*
=============================================================================
   Project  : Is High Shipping Cost Driving Profit Decline Across Regions?
   File     : 01_Data_Preparation.sql
   Role     : Business Data Analyst
=============================================================================
*/






-- Check for missing values in key numeric fields
SELECT
  SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
  SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit,
  SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS missing_discount,
  SUM(CASE WHEN shipping_cost IS NULL THEN 1 ELSE 0 END) AS missing_shipping_cost
FROM order_details od
--No missing values were found in key financial fields.

   
   
      
   

select count(order_id) , *
from orders o 
group by order_id
having count(order_id) > 1
order by count(order_id) desc
-- There are duplicate order_id's



select *
from orders
where order_id in ('IT-2014-1036058')
-- in the duplicate order_id, the other columns contain different data






SELECT LENGTH(customer_id), COUNT(*)
FROM customers
GROUP BY LENGTH(customer_id)
ORDER BY 1
-- Banyak nama customer yang double dan karakter customer_id yang tidak lengkap




select c.name , c.customer_id , c.location_id , l.country , l.city
from customers c 
join locations l 
on c.location_id = l.location_id 
WHERE c.name in ('Aaron Bergman') 
order by country , city
-- There are customers who have different data




select *
from categories c
-- there is a duplicate categories





------------------- BASE CODE  /  UNIVERSAL CODE -------------------



WITH valid_customer AS (
  SELECT
    customer_id,
    name,
    MIN(location_id) AS first_location_id
  FROM customers
  WHERE LENGTH(customer_id) = 8
  GROUP BY customer_id, name
),
customer_country_by_name AS (
  SELECT
    vc.name,
    l.country
  FROM valid_customer vc
  JOIN locations l
    ON vc.first_location_id = l.location_id 
),
dedup_orders AS (
  SELECT *
  FROM (
    SELECT
      o.*,
      ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY order_date ASC
      ) AS rn
    FROM orders o
  )
  WHERE rn = 1
),
base AS (
  SELECT
    od.order_details_id,
    o.order_id,
    o.customer_id,
    cu.name,
    c.name AS category,
    o.order_date,
    o.ship_mode, 
    od.profit,
    od.sales,
    od.discount,
    od.shipping_cost 
  FROM order_details od
  JOIN dedup_orders o
    ON od.order_id = o.order_id
  JOIN customers cu
    ON o.customer_id = cu.customer_id
  JOIN products p
    ON od.product_id = p.product_id 
  JOIN (
    SELECT DISTINCT category_id, name
    FROM categories
  ) c
    ON p.category_id = c.category_id
)
SELECT
  b.order_details_id,
  b.order_id,
  b.customer_id,
  b.name,
  b.category,
  CASE strftime('%m', b.order_date)
    WHEN '01' THEN 'Jan'
    WHEN '02' THEN 'Feb'
    WHEN '03' THEN 'Mar'
    WHEN '04' THEN 'Apr'
    WHEN '05' THEN 'May'
    WHEN '06' THEN 'Jun'
    WHEN '07' THEN 'Jul'
    WHEN '08' THEN 'Aug'
    WHEN '09' THEN 'Sep'
    WHEN '10' THEN 'Oct'
    WHEN '11' THEN 'Nov'
    WHEN '12' THEN 'Dec'
  END || ' ' || strftime('%Y', b.order_date) AS time_period,
  STRFTIME('%Y', b.order_date) AS Year,
  CASE STRFTIME('%m', b.order_date)
    WHEN '01' THEN 'January'
    WHEN '02' THEN 'February'
    WHEN '03' THEN 'March'
    WHEN '04' THEN 'April'
    WHEN '05' THEN 'May'
    WHEN '06' THEN 'June'
    WHEN '07' THEN 'July'
    WHEN '08' THEN 'August'
    WHEN '09' THEN 'September'
    WHEN '10' THEN 'October'
    WHEN '11' THEN 'November'
    WHEN '12' THEN 'December'
  END AS Month,
  ccn.country,
  b.ship_mode,
  b.profit AS total_profit,
  b.sales AS total_sales,
  b.discount,
  b.shipping_cost
FROM base b
LEFT JOIN customer_country_by_name ccn
  ON b.name = ccn.name
GROUP BY b.order_details_id
ORDER BY b.order_details_id
-- Final clean dataset




