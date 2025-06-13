CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sales_pre_invoice_discount` AS
    SELECT 
        `s`.`date` AS `date`,
        `s`.`fiscal_year` AS `fiscal_year`,
        `c`.`customer_code` AS `customer_code`,
        `c`.`customer` AS `customer`,
        `c`.`market` AS `market`,
        `p`.`product_code` AS `product_code`,
        `p`.`product` AS `product`,
        `p`.`variant` AS `variant`,
        `s`.`sold_quantity` AS `sold_quantity`,
        `g`.`gross_price` AS `gross_price_per_item`,
        (`g`.`gross_price` * `s`.`sold_quantity`) AS `gross_price_total`,
        `pre`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`
    FROM
        ((((`fact_sales_monthly` `s`
        JOIN `dim_product` `p` ON ((`s`.`product_code` = `p`.`product_code`)))
        JOIN `dim_customer` `c` ON ((`s`.`customer_code` = `c`.`customer_code`)))
        JOIN `fact_gross_price` `g` ON (((`s`.`product_code` = `g`.`product_code`)
            AND (`g`.`fiscal_year` = `s`.`fiscal_year`))))
        JOIN `fact_pre_invoice_deductions` `pre` ON (((`pre`.`customer_code` = `s`.`customer_code`)
            AND (`pre`.`fiscal_year` = `s`.`fiscal_year`))))