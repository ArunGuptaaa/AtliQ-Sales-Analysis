CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_by_net_sales`(
    in_fiscal_year INT,
    in_top_n INT
)
BEGIN
select 
	product,
    round(sum(net_sales)/1000000,2) as net_sales_mil
from net_sales s
where fiscal_year = in_fiscal_year
group by product
order by net_sales_mil desc
limit in_top_n;
END