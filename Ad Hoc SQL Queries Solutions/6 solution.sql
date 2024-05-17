-- 6. Generate a report which contains the top 5 customers who received an
-- 	average high pre_invoice_discount_pct for the fiscal year 2021 and in the
-- 	Indian market. The final output contains these fields,
-- 		customer_code
-- 		customer
-- 		average_discount_percentage

select
    dc.customer,
    MAX(dc.customer_code) as customer_code,
    ROUND(avg(fp.pre_invoice_discount_pct) * 100, 2) as avg_disc_pct
from
    fact_pre_invoice_deductions as fp
inner join
    dim_customer dc on fp.customer_code = dc.customer_code
where
    fiscal_year = 2021 and
	market = 'india'
group by dc.customer
order by avg_disc_pct desc
limit 5;
