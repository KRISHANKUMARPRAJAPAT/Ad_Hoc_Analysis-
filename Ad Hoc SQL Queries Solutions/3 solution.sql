-- 3. Provide a report with all the unique product counts for each segment and 2 fields,
-- 		segment
-- 		product_count

select
	segment,
    count(distinct product_code) as product_count
from dim_product
group by segment
order by product_count desc;
