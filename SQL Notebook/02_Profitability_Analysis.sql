

/*
=============================================================================
   Project  : Is High Shipping Cost Driving Profit Decline Across Regions?
   File     : 02_Profitability_analysis.sql
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
   - Total Profit       = SUM(profit)
   - Total Sales        = SUM(sales)
   - Total Cost			= SUM(sales) - SUM(profit)
   - Profit Margin (%)  = SUM(Total Profit) / SUM(Total Sales)
   - Order Volume		= COUNT(order_id)
*/



/*
 	Dimensions:
 	- Country 					= Country where the order is fulfilled
 */






/* =====================================================
   SECTION 1 — Top & Bottom 5 Profit by Country
===================================================== */
with profit_by_country AS (
  SELECT
    country,
    round(SUM(total_profit),0) AS profit
  FROM Universal_Code
  GROUP BY country
)
SELECT *
FROM (
  -- TOP 5
  SELECT
    country, profit
  FROM profit_by_country
  ORDER BY profit DESC
  LIMIT 5
)
UNION ALL
SELECT *
FROM (
  -- BOTTOM 5
  SELECT
    country, profit
  FROM profit_by_country
  ORDER BY profit ASC
  LIMIT 5
)
ORDER BY profit DESC;








/* =========================================================
   SECTION 2 — Top & Bottom 5 Profit Margin by Country
========================================================= */
with profit_by_country AS (
  SELECT
    country,
    round(SUM(total_profit)*100.0/SUM(total_sales),1) AS margin
  FROM Universal_Code
  GROUP BY country
)
SELECT *
FROM (
  -- TOP 5
  SELECT
    country, margin
  FROM profit_by_country
  ORDER BY margin DESC
  LIMIT 5
)
UNION ALL
SELECT *
FROM (
  -- BOTTOM 5
  SELECT
    country, margin
  FROM profit_by_country
  ORDER BY margin ASC
  LIMIT 5
)
ORDER BY margin DESC;






/* =====================================================
   SECTION 3 — Revenue vs Total Cost
===================================================== */
SELECT country , round(sum(total_sales),0) sales , round(sum(total_sales)-sum(total_profit),0) Cost
from Universal_Code 
group by country 
order by round(sum(total_profit),0) asc
limit 3





/* =====================================================
   SECTION 4 — Profit vs Order Volume
===================================================== */
Select country , round(sum(total_profit),0) Profit , count(order_id) Order_Volume
from Universal_Code 
group by country 
order BY round(sum(total_profit),0) asc
limit 3




