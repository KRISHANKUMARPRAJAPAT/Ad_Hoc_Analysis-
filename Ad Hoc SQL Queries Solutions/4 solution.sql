-- 4. Follow-up: Which segment had the most increase in unique products in
-- 2021 vs 2020? The final output contains these fields,
--     		segment
--     		product_count_2020
--     		product_count_2021
--     		difference
            
with cte1 as (
	select 
			dp.segment as A,
			count(distinct fs.product_code) as B
	from fact_sales_monthly fs
    join dim_product dp
    on fs.product_code = dp.product_code
	group by dp.segment, fs.fiscal_year
    having fs.fiscal_year=2020),
    
cte2 as (
	select 
		dp.segment as C,
        count(distinct fs.product_code) as D
	from fact_sales_monthly fs
    join dim_product dp
    on fs.product_code = dp.product_code
    group by dp.segment, fs.fiscal_year
    having fs.fiscal_year=2021)

select 
	cte1.A as segment,
    cte1.B as product_code_2020,
    cte2.D as product_code_2021,
    (cte2.D-cte1.B) as difference 
from cte1, cte2
where cte1.A = cte2.C;
