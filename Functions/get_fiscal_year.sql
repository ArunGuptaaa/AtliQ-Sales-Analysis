#paste the given code in MySQL Workbench


CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_year`(
	calendar_date DATE
) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE fiscal_year INT;
    SET fiscal_year = YEAR(Date_Add(calendar_date, Interval 4 MONTH));
	RETURN fiscal_year;
END