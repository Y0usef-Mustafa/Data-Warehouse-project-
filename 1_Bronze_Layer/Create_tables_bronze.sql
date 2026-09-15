/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

USE Datawarehouse_project;

IF OBJECT_ID('bronze.crm_accounts', 'U') IS NOT NULL
    DROP TABLE bronze.crm_accounts;
GO
CREATE TABLE bronze.crm_accounts(
    account NVARCHAR(50),
    sector NVARCHAR(50), 
    year_established NVARCHAR(50), 
    revenue NVARCHAR(50), 
    employees NVARCHAR(50), 
    office_location NVARCHAR(50),
    subsidiary_of NVARCHAR(50)
);

IF OBJECT_ID('bronze.crm_data_dictionary', 'U') IS NOT NULL
    DROP TABLE bronze.crm_data_dictionary;
GO
CREATE TABLE bronze.crm_data_dictionary(
    [table] NVARCHAR(50), 
    [field] NVARCHAR(50), 
    [description] NVARCHAR(MAX) 
);

IF OBJECT_ID('bronze.crm_products', 'U') IS NOT NULL
    DROP TABLE bronze.crm_products;
GO
CREATE TABLE bronze.crm_products(
    product NVARCHAR(50),
    series NVARCHAR(50),
    sales_price NVARCHAR(50) 
);

IF OBJECT_ID('bronze.crm_sales_pipeline', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_pipeline;
GO
CREATE TABLE bronze.crm_sales_pipeline(
    opportunity_id NVARCHAR(50),
    sales_agent NVARCHAR(50),
    product NVARCHAR(50),
    account NVARCHAR(50),
    deal_stage NVARCHAR(50),
    engage_date NVARCHAR(50), 
    close_date NVARCHAR(50), 
    close_value NVARCHAR(50) 
);

IF OBJECT_ID('bronze.crm_sales_teams', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_teams;
GO
CREATE TABLE bronze.crm_sales_teams(
    sales_agent NVARCHAR(50),
    manager NVARCHAR(50),
    regional_office NVARCHAR(50)
);
