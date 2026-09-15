# 📊 CRM Data Warehouse - Medallion Architecture

## 📝 Project Overview
This project demonstrates the end-to-end design and implementation of a **Data Warehouse** for a CRM (Customer Relationship Management) system. The pipeline processes sales pipeline data, customer accounts, products, and sales teams' information to build a robust, analytics-ready data model. 

The architecture strictly follows the **Medallion Architecture (Bronze, Silver, Gold)** using **Microsoft SQL Server (T-SQL)** to ensure data quality, consistency, and optimized performance for Business Intelligence (BI) workloads like Power BI.

---

## 🏗️ Data Architecture

The project leverages the Medallion Architecture to progressively refine the data:

### 🥉 1. Bronze Layer (Raw Data)
* **Objective:** Extract and load raw data from source systems (CSV files) into the database "AS-IS" without applying any transformations.
* **Process:** Created tables using `NVARCHAR` for all columns to prevent load failures, followed by Bulk Insert operations.
* **Scripts:** 
  * `01_Bronze_Layer/Create_tables_bronze.sql`
  * `01_Bronze_Layer/Load_Data_bronze.sql`

### 🥈 2. Silver Layer (Cleansed & Conformed Data)
* **Objective:** Cleanse, standardize, and transform the data.
* **Process:** 
  * Standardized text formats (e.g., trimming spaces, fixing typos like 'technolgy' to 'technology').
  * Applied data type casting (using `TRY_CAST` to handle bad data safely).
  * Handled `NULL` values and missing entities.
  * Added audit columns (`dwh_create_date`).
* **Scripts:** 
  * `02_Silver_Layer/creat_table_silver.sql`
  * `02_Silver_Layer/Transform_data.sql`

### 🥇 3. Gold Layer (Business-Ready Data)
* **Objective:** Model the data for analytical querying and BI reporting.
* **Process:** Created SQL `VIEWS` to form a **Star Schema** (Fact and Dimensions) and a **One Big Table (OBT)** to cater to different analytical needs (e.g., Power BI vs. Machine Learning models).
* **Scripts:** 
  * `03_Gold_Layer/gold_star_schema.sql` (Creates 1 Fact and 3 Dimension views)
  * `03_Gold_Layer/gold_One_Big_Table.sql` (Denormalized analytical view)

---

## 🗂️ Repository Structure

```text
DataWarehouse_CRM_Project/
│
├── 01_Bronze_Layer/
│   ├── Create_tables_bronze.sql
│   └── Load_Data_bronze.sql
│
├── 02_Silver_Layer/
│   ├── creat_table_silver.sql
│   └── Transform_data.sql
│
├── 03_Gold_Layer/
│   ├── gold_star_schema.sql
│   └── gold_One_Big_Table.sql
│
├── docs/
│   ├── Data_Arch.drawio.png
│   ├── data_integration_2.png
│   └── data_model.png
│
├── source_data/
│   ├── accounts.csv
│   ├── data_dictionary.csv
│   ├── products.csv
│   ├── sales_pipeline.csv
│   └── sales_teams.csv
│
└── README.md

🧩 Data Modeling
Integration Model
Mapping the relationships between the CRM source entities:

Dimensional Model (Star Schema)
The final Gold Layer represents a highly optimized Star Schema with fact_sales at the center, surrounded by conforming dimensions:

🛠️ Tech Stack
Database Engine: Microsoft SQL Server

Language: SQL (T-SQL)

Concepts Applied: ETL/ELT Pipeline, Medallion Architecture, Data Cleansing, Data Modeling (Star Schema & OBT), Defensive Programming (TRY_CAST, COALESCE).

🚀 How to Run the Project
Clone this repository to your local machine.

Ensure you have SQL Server and SQL Server Management Studio (SSMS) installed.

Update the file paths in the Load_Data_bronze.sql script to point to the source_data folder on your local machine.

Execute the SQL scripts in the following order:

Bronze: Create_tables_bronze.sql -> Load_Data_bronze.sql

Silver: creat_table_silver.sql -> Transform_data.sql

Gold: gold_star_schema.sql or gold_One_Big_Table.sql
