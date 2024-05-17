-- 5. Get the products that have the highest and lowest manufacturing costs.
-- The final output should contain these fields,
-- 	 		product_code
-- 	 		product
-- 			manufacturing_cost



With max_values as 
	(select
        dp.product_code,
        dp.product, dp.segment,
        fm.manufacturing_cost as manufacturing_cost_max_min
    from fact_manufacturing_cost as fm
    inner join dim_product dp 
    ON
		fm.product_code = dp.product_code
    where fm.manufacturing_cost = 
			(select MAX(manufacturing_cost) from fact_manufacturing_cost)),
            
min_values as 
	(select
        dp.product_code,
        dp.product, dp.segment,
        fm.manufacturing_cost AS manufacturing_cost_max_min
    from fact_manufacturing_cost as fm
    inner join dim_product dp 
	on 
		fm.product_code = dp.product_code
    where fm.manufacturing_cost = 
			(select MIN(manufacturing_cost) from fact_manufacturing_cost))

select * from max_values
union all
select * from min_values;
