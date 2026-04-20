/*
=========================================
Transformation Layer Schema
=========================================
Purpose:
- The Transformation layer stores cleansed, standardized, and conformed data.
- Data from the staging layer is transformed here:
  * Invalid, duplicate, or incomplete records are removed or fixed.
  * Data types are standardized (e.g., converting text to numeric).
  * Business rules are applied to create the extra parameters necessary
- The Silver layer serves as the foundation for analytics and reporting.

Warning:
- Tables in this schema depend on the stage layer as their source.
- Re-running transformations may overwrite data if not handled carefully.
- Always validate ETL jobs before executing in production.

Best Practices:
- Maintain history/audit columns (created_date, updated_date).
- Ensure data conforms to business keys and referential integrity.
- Use partitioning or clustering if tables grow large.
*/

USE FMCGdb;
GO
PRINT '=== Table creation in the transform layer====='
PRINT'=== 1.A common table to load union of all the parquet files=='
GO
--Drop the existing table if it exists
IF OBJECT_ID('transform.consolidated_parquets_sales_info', 'U') IS NOT NULL
    DROP TABLE transform.consolidated_parquets_sales_info;
-- create table
CREATE TABLE transform.consolidated_parquets_sales_info(
    date        DATE ,
    sku              VARCHAR(20),
    brand            VARCHAR(50),
    segment          VARCHAR(50),
    category         VARCHAR(50),
    channel          VARCHAR(30),
    region           VARCHAR(30),
    pack_type        VARCHAR(20),
    price_unit       DECIMAL(5,2),
    promotion_flag   TINYINT,
    delivery_days    DECIMAL(5,2),
    stock_available  DECIMAL(5,2),
    delivered_qty    DECIMAL(5,2),
    units_sold       DECIMAL(5,2) 
    );
PRINT'=== 2.A table to load the enriched files=='
GO
IF OBJECT_ID('transform.enriches_sales_info', 'U') IS NOT NULL
    DROP TABLE transform.enriches_sales_info;
-- create table
CREATE TABLE transform.enriches_sales_info(
    sku              VARCHAR(20),
    date             DATE,
    channel          VARCHAR(30),
    region           VARCHAR(30),
    units_sold       DECIMAL(5,2),
    stock_available  DECIMAL(5,2),
    promotion_flag   TINYINT,
    price_unit       DECIMAL(5,2),
    delivery_days    DECIMAL(5,2),
    delivered_qty    DECIMAL(5,2),
    is_holiday_peak  VARCHAR(30),
    week_number     INT,
    month_m         INT,
    year_y          INT,
    is_holiday_week    TINYINT,
    is_summer          TINYINT,
    is_winter          TINYINT,
    sku_age            INT,
    lifecycle_stage    VARCHAR(30),
    lag_1              DECIMAL(18,2),
    lag_2              DECIMAL(18,2),
    rolling_mean_4     DECIMAL(18,2),
    rolling_std_4      DECIMAL(18,2),
    momentum           DECIMAL(18,2),
    target_next_week   DECIMAL(18,2),
    price_avg          DECIMAL(10,2),
    promo_rate         DECIMAL(10,4),
    stock_avg          DECIMAL(18,2),
    deliveries         VARCHAR(30),
    avg_temp           DECIMAL(10,2),
    inflation_index    DECIMAL(18,4),
    school_in_session  TINYINT,
    category_trend     DECIMAL(18,4),
    event_score        DECIMAL(10,2),
    pack_type   VARCHAR(20)
);
PRINT'=== 3.A main file that stores all data =='
-- Drop the existing table if it exists
IF OBJECT_ID('transform.consolidated_sales_info', 'U') IS NOT NULL
    DROP TABLE transform.consolidated_sales_info;
-- Create the table
CREATE TABLE transform.consolidated_sales_info(

    date        DATE,
    sku              VARCHAR(20),
    brand            VARCHAR(50),
    segment          VARCHAR(50),
    category         VARCHAR(50),
    channel          VARCHAR(30),
    region           VARCHAR(30),
    pack_type        VARCHAR(20),
    price_unit       DECIMAL(5,2),
    promotion_flag   TINYINT,
    delivery_days    DECIMAL(5,2),
    stock_available  DECIMAL (5,2),
    delivered_qty    DECIMAL(5,2),
    units_sold       DECIMAL(5,2),
    is_holiday_peak  VARCHAR(30),
    week_number      INT,   
    month_m          INT,
    year_y           INT,
    is_holiday_week  TINYINT,
    is_summer        TINYINT,
    is_winter        TINYINT,
    sku_age          INT,
    lifecycle_stage  VARCHAR (50),
    lag_1            DECIMAL,
    lag_2            DECIMAL,
    rolling_mean_4   DECIMAL,
    rolling_std_4    DECIMAL,
    momentum         DECIMAL,
    target_next_week DECIMAL,
    price_avg        DECIMAL,
    promo_rate       DECIMAL, 
    stock_avg        DECIMAL,
    deliveries       VARCHAR,
    avg_temp         DECIMAL,
    inflation_index  DECIMAL,
    school_in_session TINYINT,
    category_trend   DECIMAL,
    event_score      DECIMAL
);
GO