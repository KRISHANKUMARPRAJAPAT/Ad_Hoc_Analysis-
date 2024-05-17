-- 9. Which channel helped to bring more gross sales in the fiscal year 2021
-- and the percentage of contribution? 
--        The final output contains these fields,
--        			channel
--        			gross_sales_mln
--        			percentage

with channels as
		(select 
			channel,
			round(sum( sold_quantity* gross_price )/1000000,0) as gross_sales_mln
		from fact_sales_monthly as fs
		join fact_gross_price as fp
		on 
			fs.product_code=fp.product_code
		join dim_customer as dc
		on 
			fs.customer_code=dc.customer_code
		where fs.fiscal_year = 2021
		group by channel
		order by gross_sales_mln desc)

select 
	*,
    round(gross_sales_mln*100/ (select sum(gross_sales_mln) from channels),2) 
    as pct_contributions
from channels