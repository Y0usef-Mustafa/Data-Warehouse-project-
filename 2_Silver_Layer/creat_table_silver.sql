/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
    Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/

USE Datawarehouse_project;

IF OBJECT_ID('silver.crm_accounts', 'U') IS NOT NULL
    DROP TABLE silver.crm_accounts;
GO
CREATE TABLE silver.crm_accounts(
    account NVARCHAR(50),
    sector NVARCHAR(50), 
    year_established INT,
    revenue FLOAT,
    employees INT, 
    office_location NVARCHAR(50),
    subsidiary_of NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_data_dictionary', 'U') IS NOT NULL
    DROP TABLE silver.crm_data_dictionary;
GO
CREATE TABLE silver.crm_data_dictionary(
    [table] NVARCHAR(50), 
    [field] NVARCHAR(50), 
    [description] NVARCHAR(150),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_products', 'U') IS NOT NULL
    DROP TABLE silver.crm_products;
GO
CREATE TABLE silver.crm_products(
    product NVARCHAR(50),
    series NVARCHAR(50),
    sales_price DECIMAL(18,2),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_sales_pipeline', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_pipeline;
GO
CREATE TABLE silver.crm_sales_pipeline(
    opportunity_id NVARCHAR(50),
    sales_agent NVARCHAR(50),
    product NVARCHAR(50),
    account NVARCHAR(50),
    deal_stage NVARCHAR(50),
    engage_date DATE,
    close_date DATE,
    close_value FLOAT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

IF OBJECT_ID('silver.crm_sales_teams', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_teams;
GO
CREATE TABLE silver.crm_sales_teams(
    sales_agent NVARCHAR(50),
    manager NVARCHAR(50),
    regional_office NVARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
