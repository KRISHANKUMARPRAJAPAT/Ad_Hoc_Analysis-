-- 8. In which quarter of 2020, got the maximum total_sold_quantity? The final
-- output contains these fields sorted by the total_sold_quantity, 
-- 			Quarter
-- 			total_sold_quantity


select 
	case
		when month(date) between 9 and 11 then "First Quater"
        when month(date) between 12 and 2 then "Second Quater"
        when month(date) between 3 and 5 then "Third Quater"
        when month(date) between 6 and 8 then "Fourth Quater"
    end as Quater,
    max(fs.date) as date,
    concat(cast(round(sum(sold_quantity)/1000000,2) as char)," M") as total_sold_quantity
from fact_sales_monthly fs
where fiscal_year = 2020
group by Quater
order by total_sold_quantity desc