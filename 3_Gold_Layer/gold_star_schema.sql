/*
===============================================================================
DDL Script: Create Gold Views (Star Schema)
===============================================================================
Script Purpose:
    This script creates Views for the Gold Layer in a Star Schema format.
    These views are optimized for Power BI and Analytics.
===============================================================================
*/

USE Datawarehouse_project;
GO

-------------------------------------------------------------------------------
-- 1. Dimension View: Accounts 

CREATE OR ALTER VIEW gold.dim_accounts AS
SELECT 
    account,
    sector,
    year_established,
    revenue,
    employees,
    office_location,
    subsidiary_of
FROM silver.crm_accounts;
GO

-------------------------------------------------------------------------------
-- 2. Dimension View: Products 

CREATE OR ALTER VIEW gold.dim_products AS
SELECT 
    product,
    series,
    sales_price
FROM silver.crm_products;
GO

-------------------------------------------------------------------------------
-- 3. Dimension View: Sales Teams 

CREATE OR ALTER VIEW gold.dim_sales_teams AS
SELECT 
    sales_agent,
    manager,
    regional_office
FROM silver.crm_sales_teams;
GO

-------------------------------------------------------------------------------
-- 4. Fact View: Sales Pipeline 

CREATE OR ALTER VIEW gold.fact_sales AS
SELECT 
    opportunity_id,
    sales_agent,
    product,
    account,
    deal_stage,
    engage_date,
    close_date,
    COALESCE(close_value, 0) AS close_value 
FROM silver.crm_sales_pipeline;
GO
