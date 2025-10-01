IF OBJECT_ID('bronze.crm_cust_info' ,'U') IS not NULL
    drop  table bronze.crm_cust_info;
Create table bronze.crm_cust_info(
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_martial_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);

IF OBJECT_ID('bronze.crm_prd_info' ,'U') IS not NULL
    drop  table bronze.crm_prd_info;
Create table bronze.crm_prd_info(
prd_id int,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost int,
prd_line NVARCHAR(10),
prd_start_date Date,
prd_end_date Date
);





IF OBJECT_ID('bronze.crm_sales_details' ,'U') IS not NULL
    drop  table bronze.crm_sales_details;
Create table bronze.crm_sales_details(
sls_order_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);








IF OBJECT_ID('bronze.erp_cust_az12' ,'U') is not NULL
Drop table bronze.erp_cust_az12;
create table bronze.erp_cust_az12(
    cid NVARCHAR(50),
    bdate date ,
    gen NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_px_cat_g1v2') is not NULL
drop table bronze.erp_px_cat_g1v2
create table bronze.erp_px_cat_g1v2(
    id NVARCHAR(50),
    cat NVARCHAR(50),
    subcat NVARCHAR(50),
    maintenance NVARCHAR(50)
);


IF OBJECT_ID('bronze.erp_loc_a101') is not NULL
drop table bronze.erp_loc_a101
create table bronze.erp_loc_a101(
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
    
    );
