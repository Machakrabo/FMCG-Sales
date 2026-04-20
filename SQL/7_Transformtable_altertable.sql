GO
USE FMCGdb
GO
/* =================================================================
   SECTION 1: COLUMN ADDITION
   ================================================================= */
ALTER TABLE transform.consolidated_sales_info
ADD 
	stockout_flag	TINYINT, -- If stock_available was 0 but demand was likely present (CASE WHEN stock_available <= 0 THEN 1 ELSE 0 END)
	inventory_turnover_ratio DECIMAL(10, 2), -- units_sold / stock_available. High ratios indicate high velocity SKUs that need tighter forecast accuracy (your 85% goal)
	days_to_next_delivery	DECIMAL(10,2),--"mitigating lead times," this column helps the model see the impact of the gap between deliveries.
	promo_intensity DECIMAL(10,2), --(price_avg - price_unit) / price_avg. This quantifies the "depth" of the discount.
	is_npi_flag TINYINT,-- A binary (0/1). 1 if the SKU has been active for less than, say, 12 weeks.
	predicted_units_sold DECIMAL(18,2); -- Forecast.

/* =================================================================
   SECTION 2: SCHEMA METADATA CHECK
   ================================================================= */
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'consolidated_sales_info';