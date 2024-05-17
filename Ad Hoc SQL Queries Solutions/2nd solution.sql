-- 2. What is the percentage of unique product increase in 2021 vs. 2020? The
-- final output contains these fields,
-- 		unique_products_2020
-- 		unique_products_2021
-- 		percentage_chg


select
    AA.A as Unique_product_2020,
    BB.B as Unique_product_2021,
    ROUND((BB.B - AA.A) * 100 / AA.A, 2) as pct_chg
from
    (
        (select COUNT(DISTINCT product_code) as A from fact_sales_monthly where fiscal_year = 2020) AS AA,
        (select COUNT(DISTINCT product_code) as B from fact_sales_monthly where fiscal_year = 2021) AS BB
    );
