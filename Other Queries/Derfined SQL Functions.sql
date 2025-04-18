-- As a product owner, I want to generate a report of individual product sales (aggregated on a monthly basis at the product 
-- code level) for Croma India customer for FY=2021 so that I can track individual product sales and run further product 
-- analytics on it in excel.

-- The report should have the following fields,

-- Month
-- Product Name
-- Variant
-- Sold Quantity
-- Gross Price Per Item
-- Gross Price Total

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

