TRUNCATE TABLE stage.csv_sales_info;
BULK INSERT stage.csv_sales_info
FROM 'D:\Documents\Maloshree\DATA ANALYTICS CERTIFICATION-INCO\Capstone Project\Data\FMCG_2022_2024.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR =',',
	ROWTERMINATOR = '0x0a',
	FORMAT='CSV',
	CODEPAGE ='65001',
	TABLOCK
);
GO
SELECT COUNT(*)FROM stage.csv_sales_info;

GO
TRUNCATE TABLE stage.csv_weekly_enriched_sales_info;
BULK INSERT stage.csv_weekly_enriched_sales_info
FROM 'D:\Documents\Maloshree\DATA ANALYTICS CERTIFICATION-INCO\Capstone Project\Data\df_weekly_MI-006_enriched.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR =',',
	ROWTERMINATOR = '0x0a',
	FORMAT='CSV',
	CODEPAGE ='65001',
	TABLOCK
);
GO
SELECT COUNT(*)FROM stage.csv_weekly_enriched_sales_info;
GO
SELECT COUNT(*)FROM stage.parquet_sales_info1;
GO
SELECT COUNT(*)FROM stage.parquet_sales_info2;
GO
SELECT COUNT(*) FROM stage.parquet_sales_info3;
GO
SELECT COUNT(*) FROM stage.parquet_sales_info4;