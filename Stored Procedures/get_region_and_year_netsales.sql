CREATE DEFINER=`root`@`localhost` PROCEDURE `get_region_and_year_netsales`(
	in_fiscal_year INT
)
BEGIN
with cte1 as (
	select 
		customer,
        region,
		round(sum(net_sales)/1000000,2) as net_sales_mil    
	from net_sales s
	join dim_customer c
	ON 
		s.customer_code = c.customer_code
	where fiscal_year = in_fiscal_year 
	group by customer, region)
select 
	*,
    net_sales_mil * 100/sum(net_sales_mil) over(partition by region) as pct_share_region
from cte1
order by region, net_sales_mil desc;
END