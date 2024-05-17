-- 10. Get the Top 3 products in each division that have a high
-- total_sold_quantity in the fiscal_year 2021? 
-- 		The final output contains these fields,
-- 				division
-- 				product_code
-- 				product
-- 				total_sold_quantity
-- 				rank_order

with ranked_product as 
		( -- creating a table with total_sold_quantities and rank_order columns
			with top_products as ( select
										fs.product_code,
                                        max(dp.product) as product,
                                        dp.division,
                                        sum(sold_quantity) as total_sold_quantity
									from fact_sales_monthly fs
                                    join dim_product as dp
                                    on 
										fs.product_code=dp.product_code
									where fiscal_year=2021
                                    group by fs.product_code, division
                                    order by total_sold_quantity desc)
			select 
				*,
                -- creating a rank-column
                rank() over( partition by division 
                order by total_sold_quantity desc) as rank_order
			from top_products)
            
select
	*
from ranked_product
where rank_order in (1,2,3)