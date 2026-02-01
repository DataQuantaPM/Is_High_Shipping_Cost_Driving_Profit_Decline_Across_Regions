

/*
=============================================================================
   Project  : Is High Shipping Cost Driving Profit Decline Across Regions?
   File     : 00_Data_Overview.sql
   Role     : Business Data Analyst
=============================================================================
*/


   
   





-- Table information
PRAGMA table_info(orders);
PRAGMA table_info(customers);
PRAGMA table_info(order_details);
PRAGMA table_info(categories);
PRAGMA table_info(locations);




-- Row count per table
SELECT COUNT(*) FROM orders;
SELECT COUNT(*) FROM order_details;
SELECT COUNT(*) FROM categories;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM locations;



-- Date range
SELECT
  MIN(order_date) AS min_date,
  MAX(order_date) AS max_date
FROM orders;



-- Ship mode type
SELECT DISTINCT ship_mode 
FROM orders;



-- Distinct countries
SELECT COUNT(DISTINCT country)
FROM locations;