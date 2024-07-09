USE MASTER

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DimensionalNutricion')
BEGIN
CREATE DATABASE DimensionalNutricion;

END
GO

IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DimensionalNutricion')
BEGIN
USE DimensionalNutricion;


IF OBJECT_ID('[DimLocation]', 'U') IS NOT NULL DROP TABLE [DimLocation];
IF OBJECT_ID('[DimClass]', 'U') IS NOT NULL DROP TABLE [DimClass];
IF OBJECT_ID('[DimTopic]', 'U') IS NOT NULL DROP TABLE [DimTopic];
IF OBJECT_ID('[DimQuestion]', 'U') IS NOT NULL DROP TABLE [DimQuestion];
IF OBJECT_ID('[DimStratCat1]', 'U') IS NOT NULL DROP TABLE [DimStratCat1];
IF OBJECT_ID('[DimStrat1]', 'U') IS NOT NULL DROP TABLE [DimStrat1];
IF OBJECT_ID('[DimAge]', 'U') IS NOT NULL DROP TABLE [DimAge];
IF OBJECT_ID('[DimEducation]', 'U') IS NOT NULL DROP TABLE [DimEducation];
IF OBJECT_ID('[DimGender]', 'U') IS NOT NULL DROP TABLE [DimGender];
IF OBJECT_ID('[DimIncome]', 'U') IS NOT NULL DROP TABLE [DimIncome];
IF OBJECT_ID('[DimRace]', 'U') IS NOT NULL DROP TABLE [DimRace];
IF OBJECT_ID('[FactNutricion]', 'U') IS NOT NULL DROP TABLE [FactNutricion];



CREATE TABLE DimLocation(
	LocationID TINYINT PRIMARY KEY,
	LocationAbbr NVARCHAR(50),
	LocationDesc NVARCHAR(50),
	Latitude DECIMAL(12,9),
	Longitude DECIMAL(12,9)
);

CREATE TABLE DimClass(
	ClassID NVARCHAR(50) PRIMARY KEY,
	Class NVARCHAR(50)
);

CREATE TABLE DimTopic(
	TopicID NVARCHAR(50) PRIMARY KEY,
	Topic NVARCHAR(50)
);

CREATE TABLE DimQuestion(
	QuestionID FLOAT PRIMARY KEY,
	Question NVARCHAR(250)
);

CREATE TABLE DimStratCat1(
	StratificationCategoryId1 NVARCHAR(50) PRIMARY KEY,
	StratificationCategory1 NVARCHAR(50)
);

CREATE TABLE DimStrat1(
	StratificationID1 NVARCHAR(50) PRIMARY KEY,
	Stratification1 NVARCHAR(50)
);

CREATE TABLE DimAge(
	AgeID INT PRIMARY KEY,
	Age_years NVARCHAR(50)
);

CREATE TABLE DimEducation(
	EducationID INT PRIMARY KEY,
	Education NVARCHAR(50)
);

CREATE TABLE DimGender(
	GenderID INT PRIMARY KEY,
	Gender NVARCHAR(50)
);

CREATE TABLE DimIncome(
	IncomeID INT PRIMARY KEY,
	Income NVARCHAR(50)
);

CREATE TABLE DimRace(
	RaceID INT PRIMARY KEY,
	Race_Ethnicity NVARCHAR(50)
);

CREATE TABLE FactNutricion(
	NutricionID INT PRIMARY KEY,
	Data_Value float,
	Low_Confidence_Limit float,
	High_Confidence_Limit float,
	Sample_Size float,
	YearStart smallint,
	YearEnd smallint,
	LocationID tinyint,
	ClassID NVARCHAR(50),
	TopicID NVARCHAR(50),
	QuestionID FLOAT,
	StratificationCategoryId1 NVARCHAR(50),
	StratificationID1 NVARCHAR(50),
	AgeID INT,
	EducationID INT,
	GenderID INT,
	IncomeID INT,
	RaceID INT,
	FOREIGN KEY (LocationID) REFERENCES DimLocation(LocationID),
	FOREIGN KEY (ClassID) REFERENCES DimClass(ClassID),
	FOREIGN KEY (TopicID) REFERENCES DimTopic(TopicID),
	FOREIGN KEY (QuestionID) REFERENCES DimQuestion(QuestionID),
	FOREIGN KEY (StratificationCategoryId1) REFERENCES DimStratCat1(StratificationCategoryId1),
	FOREIGN KEY (StratificationID1) REFERENCES DimStrat1(StratificationID1),
	FOREIGN KEY (AgeID) REFERENCES DimAge(AgeID),
	FOREIGN KEY (EducationID) REFERENCES DimEducation(EducationID),
	FOREIGN KEY (GenderID) REFERENCES DimGender(GenderID),
	FOREIGN KEY (IncomeID) REFERENCES DimIncome(IncomeID),
	FOREIGN KEY (RaceID) REFERENCES DimRace(RaceID)
);

END
GO