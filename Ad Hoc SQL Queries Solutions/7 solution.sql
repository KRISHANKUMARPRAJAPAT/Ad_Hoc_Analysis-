-- 7. Get the complete report of the Gross sales amount for the customer “Atliq
-- Exclusive” for each month. This analysis helps to get an idea of low and
-- high-performing months and take strategic decisions.
			-- The final report contains these columns:
			-- Month
			-- Year
			-- Gross sales Amount
            
with cte1 as (
	select 
		monthname(s.date) as A,
        year(s.date) as B,
        s.fiscal_year,
        (g.gross_price*s.sold_quantity) as C
	from fact_sales_monthly s 
    join fact_gross_price g on s.product_code = g.product_code
    join dim_customer c on s.customer_code = c.customer_code
    where c.customer = 'Atliq Exclusive')

select 
	A as month,
    B as Year,
    round(sum(C),2) as Gross_sales_amt
from cte1
group by month, Year 
order by year;