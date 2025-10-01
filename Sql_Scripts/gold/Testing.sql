Select distinct product_name , count(*)
from gold.dim_products
GROUP by product_name
;


select count(*) from gold.dim_customers;
select count(*) from gold.dim_products;
select count(*) from gold.fact_sales;

select * from silver.crm_sales_details;
select * from silver.crm_prd_info;

select count(*) from silver.crm_prd_info;


SELECT
  LEFT(prd_key, 7) AS prd_key_prefix,
  COUNT(*) AS total_records
FROM silver.crm_prd_info
GROUP BY
  LEFT(prd_key, 7);


FR_M21S
FR M21B

SELECT * FROM silver.crm_prd_info

where prd_key Like 'FR-M21B%' or prd_key like 'FR-M21B';

select * from silver.crm_sales_details


SELECT
    *,
    CAST((prd_cost * (1 - (0.03 + (rand() * (0.11 - 0.03)))) ) AS INT) AS prd_manufacturing_cost
FROM
    silver.crm_prd_info;


    select *,
    CAST((prd_cost * (1 - (0.03 + (rand() * (0.11 - 0.03)))) ) AS INT) AS prd_manufacturing_cost
     from silver.crm_prd_info

    where prd_key like 'BK-R89B%'

update silver.crm_sales_details
set sls_sales = sls_quantity * sls_price;



select * from gold.dim_products;


SELECT
sales_amount , price 
from gold.fact_sales
where sales_amount != price;


select count(quantity) , sum(sales_amount) , sum(price) , sum(Manufacuturing_cost)
from gold.fact_sales;


Begin TRANSACTION 
UPDATE gold.fact_sales
SET sales_amount = price 
;

COMMIT;

drop view gold.fact_sales;

select * FROM
gold.fact_sales
where quantity > 1;

select * from 
gold.dim_products;


WITH GroupedProducts AS (
  -- First, group the products and count them
  SELECT
    LEFT(prd_key, 7) AS prd_key_prefix,
    COUNT(*) AS total_records,
    SUM(prd_cost) AS total_price_for_group
  FROM silver.crm_prd_info
  GROUP BY
    LEFT(prd_key, 7)
),
RankedGroups AS (
  -- Next, assign a rank to each group
  SELECT
    prd_key_prefix,
    total_records,
    total_price_for_group,
    ROW_NUMBER() OVER (ORDER BY prd_key_prefix) AS group_rank
  FROM GroupedProducts
)
-- Finally, apply the specific percentage reduction based on the rank
SELECT
  rg.prd_key_prefix,
  rg.total_records,
  rg.total_price_for_group,
  CASE
    WHEN rg.group_rank = 1 THEN rg.total_price_for_group * (1 - 0.03) -- 3% less
    WHEN rg.group_rank = 2 THEN rg.total_price_for_group * (1 - 0.07) -- 7% less
    WHEN rg.group_rank = 3 THEN rg.total_price_for_group * (1 - 0.13) -- 13% less
    WHEN rg.group_rank = 4 THEN rg.total_price_for_group * (1 - 0.27) -- 27% less
    WHEN rg.group_rank = 5 THEN rg.total_price_for_group * (1 - 0.05) -- 5% less
    ELSE rg.total_price_for_group -- Default: no reduction for other groups
  END AS estimated_manufacturing_price
FROM RankedGroups AS rg
ORDER BY
  rg.group_rank;


SELECT
    SUBSTRING(sls_prd_key, 1, 7) AS column_1,
    SUBSTRING(sls_prd_key, 8, LEN(sls_prd_key)) AS column_2
FROM
    silver.crm_prd_info;


select * FROM
silver.crm_sales_details 
where sls_sales > 3000;

select * from gold.dim_products;

Select * from gold.fact_sales;


SELECT
    product_key,
    product_name,
    product_id,
    -- Case statement to extract colors
    CASE
        WHEN product_name LIKE '%Red%' THEN 'Red'
        WHEN product_name LIKE '%White%' THEN 'White'
        WHEN product_name LIKE '%Black%' THEN 'Black'
        WHEN product_name LIKE '%Blue%' THEN 'Blue'
        WHEN product_name LIKE '%Green%' THEN 'Green'
        WHen product_name LIKE '%Silver%' THEN 'Silver'
        when product_name LIKE '%Yellow%' Then 'Yellow'
        ELSE 'Standard'
    END AS extracted_color,
    category,
    subcategory,
    product_line
FROM
    gold.dim_products;

select Count(*) from gold.dim_products