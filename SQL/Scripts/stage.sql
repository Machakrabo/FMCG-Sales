/*
=========================================
Staging Layer Schema ( aka : stage)
=========================================
Purpose:
- The stage layer is the raw data storage layer.
- It is designed to hold ingested data with minimal transformations.
- Typically stores transactional-level data that will later feed into
  transform and load layers.

Warning:
- Once the code is executed, the tables will be created.
- If the script is re-executed, SQL Server will throw an error because
  the tables already exist (unless DROP/IF EXISTS logic is added).
- Run with caution in production environments.

Best Practices:
- Use schema-qualified names (e.g., mashabronze.table_name).
- Avoid making schema changes directly in production without testing.
- Use DROP TABLE IF EXISTS if you want to re-create tables safely.
*/
----------------------------------
/* creating database - One time creation */
--USE master;
--CREATE DATABASE FMCGdb;
-----------------------------------
USE FMCGdb;
GO
-------------------------------------
/* create a staging schema-- One time creation*/
--CREATE SCHEMA stage;
/*create a table under the schema*/
------------------------------------
GO
IF OBJECT_ID ('stage.csv_sales_info', 'U')IS NOT NULL
  DROP TABLE stage.csv_sales_info;
CREATE TABLE stage.csv_sales_info(
	sales_date DATE,
	sku NVARCHAR(100),
	brand NVARCHAR(100),
	segment NVARCHAR(100),
	category NVARCHAR(100),
	channel NVARCHAR(100),
	region NVARCHAR(100),
	pack_type NVARCHAR(100),
	price_unit NVARCHAR(100),
	promotion_flag NVARCHAR(100),
	delivery_days NVARCHAR(100),
	stock_available NVARCHAR(100),
	delivered_qty NVARCHAR(100),
	units_sold NVARCHAR(100),
);
GO
IF OBJECT_ID ('stage.csv_weekly_enriched_sales_info', 'U')IS NOT NULL
  DROP TABLE stage.csv_weekly_enriched_sales_info;
CREATE TABLE stage.csv_weekly_enriched_sales_info(
	sales_date DATE,
	sku NVARCHAR(100),
	brand NVARCHAR(100),
	segment NVARCHAR(100),
	category NVARCHAR(100),
	channel NVARCHAR(100),
	region NVARCHAR(100),
	pack_type NVARCHAR(100),
	price_unit NVARCHAR(100),
	promotion_flag NVARCHAR(100),
	delivery_days NVARCHAR(100),
	stock_available NVARCHAR(100),
	delivered_qty NVARCHAR(100),
	units_sold NVARCHAR(100),
);
IF OBJECT_ID ('stage.parquet_sales_info1', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info1;
CREATE TABLE stage.parquet_sales_info1(
	sales_date DATE,
	sku NVARCHAR(100),
	brand NVARCHAR(100),
	segment NVARCHAR(100),
	category NVARCHAR(100),
	channel NVARCHAR(100),
	region NVARCHAR(100),
	pack_type NVARCHAR(100),
	price_unit NVARCHAR(100),
	promotion_flag NVARCHAR(100),
	delivery_days NVARCHAR(100),
	stock_available NVARCHAR(100),
	delivered_qty NVARCHAR(100),
	units_sold NVARCHAR(100),
);
GO
IF OBJECT_ID ('stage.parquet_sales_info2', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info2;
CREATE TABLE stage.parquet_sales_info2(
	sales_date DATE,
	sku NVARCHAR(100),
	brand NVARCHAR(100),
	segment NVARCHAR(100),
	category NVARCHAR(100),
	channel NVARCHAR(100),
	region NVARCHAR(100),
	pack_type NVARCHAR(100),
	price_unit NVARCHAR(100),
	promotion_flag NVARCHAR(100),
	delivery_days NVARCHAR(100),
	stock_available NVARCHAR(100),
	delivered_qty NVARCHAR(100),
	units_sold NVARCHAR(100),
);
GO
IF OBJECT_ID ('stage.parquet_sales_info3', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info3;
CREATE TABLE stage.parquet_sales_info3(
	sales_date DATE,
	sku NVARCHAR(100),
	brand NVARCHAR(100),
	segment NVARCHAR(100),
	category NVARCHAR(100),
	channel NVARCHAR(100),
	region NVARCHAR(100),
	pack_type NVARCHAR(100),
	price_unit NVARCHAR(100),
	promotion_flag NVARCHAR(100),
	delivery_days NVARCHAR(100),
	stock_available NVARCHAR(100),
	delivered_qty NVARCHAR(100),
	units_sold NVARCHAR(100),
);
GO
IF OBJECT_ID ('stage.parquet_sales_info4', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info4;
CREATE TABLE stage.parquet_sales_info4(
	sales_date DATE,
	sku NVARCHAR(100),
	brand NVARCHAR(100),
	segment NVARCHAR(100),
	category NVARCHAR(100),
	channel NVARCHAR(100),
	region NVARCHAR(100),
	pack_type NVARCHAR(100),
	price_unit NVARCHAR(100),
	promotion_flag NVARCHAR(100),
	delivery_days NVARCHAR(100),
	stock_available NVARCHAR(100),
	delivered_qty NVARCHAR(100),
	units_sold NVARCHAR(100),
);
