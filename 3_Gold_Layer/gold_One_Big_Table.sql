

---One Big Table - OBT
CREATE OR ALTER VIEW gold.One_Big_Table  AS
SELECT 
  
    sp.opportunity_id,
    sp.sales_agent,
    sp.product,
    sp.account,
    sp.deal_stage,
    sp.engage_date,
    sp.close_date,
    COALESCE(sp.close_value, 0) AS close_value, 
    COALESCE(ac.sector, 'Unknown') AS sector,
    COALESCE(ac.office_location, 'Unknown') AS office_location,
    COALESCE(ac.subsidiary_of, 'N/A') AS subsidiary_of,
    COALESCE(ac.employees, 0) AS employees,
    COALESCE(ac.revenue, 0) AS revenue,
    COALESCE(ac.year_established, 0) AS year_established,
    COALESCE(pr.series, 'Unknown') AS series,
    COALESCE(pr.sales_price, 0) AS sales_price,
    COALESCE(st.manager, 'Unknown') AS manager,
    COALESCE(st.regional_office, 'Unknown') AS regional_office

FROM silver.crm_sales_pipeline AS sp
LEFT JOIN silver.crm_accounts AS ac 
    ON sp.account = ac.account
LEFT JOIN silver.crm_products AS pr 
    ON sp.product = pr.product
LEFT JOIN silver.crm_sales_teams AS st 
    ON sp.sales_agent = st.sales_agent;
GO


SELECT * FROM gold.One_Big_Table ;