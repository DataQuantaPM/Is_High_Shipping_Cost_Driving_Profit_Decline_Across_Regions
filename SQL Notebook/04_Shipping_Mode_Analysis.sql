

/*
=============================================================================
   Project  : Is High Shipping Cost Driving Profit Decline Across Regions?
   File     : 04_Shipping_Mode_Analysis.sql
   Role     : Business Data Analyst
=============================================================================
*/





/*
   Tables Used:
   - orders
   - order_details
   - locations
   - Universal_Code (cleaned & joined dataset)
*/



/*
   Metric Definitions:
   - Total Profit       		= SUM(total_profit)
   - Total Sales        		= SUM(total_sales)
   - Shipping Cost 				= SUM(shipping_cost)
   - Order COunt				= COUNT(DISTINCT order_id)
   - Profit per Order			= SUM(total_profit) / COUNT(DISTINCT order_id)
   - Shipping Cost per Order	= SUM(shipping_cost) / COUNT(DISTINCT order_id)
*/



/*
 	Dimensions:
 	- Country 					= Country where the order is fulfilled
 	- Ship Mode					= Delivery method selected (Same Day, First Class, Second Class, Standard Class)
 */





/* =====================================================
   SECTION 8 — Shipping Cost per Order by Ship Mode
===================================================== */
With Bottom_3_Country AS (
  SELECT
    country
  FROM Universal_Code 
  GROUP BY country
  order BY SUM(total_profit) ASC 
  limit 3 
)
SELECT
  uc.ship_mode,
  uc.country,
  round(SUM(uc.shipping_cost) * 1.0 
  / COUNT(DISTINCT uc.order_id),1) AS shipping_cost_per_order
FROM Universal_Code  uc
JOIN bottom_3_country bc
  ON uc.country = bc.country
GROUP BY
  uc.ship_mode,
  uc.country
ORDER BY
  uc.ship_mode,
  uc.country

  
  
  

  
  
/* =====================================================
   SECTION 9 — Ship Mode Distribution by Country
===================================================== */
With Bottom_3_Country AS (
  SELECT
    country
  FROM Universal_Code 
  GROUP BY country
  order BY SUM(total_profit) ASC 
  limit 3 
)
SELECT
  uc.country,
  uc.ship_mode,
  count(distinct order_id)
FROM Universal_Code  uc
JOIN bottom_3_country bc
  ON uc.country = bc.country
GROUP BY
  uc.country,
  uc.ship_mode
ORDER BY
  uc.country,
  uc.ship_mode
  
  
  
  
  
  
  
/* =====================================================
   SECTION 10 — Profit per Order by Ship Mode
===================================================== */
with Bottom_3_Country AS (
  SELECT
    country
  FROM Universal_Code 
  GROUP BY country
  order BY SUM(total_profit) ASC 
  limit 3 
)
SELECT
  uc.country,
  uc.ship_mode,
  round(sum(uc.total_profit)/count(distinct uc.order_id),1) Profit_per_Order
FROM Universal_Code  uc
JOIN bottom_3_country bc
  ON uc.country = bc.country
GROUP BY
  uc.country,
  uc.ship_mode
ORDER BY
  uc.country,
  uc.ship_mode