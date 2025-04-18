CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_customers_by_net_sales`(
	in_market VARCHAR(45),
    in_fiscal_year INT,
    in_top_n INT
)
BEGIN
select 
	customer,
    round(sum(net_sales)/1000000,2) as net_sales_mil
from net_sales s
join dim_customer c
ON 
	s.customer_code = c.customer_code
where fiscal_year = in_fiscal_year and s.market = in_market
group by customer
order by net_sales_mil desc
limit in_top_n;
END