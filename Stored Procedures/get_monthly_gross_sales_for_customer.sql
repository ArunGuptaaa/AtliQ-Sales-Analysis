CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sales_for_customer`(
	c_code INT
)
BEGIN
	select 
		s.date,
		round(SUM(g.gross_price * s.sold_quantity), 2) as gross_price_total
	from fact_sales_monthly s
	join fact_gross_price g
	ON 
		s.product_code = g.product_code and
		g.fiscal_year = get_fiscal_year(s.date)
	where customer_code = c_code
	group by s.date
	Order by s.date asc;
END