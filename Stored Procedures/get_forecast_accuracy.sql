CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
        	in_fiscal_year INT
)
BEGIN
	with forecast_err_table as (
	   select
		   s.customer_code as customer_code,
		   c.customer as customer_name,
		   c.market as market,
		   sum(s.sold_quantity) as total_sold_qty,
		   sum(s.forecast_quantity) as total_forecast_qty,
		   sum(s.forecast_quantity-s.sold_quantity) as net_error,
		   round(sum(s.forecast_quantity-s.sold_quantity)*100/sum(s.forecast_quantity),1) as net_error_pct,
		   sum(abs(s.forecast_quantity-s.sold_quantity)) as abs_error,
		   round(sum(abs(s.forecast_quantity-sold_quantity))*100/sum(s.forecast_quantity),2) as abs_error_pct
	   from fact_act_est s
	   join dim_customer c
	   on s.customer_code = c.customer_code
	   where s.fiscal_year=in_fiscal_year
	   group by customer_code
	)
	select 
		*,
		if (abs_error_pct > 100, 0, 100.0 - abs_error_pct) as forecast_accuracy
	from forecast_err_table
	order by forecast_accuracy desc;
	END