SELECT DISTINCT
	ISNULL (StratificationCategoryId1, 'NA') stratcatid1,
	ISNULL (StratificationCategory1, 'NA') statcat1
FROM [dbo].[Transformed_Nutrition]