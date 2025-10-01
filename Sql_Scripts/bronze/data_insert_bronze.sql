create or alter PROCEDURE bronze.load_bronze as 
BEGIN

print '==================================';
print 'Loading Bronze Layer';
print '==================================';
print '-------------------------------';
print 'Loading CRM Tables';
print '-------------------------------';


TRUNCATE TABLE bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
from 'C:\Users\mtalha.saeed\OneDrive - Systems Limited\Internship_Work\DataWarehouse\datasets\source_crm\cust_info.csv'
with
( FIRSTROW = 2,
Fieldterminator = ',',
tablock
);



TRUNCATE TABLE bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
from 'C:\Users\mtalha.saeed\OneDrive - Systems Limited\Internship_Work\DataWarehouse\datasets\source_crm\prd_info.csv'
with
( FIRSTROW = 2,
Fieldterminator = ',',
tablock
);




TRUNCATE TABLE bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
from 'C:\Users\mtalha.saeed\OneDrive - Systems Limited\Internship_Work\DataWarehouse\datasets\source_crm\sales_details.csv'
with
( FIRSTROW = 2,
Fieldterminator = ',',
tablock
);


print '-------------------------------';
print 'Loading ERP Tables';
print '-------------------------------';


TRUNCATE TABLE bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
from 'C:\Users\mtalha.saeed\OneDrive - Systems Limited\Internship_Work\DataWarehouse\datasets\source_erp\CUST_AZ12.csv'
with
( FIRSTROW = 2,
Fieldterminator = ',',
tablock
);




TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
from 'C:\Users\mtalha.saeed\OneDrive - Systems Limited\Internship_Work\DataWarehouse\datasets\source_erp\PX_CAT_G1V2.csv'
with
( FIRSTROW = 2,
Fieldterminator = ',',
tablock
);





TRUNCATE TABLE bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
from 'C:\Users\mtalha.saeed\OneDrive - Systems Limited\Internship_Work\DataWarehouse\datasets\source_erp\LOC_A101.csv'
with
( FIRSTROW = 2,
Fieldterminator = ',',
tablock
);



end;


exec bronze.load_bronze;
