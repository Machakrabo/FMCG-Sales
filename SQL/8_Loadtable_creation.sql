/*
=========================================
Load Layer Schema
=========================================
Purpose:
- The load layer is the final storage layer.
- Only data loading is from tansform layer and Python.
- Ready to use data for visualization


Best Practices:
- Use schema-qualified names
- Avoid making schema changes directly in production without testing.
- Use DROP TABLE IF EXISTS if you want to re-create tables safely.
*/
----------------------------------
GO
USE FMCGdb;
GO
-------------------------------------
/* create a staging schema-- One time creation*/
--CREATE SCHEMA load;
/*create a table under the schema*/
------------------------------------
GO
IF OBJECT_ID('load.consolidated_sales_info', 'U') IS NOT NULL
    DROP TABLE load.consolidated_sales_info;
GO
CREATE TABLE load.consolidated_sales_info(
    date             DATE,
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
    event_score      DECIMAL,
    stockout_flag	TINYINT, -- If stock_available was 0 but demand was likely present (CASE WHEN stock_available <= 0 THEN 1 ELSE 0 END)
	inventory_turnover_ratio DECIMAL(10, 2), -- units_sold / stock_available. High ratios indicate high velocity SKUs that need tighter forecast accuracy (your 85% goal)
	days_to_next_delivery	DECIMAL(10,2),--"mitigating lead times," this column helps the model see the impact of the gap between deliveries.
	promo_intensity DECIMAL(10,2), --(price_avg - price_unit) / price_avg. This quantifies the "depth" of the discount.
	is_npi_flag TINYINT,-- A binary (0/1). 1 if the SKU has been active for less than, say, 12 weeks.
	predicted_units_sold DECIMAL(18,2) -- Forecast.
);
