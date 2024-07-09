USE MASTER
GO
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'nutricion')
BEGIN
USE nutricion;

IF OBJECT_ID('[Transformed_Nutrition]', 'U') IS NOT NULL DROP TABLE [Transformed_Nutrition];

CREATE TABLE Transformed_Nutrition (
    YearStart SMALLINT NULL,
    YearEnd SMALLINT NULL,
    LocationAbbr NVARCHAR(50) NULL,
    LocationDesc NVARCHAR(50) NULL,
    Class NVARCHAR(50) NULL,
    Topic NVARCHAR(50) NULL,
    Question NVARCHAR(250) NULL,
    Data_Value FLOAT NULL,
    Data_Value_Alt FLOAT NULL,
    Low_Confidence_Limit FLOAT NULL,
    High_Confidence_Limit FLOAT NULL,
    Sample_Size INT NULL,
    Age_years NVARCHAR(50) NULL,
    Education NVARCHAR(50) NULL,
    Gender NVARCHAR(50) NULL,
    Income NVARCHAR(50) NULL,
    Race_Ethnicity NVARCHAR(50) NULL,
    GeoLocation NVARCHAR(50) NULL,
    ClassID NVARCHAR(50) NULL,
    TopicID NVARCHAR(50) NULL,
    QuestionID FLOAT NULL,
    DataValueTypeID NVARCHAR(50) NULL,
    LocationID TINYINT NULL,
    StratificationCategory1 NVARCHAR(50) NULL,
    Stratification1 NVARCHAR(50) NULL,
    StratificationCategoryId1 NVARCHAR(50) NULL,
    StratificationID1 NVARCHAR(50) NULL,
	Latitude DECIMAL(12,9) NULL,
	Longitude DECIMAL(12,9) NULL
);

END
GO