PRINT '== Load Data into load.consolidated_sales_info ==';

IF EXISTS (SELECT 1 FROM load.consolidated_sales_info)
BEGIN
    TRUNCATE TABLE load.consolidated_sales_info;
END
GO

-- Insert data from the transformation layer into the loading layer
INSERT INTO load.consolidated_sales_info 
SELECT * FROM transform.consolidated_sales_info;
GO

-- Final Verification
SELECT COUNT(*) AS total_rows_loaded FROM load.consolidated_sales_info;
GO
