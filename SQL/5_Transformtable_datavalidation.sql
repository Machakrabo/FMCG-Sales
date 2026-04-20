-- Cleaning data and ensuring Data integrity in transform layer
USE FMCGdb;
GO

/* =================================================================
   SECTION 1: NULL VALUE VERIFICATION
   ================================================================= */
PRINT'== Count the NULL values from the columns=='

PRINT'== NULL count in date column'
SELECT COUNT(*) AS date_null_count FROM transform.consolidated_sales_info WHERE date IS NULL;

PRINT'== NULL count in sku column'
SELECT COUNT(*) AS sku_null_count FROM transform.consolidated_sales_info WHERE sku IS NULL;

PRINT'== NULL count in brand column'
SELECT COUNT(*) AS brand_null_count FROM transform.consolidated_sales_info WHERE brand IS NULL;

PRINT'== NULL count in segment column'
SELECT COUNT(*) AS segment_null_count FROM transform.consolidated_sales_info WHERE segment IS NULL;

PRINT'== NULL count in category column'
SELECT COUNT(*) AS category_null_count FROM transform.consolidated_sales_info WHERE category IS NULL;

PRINT'== NULL channel in channel column'
SELECT COUNT(*) AS channel_null_count FROM transform.consolidated_sales_info WHERE channel IS NULL;

PRINT'== NULL count in region column'
SELECT COUNT(*) AS region_null_count FROM transform.consolidated_sales_info WHERE region IS NULL;

PRINT'== NULL count in pack_type column'
SELECT COUNT(*) AS packtype_null_count FROM transform.consolidated_sales_info WHERE pack_type IS NULL;

PRINT'== NULL count in price_unit column'
SELECT COUNT(*) AS unitprice_null_count FROM transform.consolidated_sales_info WHERE price_unit IS NULL;

PRINT'== NULL count in promotion_flag column'
SELECT COUNT(*) AS promotionalflag_null_count FROM transform.consolidated_sales_info WHERE promotion_flag IS NULL;

PRINT'== NULL count in delivery_days column'
SELECT COUNT(*) AS deliverydays_null_count FROM transform.consolidated_sales_info WHERE delivery_days IS NULL;

PRINT '== NULL count in stock_available column'
SELECT COUNT(*) AS stock_available_null_count FROM transform.consolidated_sales_info WHERE stock_available IS NULL;

PRINT '== NULL count in delivered_qty column'
SELECT COUNT(*) AS delivered_qty_null_count FROM transform.consolidated_sales_info WHERE delivered_qty IS NULL;

PRINT '== NULL count in units_sold column'
SELECT COUNT(*) AS units_sold_null_count FROM transform.consolidated_sales_info WHERE units_sold IS NULL;

PRINT '== NULL count in is_holiday_peak column'
SELECT COUNT(*) AS is_holiday_peak_null_count FROM transform.consolidated_sales_info WHERE is_holiday_peak IS NULL;

PRINT '== NULL count in week_number column'
SELECT COUNT(*) AS week_number_null_count FROM transform.consolidated_sales_info WHERE week_number IS NULL;

PRINT '== NULL count in month_m column'
SELECT COUNT(*) AS month_m_null_count FROM transform.consolidated_sales_info WHERE month_m IS NULL;

PRINT '== NULL count in year_y column'
SELECT COUNT(*) AS year_y_null_count FROM transform.consolidated_sales_info WHERE year_y IS NULL;

PRINT '== NULL count in is_holiday_week column'
SELECT COUNT(*) AS is_holiday_week_null_count FROM transform.consolidated_sales_info WHERE is_holiday_week IS NULL;

PRINT '== NULL count in is_summer column'
SELECT COUNT(*) AS is_summer_null_count FROM transform.consolidated_sales_info WHERE is_summer IS NULL;

PRINT '== NULL count in is_winter column'
SELECT COUNT(*) AS is_winter_null_count FROM transform.consolidated_sales_info WHERE is_winter IS NULL;

PRINT '== NULL count in sku_age column'
SELECT COUNT(*) AS sku_age_null_count FROM transform.consolidated_sales_info WHERE sku_age IS NULL;

PRINT '== NULL count in lifecycle_stage column'
SELECT COUNT(*) AS lifecycle_stage_null_count FROM transform.consolidated_sales_info WHERE lifecycle_stage IS NULL;

PRINT '== NULL count in lag_1 column'
SELECT COUNT(*) AS lag_1_null_count FROM transform.consolidated_sales_info WHERE lag_1 IS NULL;

PRINT '== NULL count in lag_2 column'
SELECT COUNT(*) AS lag_2_null_count FROM transform.consolidated_sales_info WHERE lag_2 IS NULL;

PRINT '== NULL count in rolling_mean_4 column'
SELECT COUNT(*) AS rolling_mean_4_null_count FROM transform.consolidated_sales_info WHERE rolling_mean_4 IS NULL;

PRINT '== NULL count in rolling_std_4 column'
SELECT COUNT(*) AS rolling_std_4_null_count FROM transform.consolidated_sales_info WHERE rolling_std_4 IS NULL;

PRINT '== NULL count in momentum column'
SELECT COUNT(*) AS momentum_null_count FROM transform.consolidated_sales_info WHERE momentum IS NULL;

PRINT '== NULL count in target_next_week column'
SELECT COUNT(*) AS target_next_week_null_count FROM transform.consolidated_sales_info WHERE target_next_week IS NULL;

PRINT '== NULL count in price_avg column'
SELECT COUNT(*) AS price_avg_null_count FROM transform.consolidated_sales_info WHERE price_avg IS NULL;

PRINT '== NULL count in promo_rate column'
SELECT COUNT(*) AS promo_rate_null_count FROM transform.consolidated_sales_info WHERE promo_rate IS NULL;

PRINT '== NULL count in stock_avg column'
SELECT COUNT(*) AS stock_avg_null_count FROM transform.consolidated_sales_info WHERE stock_avg IS NULL;

PRINT '== NULL count in deliveries column'
SELECT COUNT(*) AS deliveries_null_count FROM transform.consolidated_sales_info WHERE deliveries IS NULL;

PRINT '== NULL count in avg_temp column'
SELECT COUNT(*) AS avg_temp_null_count FROM transform.consolidated_sales_info WHERE avg_temp IS NULL;

PRINT '== NULL count in inflation_index column'
SELECT COUNT(*) AS inflation_index_null_count FROM transform.consolidated_sales_info WHERE inflation_index IS NULL;

PRINT '== NULL count in school_in_session column'
SELECT COUNT(*) AS school_in_session_null_count FROM transform.consolidated_sales_info WHERE school_in_session IS NULL;

PRINT '== NULL count in category_trend column'
SELECT COUNT(*) AS category_trend_null_count FROM transform.consolidated_sales_info WHERE category_trend IS NULL;

PRINT '== NULL count in event_score column'
SELECT COUNT(*) AS event_score_null_count FROM transform.consolidated_sales_info WHERE event_score IS NULL;

/* =================================================================
   SECTION 2: GARBAGE VALUE & DISTINCTNESS CHECK
   ================================================================= */
-- garbage value check
SELECT DISTINCT Sku AS distinct_sku FROM transform.consolidated_sales_info;
SELECT DISTINCT brand AS distinct_brand FROM transform.consolidated_sales_info;
SELECT DISTINCT segment AS distinct_segment FROM transform.consolidated_sales_info;
SELECT DISTINCT category AS distinct_category FROM transform.consolidated_sales_info;
SELECT DISTINCT channel AS distinct_channel FROM transform.consolidated_sales_info;
SELECT DISTINCT region AS distinct_region FROM transform.consolidated_sales_info;
SELECT DISTINCT pack_type AS distinct_pack_type FROM transform.consolidated_sales_info;
SELECT DISTINCT price_unit AS distinct_price_unit FROM transform.consolidated_sales_info;
SELECT DISTINCT promotion_flag AS distinct_promotion_flag FROM transform.consolidated_sales_info;
SELECT DISTINCT delivery_days AS distinct_delivery_days FROM transform.consolidated_sales_info;
SELECT DISTINCT stock_available AS distinct_stock_available FROM transform.consolidated_sales_info;
SELECT DISTINCT delivered_qty AS distinct_delivered_qty FROM transform.consolidated_sales_info;
SELECT DISTINCT units_sold AS distinct_units_sold FROM transform.consolidated_sales_info;
SELECT DISTINCT is_holiday_peak AS distinct_is_holiday_peak FROM transform.consolidated_sales_info;
SELECT DISTINCT week_number AS distinct_week_number FROM transform.consolidated_sales_info;
SELECT DISTINCT month_m AS distinct_month_m FROM transform.consolidated_sales_info;
SELECT DISTINCT year_y AS distinct_year_y FROM transform.consolidated_sales_info;
SELECT DISTINCT is_holiday_week AS distinct_is_holiday_week FROM transform.consolidated_sales_info;
SELECT DISTINCT is_summer AS distinct_is_summer FROM transform.consolidated_sales_info;
SELECT DISTINCT is_winter AS distinct_is_winter FROM transform.consolidated_sales_info;
SELECT DISTINCT sku_age AS distinct_sku_age FROM transform.consolidated_sales_info;
SELECT DISTINCT lifecycle_stage AS distinct_lifecycle_stage FROM transform.consolidated_sales_info;
SELECT DISTINCT lag_1 AS distinct_lag_1 FROM transform.consolidated_sales_info;
SELECT DISTINCT lag_2 AS distinct_lag_2 FROM transform.consolidated_sales_info;
SELECT DISTINCT rolling_mean_4 AS distinct_rolling_mean_4 FROM transform.consolidated_sales_info;
SELECT DISTINCT rolling_std_4 AS distinct_rolling_std_4 FROM transform.consolidated_sales_info;
SELECT DISTINCT momentum AS distinct_momentum FROM transform.consolidated_sales_info;
SELECT DISTINCT target_next_week AS distinct_target_next_week FROM transform.consolidated_sales_info;
SELECT DISTINCT price_avg AS distinct_price_avg FROM transform.consolidated_sales_info;
SELECT DISTINCT promo_rate AS distinct_promo_rate FROM transform.consolidated_sales_info;
SELECT DISTINCT stock_avg AS distinct_stock_avg FROM transform.consolidated_sales_info;
SELECT DISTINCT deliveries AS distinct_deliveries FROM transform.consolidated_sales_info;
SELECT DISTINCT avg_temp AS distinct_avg_temp FROM transform.consolidated_sales_info;
SELECT DISTINCT inflation_index AS distinct_inflation_index FROM transform.consolidated_sales_info;
SELECT DISTINCT school_in_session AS distinct_school_in_session FROM transform.consolidated_sales_info;
SELECT DISTINCT category_trend AS distinct_category_trend FROM transform.consolidated_sales_info;
SELECT DISTINCT event_score AS distinct_event_score FROM transform.consolidated_sales_info;

/* =================================================================
   SECTION 3: OUT-OF-BOUNDS & LOGICAL CHECKS
   ================================================================= */
----------------------------------------------------------------------------------------------------------------------------------- 
-- garbage data check
SELECT sku, channel, brand, price_unit FROM transform.consolidated_sales_info WHERE price_unit <0;
SELECT sku, channel, brand, price_unit, price_avg FROM transform.consolidated_sales_info WHERE price_avg <0;
SELECT date, month_m, year_y,week_number FROM transform.consolidated_sales_info WHERE week_number <0;
SELECT sku, channel, brand, stock_available, stock_avg FROM transform.consolidated_sales_info WHERE stock_avg <0;

/* =================================================================
   SECTION 4: SCHEMA METADATA CHECK
   ================================================================= */
--- Data type check
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'consolidated_sales_info';




