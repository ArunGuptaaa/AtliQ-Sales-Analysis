# agrregate monthly gross sales report for croma india customer so that i can track how much sales this particular customer is generating for Atliq and manage our relationships accordingly.
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