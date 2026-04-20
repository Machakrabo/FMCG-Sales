-- Data loading in the transformation schema
GO 

USE FMCGdb;
GO

/* =================================================================
   SECTION 1: LOAD CONSOLIDATED PARQUET SALES INFO
   ================================================================= */
PRINT '== Load data in transform.consolidated_parquets_sales_info'

IF EXISTS ( SELECT 1 FROM transform.consolidated_parquets_sales_info)
BEGIN
	TRUNCATE TABLE transform.consolidated_parquets_sales_info;
END
-- Otherwise
GO

INSERT INTO transform.consolidated_parquets_sales_info
SELECT * FROM stage.csv_sales_info 
UNION ALL
SELECT * FROM stage.parquet_sales_info1 
UNION ALL
SELECT * FROM stage.parquet_sales_info2 
UNION ALL
SELECT * FROM stage.parquet_sales_info3 
UNION ALL
SELECT * FROM stage.parquet_sales_info4;
GO

SELECT * FROM transform.consolidated_parquets_sales_info;
SELECT COUNT(*) FROM transform.consolidated_parquets_sales_info;
GO

/* =================================================================
   SECTION 2: LOAD ENRICHED SALES INFO
   ================================================================= */
--Data load into transform.enriches_sales_info
PRINT '== Load Data into transform.enriches_sales_info=='

IF EXISTS ( SELECT 1 FROM transform.enriches_sales_info)
BEGIN
	TRUNCATE TABLE transform.enriches_sales_info;
END
-- Otherwise
GO

INSERT INTO transform.enriches_sales_info
SELECT * FROM stage.csv_weekly_enriched_sales_info;
GO

SELECT * FROM transform.enriches_sales_info;
SELECT COUNT(*) FROM transform.enriches_sales_info;
GO

/* =================================================================
   SECTION 3: CONSOLIDATION INTO MAIN TABLE
   ================================================================= */
-- Data load into the main file
PRINT '== Load Data into transform.consolidated_sales_info=='

IF EXISTS (SELECT 1 FROM transform.consolidated_sales_info)
BEGIN
    TRUNCATE TABLE transform.consolidated_sales_info;
END
--Otherwise
GO

INSERT INTO transform.consolidated_sales_info (
    date, sku, brand, segment, category, channel, region, pack_type, price_unit, promotion_flag, 
    delivery_days, stock_available, delivered_qty, units_sold, is_holiday_peak, week_number, 
    month_m, year_y, is_holiday_week, is_summer, is_winter, sku_age, lifecycle_stage, 
    lag_1, lag_2, rolling_mean_4, rolling_std_4, momentum, target_next_week, price_avg, 
    promo_rate, stock_avg, deliveries, avg_temp, inflation_index, school_in_session, 
    category_trend, event_score)
SELECT 
    date, sku, brand, segment, category, channel, region, pack_type, price_unit, promotion_flag, 
    delivery_days, stock_available,delivered_qty, units_sold, 
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- Fills for holiday/time columns
    NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, -- Fills for lags/rolling stats
    NULL, NULL, NULL, NULL, NULL, NULL                   -- Fills for external factors
FROM transform.consolidated_parquets_sales_info
UNION ALL
SELECT 
    date, sku, NULL, NULL, NULL, channel, region, pack_type, price_unit, promotion_flag, 
    delivery_days, stock_available, delivered_qty, units_sold, is_holiday_peak, week_number, 
    month_m, year_y, is_holiday_week, is_summer, is_winter, sku_age, lifecycle_stage, 
    lag_1, lag_2, rolling_mean_4, rolling_std_4, momentum, target_next_week, price_avg, 
    promo_rate, stock_avg, deliveries, avg_temp, inflation_index, school_in_session, 
    category_trend, event_score
FROM transform.enriches_sales_info;
GO 

SELECT * FROM transform.consolidated_sales_info;
SELECT COUNT(*) FROM transform.consolidated_sales_info;
GO