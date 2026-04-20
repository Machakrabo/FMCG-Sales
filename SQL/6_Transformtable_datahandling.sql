/* =================================================================
   SECTION 1: DATABASE INITIALIZATION
   ================================================================= */
USE FMCGdb;
GO

/* =================================================================
   SECTION 2: DATE & TIME FEATURE TRANSFORMATION
   ================================================================= */
-- Data transformation
-- Handling Null values

PRINT'==Verifying month numbers and regenerating months from dates==';
UPDATE transform.consolidated_sales_info SET month_m = MONTH (date);
SELECT COUNT(*) FROM transform.consolidated_sales_info WHERE month_m IS NULL;
SELECT COUNT(month_m) FROM transform.consolidated_sales_info;
SELECT DISTINCT (month_m) FROM transform.consolidated_sales_info ORDER BY month_m ASC ;
---------------------------------------------------------------------------------------------------------------------
GO

PRINT'==Verifying year and regenerating months from dates==';
UPDATE transform.consolidated_sales_info SET year_y = YEAR (date);
SELECT COUNT(*) FROM transform.consolidated_sales_info WHERE year_y IS NULL;
SELECT COUNT(year_y) FROM transform.consolidated_sales_info;
SELECT DISTINCT (year_y) FROM transform.consolidated_sales_info ORDER BY year_y ASC ;
------------------------------------------------------------------------------------------------------------------
GO 

PRINT '===Generate Week numbers=='
UPDATE transform.consolidated_sales_info SET week_number = DATEPART(week, date);
SELECT DISTINCT (week_number) FROM transform.consolidated_sales_info;
SELECT COUNT(week_number)AS nullWeeks FROM transform.consolidated_sales_info WHERE week_number IS NULL
SELECT COUNT(week_number) AS oddlyGeneratedWeeks FROM transform.consolidated_sales_info WHERE week_number >53;
---------------------------------------------------------------------------------------------------------------------

/* =================================================================
   SECTION 3: DUPLICATE RECORD HANDLING
   ================================================================= */
-- handling Duplicate rercords

PRINT '== Identifying duplicate records =='
SELECT date, sku, region,channel, segment, COUNT(*) as row_instances
FROM transform.consolidated_sales_info
GROUP BY date, sku, region, channel, segment HAVING COUNT(*) > 1;
GO
PRINT '== Removing duplicate records ==';
WITH CTE AS (
    SELECT *, 
    ROW_NUMBER() OVER (
        PARTITION BY date, sku, region, channel 
        ORDER BY date
    ) AS row_num
    FROM transform.consolidated_sales_info
)
DELETE FROM CTE WHERE row_num > 1;

PRINT'=== COUNT the total number of records in the table==='
SELECT COUNT(*) AS Records_after_cleaning FROM transform.consolidated_sales_info;
-------------------------------------------------------------------------------------------------------------------

/* =================================================================
   SECTION 4: SEASONALITY LOGIC (WINTER/SUMMER)
   ================================================================= */
-- handling other Null values
GO

PRINT'==Generate is winter=='
-- Understand data
SELECT 
    year_y, 
    is_winter,
    COUNT(*) AS total_days
FROM transform.consolidated_sales_info
GROUP BY year_y, is_winter;

-- Ambiguous is winter values noted, the winter months are december, jannuary and february
UPDATE transform.consolidated_sales_info
SET is_winter = CASE 
    WHEN month_m IN (12, 1, 2) THEN 1 
    ELSE 0 END;

-- check the results after fixing
SELECT 
    year_y, 
    COUNT(DISTINCT date) AS actual_winter_days
FROM transform.consolidated_sales_info
WHERE is_winter = 1
GROUP BY year_y;
------------------------------------------------------------------------------------------------------------------

PRINT'==Generate is summer=='
-- Understand data
SELECT 
    year_y, 
    is_summer,
    COUNT(*) AS total_summerdays
FROM transform.consolidated_sales_info
GROUP BY year_y, is_summer;

-- Ambiguous is winter values noted, the winter months are december, jannuary and february
UPDATE transform.consolidated_sales_info
SET is_Summer = CASE 
    WHEN month_m IN (6, 7, 8) THEN 1 
    ELSE 0 END;

-- check the results after fixing
SELECT 
    year_y, 
    COUNT(DISTINCT date) AS actual_summerdays
FROM transform.consolidated_sales_info
WHERE is_summer = 1
GROUP BY year_y;
------------------------------------------------------------------------------------------------------------------

/* =================================================================
   SECTION 5: NULL HANDLING FOR SKU
   ================================================================= */
PRINT'==NULL handling for SKU=='
GO
-- Understand the data
SELECT brand, segment, category, channel, COUNT(DISTINCT sku) AS sku_count
FROM transform.consolidated_sales_info 
GROUP BY brand, segment, category, channel HAVING COUNT(DISTINCT sku) > 1;

-- creat a lookup table
IF OBJECT_ID('tempdb..#SKUlookup') IS NOT NULL DROP TABLE #SKUlookup;
SELECT DISTINCT brand,segment, category, channel, sku
INTO #SKUlookup
FROM transform.consolidated_sales_info
WHERE sku IS NOT NULL AND sku <>'N/A';

-- update the NULL values using the lookup table
UPDATE target
SET target.sku = lookup.sku
FROM transform.consolidated_sales_info AS target
INNER JOIN #SKUlookup AS lookup 
    ON target.brand = lookup.brand 
    AND target.segment = lookup.segment
    AND target.category = lookup.category
    AND target.channel = lookup.channel
WHERE target.sku IS NULL OR target.sku = 'N/A';
-----------------------------------------------------------------------------------------------------------------------------------------
GO
/* =================================================================
   SECTION 5: NULL HANDLING FOR SKU AGE
   ================================================================= */
PRINT'==NULL handling for SKU age=='
GO
-- Understand the data
-- 1. Create the lookup table using only valid numeric ages
IF OBJECT_ID('tempdb..#SKUagelookup') IS NOT NULL DROP TABLE #SKUagelookup;

SELECT DISTINCT 
    sku, 
    MAX(sku_age) as sku_age  -- Use MAX to get the most recent age if multiple exist
INTO #SKUagelookup
FROM transform.consolidated_sales_info
WHERE sku_age IS NOT NULL 
GROUP BY sku;

-- 2. Update the NULL values
UPDATE target
SET target.sku_age = lookup.sku_age
FROM transform.consolidated_sales_info AS target
INNER JOIN #SKUagelookup AS lookup 
    ON target.sku = lookup.sku
WHERE target.sku_age IS NULL;

SELECT  sku, sku_age,lifecycle_stage  FROM transform.consolidated_sales_info;
GO
UPDATE transform.consolidated_sales_info
SET lifecycle_stage = CASE 
    WHEN sku_age IS NULL THEN NULL
    WHEN sku_age BETWEEN 1 AND 12 THEN 'Growth'
    WHEN sku_age BETWEEN 13 AND 52 THEN 'Mature'
    WHEN sku_age >= 53 THEN 'Decline'
    ELSE ''
END;





------------------------------------------------------------------------------------------------------------------------------
GO
/* =================================================================
   SECTION 6: NULL HANDLING FOR BRAND & SEGMENTS
   ================================================================= */
PRINT'=== NULL handling for segments=='
GO
SELECT brand, sku, channel, COUNT( DISTINCT segment) AS segment_count
FROM transform.consolidated_sales_info 
GROUP BY brand, sku, channel HAVING COUNT(DISTINCT segment) = 1;

-- creat a lookup table
IF OBJECT_ID('tempdb..#brandlookup') IS NOT NULL DROP TABLE #brandlookup;
SELECT DISTINCT brand,segment, category, channel, sku
INTO #brandlookup
FROM transform.consolidated_sales_info
WHERE brand IS NOT NULL AND brand <>'N/A';

-- update the NULL values using the lookup table
UPDATE target
SET target.brand = lookup.brand
FROM transform.consolidated_sales_info AS target
INNER JOIN #brandlookup AS lookup 
    ON target.sku = lookup.sku
WHERE target.brand IS NULL OR target.brand = 'N/A';
GO

SELECT DISTINCT brand,sku,channel,segment AS distinct_segment FROM transform.consolidated_sales_info;
---------------------------------------------------------------------------------------------------------------------------------------------
GO

PRINT'==NULL handling for brand=='
GO
-- Understand the data
SELECT 
    sku, 
    segment, 
    category, 
    COUNT(DISTINCT brand) AS brand_count
FROM transform.consolidated_sales_info
GROUP BY sku, segment, category
HAVING COUNT(DISTINCT brand) > 1;

--HAVING COUNT(DISTINCT brand) = 1; -- if distinct values are present 
-- 1. Clean up any old temp tables
IF OBJECT_ID('tempdb..#brandlookup') IS NOT NULL DROP TABLE #brandlookup;
SELECT DISTINCT sku, segment, category, brand INTO #brandlookup FROM transform.consolidated_sales_info
WHERE brand IS NOT NULL AND brand <> 'N/A';

-- 3. Update the NULL brands
UPDATE target
SET target.brand = lookup.brand
FROM transform.consolidated_sales_info AS target
INNER JOIN #brandlookup AS lookup 
    ON target.sku = lookup.sku
    AND target.segment = lookup.segment
    AND target.category = lookup.category
WHERE (target.brand IS NULL OR target.brand = 'N/A');

SELECT sku, segment, category, COUNT(*) as count_still_missing
FROM transform.consolidated_sales_info
WHERE brand IS NULL OR brand = 'N/A'
GROUP BY sku, segment, category;
-----------------------------------------------------------------------------------------------------------------------------------------------

/* =================================================================
   SECTION 7: NULL HANDLING FOR CATEGORIES & PACKTYPE
   ================================================================= */
PRINT'=== NULL handling for categories=='
GO
SELECT 
    brand, 
    channel, 
    segment, 
    COUNT(DISTINCT category) AS category_count
FROM transform.consolidated_sales_info 
GROUP BY 
    brand, 
    channel, 
    segment
HAVING COUNT(DISTINCT category) = 1;

--- we see that brand and category are related
-- creat a lookup table
IF OBJECT_ID('tempdb..#categorylookup') IS NOT NULL DROP TABLE #categorylookup;
SELECT DISTINCT brand,segment, category, channel, sku
INTO #categorylookup
FROM transform.consolidated_sales_info
WHERE category IS NOT NULL AND category <>'N/A';

-- update the NULL values using the lookup table
UPDATE target
SET target.category = lookup.category
FROM transform.consolidated_sales_info AS target
INNER JOIN #categorylookup AS lookup 
    ON target.brand = lookup.brand
WHERE target.category IS NULL OR target.category = 'N/A';
GO
SELECT COUNT(category) FROM transform.consolidated_sales_info WHERE brand IS NULL;
---------------------------------------------------------------------------------------------------------------------------------------------

PRINT'=== NULL handling for packtype=='
GO
SELECT brand,segment, sku, channel, COUNT( pack_type) AS packtype_count
FROM transform.consolidated_sales_info 
GROUP BY brand,segment,sku, channel HAVING COUNT(DISTINCT pack_type) > 1;

-- creat a lookup table
IF OBJECT_ID('tempdb..#packtypelookup') IS NOT NULL DROP TABLE #packtypelookup;
SELECT DISTINCT brand,segment, category, channel, sku, pack_type
INTO #packtypelookup
FROM transform.consolidated_sales_info
WHERE pack_type IS NOT NULL AND pack_type <>'N/A' AND pack_type != '';

-- update the NULL values using the lookup table
UPDATE target
SET target.pack_type = lookup.pack_type
FROM transform.consolidated_sales_info AS target
INNER JOIN #packtypelookup AS lookup 
    ON target.sku = lookup.sku
    AND target.brand = lookup.brand
    AND target.segment = lookup.segment
    AND target.channel = lookup.channel
WHERE target.pack_type IS NULL OR target.pack_type = 'N/A' OR target.pack_type =' ';
GO
SELECT COUNT(pack_type) FROM transform.consolidated_sales_info WHERE brand IS NULL;
SELECT DISTINCT pack_type FROM transform.consolidated_sales_info;
-----------------------------------------------------------------------------------------------------------------------------------------
GO