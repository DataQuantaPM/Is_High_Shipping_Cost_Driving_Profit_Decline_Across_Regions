

/*
=============================================================================
   Project  : Is High Shipping Cost Driving Profit Decline Across Regions?
   File     : 03_Shipping_Cost_Analysis.sql
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
   - Order Count				= COUNT(DISTINCT order_id)
   - Total Cost					= SUM(total_sales) - SUM(total_profit)
   - Shipping Cost Ratio		= SUM(shipping_cost) / SUM(total_sales)
   - Shipping Cost per Order	= SUM(shipping_cost) / COUNT(Distinct order_id)
*/



/*
 	Dimensions:
 	- Country 					= Country where the order is fulfilled
*/






/* =====================================================
   SECTION 5 — Shipping Cost Ratio by Country
===================================================== */
Select country , round(sum(shipping_cost)/sum(total_sales),2) Shipping_Cost_Ratio
from Universal_Code 
group by country 
order BY round(sum(total_profit),0) asc
limit 3






/* =====================================================
   SECTION 6 — Shipping Cost per Order by Country
===================================================== */
Select country , round(sum(shipping_cost)/count(distinct order_id),2) Shipping_Cost_per_Order
from Universal_Code 
group by country 
order BY round(sum(total_profit),0) asc
limit 3





/* =====================================================
   SECTION 7 — Shipping Cost vs Profit
===================================================== */
Select country , round(sum(total_profit),0) Profit , round(sum(shipping_cost)/count(distinct order_id),2) Shipping_Cost_per_Order
from Universal_Code 
group by country 
order BY round(sum(total_profit),0) asc
limit 3




  
