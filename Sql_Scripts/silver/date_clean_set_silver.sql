SELECT cst_id , count(*) Counting
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) >1 or cst_id is null;

select * from (
Select * ,
ROW_Number() over (PARTITION by cst_id order by  cst_create_date desc) as flag_last 
from 
bronze.crm_cust_info )t where flag_last = 1;

-- String Spaces
select cst_firstname
from silver.crm_cust_info
where cst_firstname !=TRIM(cst_firstname)
;


select cst_lastname
from bronze.crm_cust_info
where cst_lastname !=TRIM(cst_lastname)
;

select cst_gndr
from bronze.crm_cust_info
where cst_gndr !=TRIM(cst_gndr);


	INSERT INTO silver.crm_cust_info (
			cst_id, 
			cst_key, 
			cst_firstname, 
			cst_lastname, 
			cst_martial_status, 
			cst_gndr,
			cst_create_date
		)
SELECT
    cst_id,
    cst_key,
    Trim(cst_firstname) as cst_firstname,
    Trim(cst_lastname) as cst_lastname,

    CAse when upper(trim(cst_martial_status)) = 'S' then 'Single'
    when upper(trim(cst_martial_status)) = 'M' then 'Married'
    else 'n/a'
    end cst_martial_status,

    CAse when upper(trim(cst_gndr)) = 'F' then 'Female'
    when upper(trim(cst_gndr)) = 'M' then 'Male'
    else 'n/a'
    end cst_gndr,
    cst_create_date
FROM
    (
        SELECT
            *,
            ROW_Number() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as flag_last
        FROM
            bronze.crm_cust_info
    ) t
WHERE
    flag_last = 1;


    -- Deleted Rough Data
SELECT
    COUNT(*)
FROM
    bronze.crm_cust_info
WHERE
    cst_key LIKE 'AW000%';

Begin TRANSACTION
DELETE FROM bronze.crm_cust_info
WHERE  cst_key NOT LIKE 'AW0%';



Select Distinct cst_gndr
from bronze.crm_cust_info;


-- silver.crm_prd_info Table

select * FROM
bronze.crm_prd_info;

SELECT prd_id , count(*) Counting
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) >1 or prd_id is null;


 Select 
 prd_id,
 replace(SUBSTRING(prd_key, 1, 5), '-' , '_') as cat_id,
 SUBSTRING(prd_key , 7 , Len(prd_key)) as prd_key,
 prd_nm,
 isnull(prd_cost,0) as prd_cost,
 
 case  upper(trim(prd_line)) 
    When 'M' Then 'Mountain'
    When 'R' Then 'Road'
    When'S' Then 'Other Sales'  
    When 'T' Then 'Touring'
 else 'n/a'
 end prd_line,
 cast (prd_start_date as date)  as prd_start_date,
cast (DATEADD(day, -1, LEAD(prd_start_date) over(PARTITION by prd_key order by prd_start_date)) as date) as prd_end_date_test
 from bronze.crm_prd_info; 



select distinct id from bronze.erp_px_cat_g1v2;

select prd_start_date,  from bronze.crm_sales_details;


select prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null ;


select
prd_id,
prd_key,
prd_nm,
prd_start_date,
prd_end_date,
DATEADD(day, -1, LEAD(prd_start_date) over(PARTITION by prd_key order by prd_start_date))  as prd_end_date_test
from bronze.crm_prd_info
where prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509');



select * from 
silver.crm_prd_info
where prd_start_date > prd_end_date;




-- Sales Details Table

select 
sls_order_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt = 0 OR len(sls_order_dt) != 8 then null
else cast(cast(sls_order_dt as Varchar) as date)
end as sls_order_dt,
case when sls_ship_dt = 0 OR len(sls_ship_dt) != 8 then null
else cast(cast(sls_ship_dt as Varchar) as date)
end as sls_ship_dt,
case when sls_due_dt = 0 OR len(sls_due_dt) != 8 then null
else cast(cast(sls_due_dt as Varchar) as date)
end as sls_due_dt,
case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * ABS(sls_price)
    then  sls_quantity * ABS(sls_price)
    else sls_sales
end as sls_sales,
sls_quantity,
case when sls_price is null or sls_price <= 0
    then sls_sales /nullif(sls_quantity,0)
else sls_price
end as sls_price
 FROM
bronze.crm_sales_details;







select 
nullif(sls_order_dt , 0) sls_order_dt
from bronze.crm_sales_details
where sls_order_dt <= 0 
or len(sls_order_dt) != 8 
or sls_order_dt  > 20500101
or sls_order_dt < 19000101
;

select sls_order_dt
from bronze.crm_sales_details;


select * FROM silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt or sls_ship_dt > sls_due_dt;

select distinct
sls_sales as old_sales,
sls_quantity,
sls_price as old_price,

case when sls_sales is null or sls_sales <= 0 or sls_sales != sls_quantity * ABS(sls_price)
    then  sls_quantity * ABS(sls_price)
    else sls_sales
end as sls_sales,

case when sls_price is null or sls_price <= 0
    then sls_sales /nullif(sls_quantity,0)
else sls_price
end as sls_price

from silver.crm_sales_details
where   sls_sales != (sls_quantity * sls_price)
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <= 0 or sls_price <= 0
order  by sls_sales,
sls_quantity,
sls_price;

select sls_price 
from bronze.crm_sales_details
where sls_price < 0;


-- ERP Tables
-- silver.erp_cust_az12

select * from bronze.erp_cust_az12

select* from silver.crm_cust_info;


select
case when cid LIKE 'NAS%' then SUBSTRING(cid, 4, len(cid))
else cid
end as cid,
case when bdate > getdate() then null
else bdate
end as bdate,
case when upper(TRIM(GEN)) iN ('F' ,'Female') then 'Female'
when upper(TRIM(GEN)) iN ('M' ,'male') then 'Male'
else ' n/a'
end as gen
from bronze.erp_cust_az12


select distinct
bdate
from bronze.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate();


select distinct gen

from silver.erp_cust_az12;


select 
replace(cid, '-', '') as cid,
CASE
    WHEN TRIM(cntry) = 'DE' THEN 'Germany'
    WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
    WHEN TRIM(cntry) = '' OR TRIM(cntry) IS NULL THEN 'n/a'
    ELSE TRIM(cntry)
  END AS newcntry
from bronze.erp_loc_a101
;

SELECT DISTINCT
  cntry,
  CASE
    WHEN TRIM(cntry) = 'DE' THEN 'Germany'
    WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
    WHEN TRIM(cntry) = '' OR TRIM(cntry) IS NULL THEN 'n/a'
    ELSE TRIM(cntry)
  END AS newcntry
FROM
  silver.erp_loc_a101
ORDER BY
  cntry;

