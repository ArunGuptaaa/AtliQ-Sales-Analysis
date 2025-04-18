#1. As a product owner, I want to generate a report of individual product sales (aggregated on a monthly
	#basis at the product code level) for Croma India customer for FY=2021 so that I can track individual
	#product sales and run further product analytics on it in excel.

# The report should have the following fields,

-- 1. Month
-- 2. Product Name
-- 3. Variant
-- 4. Sold Quantity
-- 5. Gross Price Per Item
-- 6. Gross Price Total

-- a. first grab customer codes for Croma india
	SELECT * FROM dim_customer WHERE customer like "%croma%" AND market="india";

-- b. Get all the sales transaction data from fact_sales_monthly table for that customer(croma: 90002002) in the fiscal_year 2021
	SELECT * FROM fact_sales_monthly 
	WHERE 
            customer_code=90002002 AND
            YEAR(DATE_ADD(date, INTERVAL 4 MONTH))=2021 
	ORDER BY date asc;

-- c. Replacing the function created in the step:b
	SELECT * FROM fact_sales_monthly 
	WHERE 
            customer_code=90002002 AND
            get_fiscal_year(date)=2021 
	ORDER BY date asc
	LIMIT 100000;

# --------------------------------------------------------------------------------------------------------
# 2. # agrregate monthly gross sales report for croma india customer so that i can track how much sales 
		#this particular customer is generating for Atliq and manage our relationships accordingly.
# The report should have the following fields:
	-- Month
    -- Total gross sales amount to croma india in this month
 
USE gdb;
 
select 
	s.date,
	round(SUM(g.gross_price * s.sold_quantity), 2) as gross_price_total
from fact_sales_monthly s
join fact_gross_price g
ON 
	s.product_code = g.product_code and
	g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
group by s.date
Order by s.date asc;

# -------------------------------------------------------------------------------
# 3. Generate a yearly report for Croma India where there are two columns

-- 1. Fiscal Year
-- 2. Total Gross Sales amount In that year from Croma

USE gdb;
 
select 
	 get_fiscal_year(s.date) as fiscal_year,
	round(SUM(g.gross_price * s.sold_quantity), 2) as yearly_sales
from fact_sales_monthly s
join fact_gross_price g
ON 
	s.product_code = g.product_code and
	g.fiscal_year = get_fiscal_year(s.date)
where customer_code = 90002002
group by get_fiscal_year(s.date)
Order by fiscal_year asc;

# ----------------------------------------------------------------------------
#4. Region wise market share

with cte1 as (
	select 
		customer,
        region,
		round(sum(net_sales)/1000000,2) as net_sales_mil    
	from net_sales s
	join dim_customer c
	ON 
		s.customer_code = c.customer_code
	where fiscal_year = 2021 
	group by customer, region)
select 
	*,
    net_sales_mil * 100/sum(net_sales_mil) over(partition by region) as pct_share_region
from cte1
order by region, net_sales_mil desc;
# -----------------------------------------------------------------------------------------
# 5. top_2_market_of_each_region_by_gross_sales

use gdb;
with cte1 as(
		select 
			c.market,
			c.region,
			round(sum(gross_price_total)/1000000,2) as gross_sales_mln		
		from gross_sales s
        join dim_customer c
		on
			c.customer_code = s.customer_code

		where s.fiscal_year = 2021
		group by c.region, c.market),
cte2 as (
		select 
			*,
			dense_rank() over(partition by region order by gross_sales_mln desc) as drnk
		from cte1)

select 
	* 
from cte2
where drnk <= 2;
