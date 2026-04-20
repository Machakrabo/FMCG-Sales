/*
=========================================
Staging Layer Schema ( aka : stage)
=========================================
Purpose:
- The stage layer is the raw data storage layer.
- It is designed to hold ingested data with minimal transformations.
- Typically stores transactional-level data that will later feed into
  Silver (cleansed) and Gold (aggregated/curated) layers.

Warning:
- Once the code is executed, the tables will be created.
- If the script is re-executed, SQL Server will throw an error because
  the tables already exist (unless DROP/IF EXISTS logic is added).
- Run with caution in production environments.

Best Practices:
- Use schema-qualified names
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
    date        DATE           NOT NULL,
    sku              VARCHAR(20)    NOT NULL,
    brand            VARCHAR(50)    NOT NULL,
    segment          VARCHAR(50)    NOT NULL,
    category         VARCHAR(50)    NOT NULL,
    channel          VARCHAR(30)    NOT NULL,
    region           VARCHAR(30)    NOT NULL,
    pack_type        VARCHAR(20)    NOT NULL,
    price_unit       DECIMAL(5,2)   NOT NULL,
    promotion_flag   TINYINT        NOT NULL,
    delivery_days    DECIMAL(5,2)      NOT NULL,
    stock_available  DECIMAL(5,2)      NOT NULL,
    delivered_qty    DECIMAL(5,2)      NOT NULL,
    units_sold       DECIMAL(5,2)      NOT NULL
);
GO
IF OBJECT_ID ('stage.csv_weekly_enriched_sales_info', 'U')IS NOT NULL
  DROP TABLE stage.csv_weekly_enriched_sales_info;
CREATE TABLE stage.csv_weekly_enriched_sales_info(
   
    sku              VARCHAR(20)    NOT NULL,
    date        DATE           NOT NULL,
    channel          VARCHAR(30)    NOT NULL,
    region           VARCHAR(30)    NOT NULL,
    units_sold       DECIMAL(5,2)      NOT NULL,
    stock_available  DECIMAL(5,2)       NOT NULL,
    promotion_flag   TINYINT        NOT NULL,
    price_unit       DECIMAL(5,2)   NOT NULL,
    delivery_days    DECIMAL(5,2)        NOT NULL,
    delivered_qty    DECIMAL(5,2)      NOT NULL,
    is_holiday_peak  VARCHAR(30)            NOT NULL,
    week_number     INT             NOT NULL,
    month_m         INT             NOT NULL,
    year_y          INT             NOT NULL,
    is_holiday_week    TINYINT        NOT NULL,
    is_summer          TINYINT        NOT NULL,
    is_winter          TINYINT        NOT NULL,
    sku_age            INT            NOT NULL,
    lifecycle_stage    VARCHAR(30)    NOT NULL,
    lag_1              DECIMAL(18,2)  NOT NULL,
    lag_2              DECIMAL(18,2)  NOT NULL,
    rolling_mean_4     DECIMAL(18,2)  NOT NULL,
    rolling_std_4      DECIMAL(18,2)  NOT NULL,
    momentum           DECIMAL(18,2)  NOT NULL,
    target_next_week   DECIMAL(18,2)  NOT NULL,
    price_avg          DECIMAL(10,2)  NOT NULL,
    promo_rate         DECIMAL(10,4)  NOT NULL,
    stock_avg          DECIMAL(18,2)  NOT NULL,
    deliveries         VARCHAR(30)    NOT NULL,
    avg_temp           DECIMAL(10,2)  NOT NULL,
    inflation_index    DECIMAL(18,4)  NOT NULL,
    school_in_session  TINYINT        NOT NULL,
    category_trend     DECIMAL(18,4)  NOT NULL,
    event_score        DECIMAL(10,2)  NOT NULL,
    pack_type   VARCHAR(20)
);
IF OBJECT_ID ('stage.parquet_sales_info1', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info1;
CREATE TABLE stage.parquet_sales_info1(
    date        DATE           NOT NULL,
    sku              VARCHAR(20)    NOT NULL,
    brand            VARCHAR(50)    NOT NULL,
    segment          VARCHAR(50)    NOT NULL,
    category         VARCHAR(50)    NOT NULL,
    channel          VARCHAR(30)    NOT NULL,
    region           VARCHAR(30)    NOT NULL,
    pack_type        VARCHAR(20)    NOT NULL,
    price_unit       DECIMAL(5,2)   NOT NULL,
    promotion_flag   TINYINT        NOT NULL, 
    delivery_days    DECIMAL(5,2)      NOT NULL,
    stock_available  DECIMAL(5,2)      NOT NULL,
    delivered_qty    DECIMAL(5,2)      NOT NULL,
    units_sold       DECIMAL(5,2)      NOT NULL
);
GO
IF OBJECT_ID ('stage.parquet_sales_info2', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info2;
CREATE TABLE stage.parquet_sales_info2(
    date        DATE           NOT NULL,
    sku              VARCHAR(20)    NOT NULL,
    brand            VARCHAR(50)    NOT NULL,
    segment          VARCHAR(50)    NOT NULL,
    category         VARCHAR(50)    NOT NULL,
    channel          VARCHAR(30)    NOT NULL,
    region           VARCHAR(30)    NOT NULL,
    pack_type        VARCHAR(20)    NOT NULL,
    price_unit       DECIMAL(5,2)   NOT NULL,
    promotion_flag   TINYINT        NOT NULL,
    delivery_days    DECIMAL(5,2)      NOT NULL,
    stock_available  DECIMAL(5,2)      NOT NULL,
    delivered_qty    DECIMAL(5,2)      NOT NULL,
    units_sold       DECIMAL(5,2)      NOT NULL 
);
GO
IF OBJECT_ID ('stage.parquet_sales_info3', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info3;
CREATE TABLE stage.parquet_sales_info3(
    date        DATE           NOT NULL,
    sku              VARCHAR(20)    NOT NULL,
    brand            VARCHAR(50)    NOT NULL,
    segment          VARCHAR(50)    NOT NULL,
    category         VARCHAR(50)    NOT NULL,
    channel          VARCHAR(30)    NOT NULL,
    region           VARCHAR(30)    NOT NULL,
    pack_type        VARCHAR(20)    NOT NULL,
    price_unit       DECIMAL(5,2)   NOT NULL,
    promotion_flag   TINYINT        NOT NULL,
    delivery_days    DECIMAL(5,2)      NOT NULL,
    stock_available  DECIMAL(5,2)      NOT NULL,
    delivered_qty    DECIMAL(5,2)      NOT NULL,
    units_sold       DECIMAL(5,2)      NOT NULL
);
GO
IF OBJECT_ID ('stage.parquet_sales_info4', 'U')IS NOT NULL
  DROP TABLE stage.parquet_sales_info4;
CREATE TABLE stage.parquet_sales_info4(
    date        DATE           NOT NULL,
    sku              VARCHAR(20)    NOT NULL,
    brand            VARCHAR(50)    NOT NULL,
    segment          VARCHAR(50)    NOT NULL,
    category         VARCHAR(50)    NOT NULL,
    channel          VARCHAR(30)    NOT NULL,
    region           VARCHAR(30)    NOT NULL,
    pack_type        VARCHAR(20)    NOT NULL,
    price_unit       DECIMAL(5,2)   NOT NULL,
    promotion_flag   TINYINT        NOT NULL,
    delivery_days    DECIMAL(5,2)      NOT NULL,
    stock_available  DECIMAL(5,2)      NOT NULL,
    delivered_qty    DECIMAL(5,2)      NOT NULL,
    units_sold       DECIMAL(5,2)      NOT NULL
);