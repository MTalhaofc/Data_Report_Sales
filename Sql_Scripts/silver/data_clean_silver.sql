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


    select * from silver.crm_cust_info;


-- Silver.crm_prd_info Cleaning and Inserting

    Insert into silver.crm_prd_info(
        prd_id,
        cat_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_manufacturing_cost,
        prd_line,
        prd_start_date,
        prd_end_date
    )
    Select 
 prd_id,
 replace(SUBSTRING(prd_key, 1, 5), '-' , '_') as cat_id,
 SUBSTRING(prd_key , 7 , Len(prd_key)) as prd_key,
 prd_nm,
 isnull(prd_cost,0) as prd_cost,
 CAST((prd_cost * (1 - (0.03 + (rand() * (0.11 - 0.03)))) ) AS INT) AS prd_manufacturing_cost,
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

     select * from silver.crm_prd_info;

-- Silver.crm_sales_details Cleaning and Insertion

Insert into silver.crm_sales_details(
sls_order_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
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



select * from silver.crm_sales_details;
select * from silver.crm_prd_info;



-- ERP Tables
-- silver.erp_cust_az12

Insert into silver.erp_cust_az12(
    cid,
    bdate,
    gen
)
select
case when cid LIKE 'NAS%' then SUBSTRING(cid, 4, len(cid))
else cid
end as cid,
case when bdate > getdate() then null
else bdatex
end as bdate,
case when upper(TRIM(GEN)) iN ('F' ,'Female') then 'Female'
when upper(TRIM(GEN)) iN ('M' ,'male') then 'Male'
else ' n/a'
end as gen
from bronze.erp_cust_az12;

-- silver.erp_loc_a101

insert into silver.erp_loc_a101(
    cid,
    cntry
)
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

select * from silver.erp_loc_a101;




-- silver.erp_px_cat_g1v2
insert into silver.erp_px_cat_g1v2(
   id,
   cat,
   subcat,
   maintenance 
)
select 
    id,
   cat,
   subcat,
   maintenance FROM
   bronze.erp_px_cat_g1v2;
   
   select * from silver.erp_px_cat_g1v2