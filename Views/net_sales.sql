CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `net_sales` AS
    SELECT 
        `sales_post_invoice_discount`.`date` AS `date`,
        `sales_post_invoice_discount`.`fiscal_year` AS `fiscal_year`,
        `sales_post_invoice_discount`.`customer_code` AS `customer_code`,
        `sales_post_invoice_discount`.`market` AS `market`,
        `sales_post_invoice_discount`.`product_code` AS `product_code`,
        `sales_post_invoice_discount`.`product` AS `product`,
        `sales_post_invoice_discount`.`variant` AS `variant`,
        `sales_post_invoice_discount`.`sold_quantity` AS `sold_quantity`,
        `sales_post_invoice_discount`.`gross_price_total` AS `gross_price_total`,
        `sales_post_invoice_discount`.`pre_invoice_discount_pct` AS `pre_invoice_discount_pct`,
        `sales_post_invoice_discount`.`net_invoice_sales` AS `net_invoice_sales`,
        `sales_post_invoice_discount`.`post_invoice_discount_pct` AS `post_invoice_discount_pct`,
        ROUND(((1 - `sales_post_invoice_discount`.`post_invoice_discount_pct`) * `sales_post_invoice_discount`.`net_invoice_sales`),
                2) AS `net_sales`
    FROM
        `sales_post_invoice_discount`