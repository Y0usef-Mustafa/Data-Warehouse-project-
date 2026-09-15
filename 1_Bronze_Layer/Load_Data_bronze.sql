/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
USE Datawarehouse_project;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_accounts';
		TRUNCATE TABLE bronze.crm_accounts;
		PRINT '>> Inserting Data Into: bronze.crm_accounts';
		BULK INSERT bronze.crm_accounts
		FROM 'F:\Data Topics\data_warehouse_project\source_data\accounts.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK ,
			FORMAT = 'CSV', 
			ROWTERMINATOR = '\n'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_data_dictionary';
		TRUNCATE TABLE bronze.crm_data_dictionary;
		PRINT '>> Inserting Data Into: bronze.crm_data_dictionary';
		BULK INSERT bronze.crm_data_dictionary
		FROM 'F:\Data Topics\data_warehouse_project\source_data\data_dictionary.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK,
			FORMAT = 'CSV', 
			ROWTERMINATOR = '\n'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_products';
		TRUNCATE TABLE bronze.crm_products;
		PRINT '>> Inserting Data Into: bronze.crm_products';
		BULK INSERT bronze.crm_products 
		FROM 'F:\Data Topics\data_warehouse_project\source_data\products.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK,
			FORMAT = 'CSV', 
			ROWTERMINATOR = '\n'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_pipeline'; 
		TRUNCATE TABLE bronze.crm_sales_pipeline;
		PRINT '>> Inserting Data Into: bronze.crm_sales_pipeline';
		BULK INSERT bronze.crm_sales_pipeline 
		FROM 'F:\Data Topics\data_warehouse_project\source_data\sales_pipeline.csv' 
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK,
			FORMAT = 'CSV', 
			ROWTERMINATOR = '\n'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_teams'; 
		TRUNCATE TABLE bronze.crm_sales_teams;
		PRINT '>> Inserting Data Into: bronze.crm_sales_teams';
		BULK INSERT bronze.crm_sales_teams
		FROM 'F:\Data Topics\data_warehouse_project\source_data\sales_teams.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK,
			FORMAT = 'CSV', 
			ROWTERMINATOR = '\n'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '==========================================';
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==========================================';
	END TRY
	BEGIN CATCH
		PRINT '==========================================';
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '==========================================';
	END CATCH
END;

--- test 
EXEC bronze.load_bronze;


