SELECT
	TN.Data_Value,
	TN.Low_Confidence_Limit,
	TN.High_Confidence_Limit,
	TN.Sample_Size,
	TN.YearStart,
	TN.YearEnd,
	TN.LocationID,
	TN.ClassID,
	TN.TopicID,
	TN.QuestionID,
	TN.StratificationCategoryId1,
	TN.StratificationID1,
	DA.AgeID,
	DE.EducationID,
	DG.GenderID,
	DI.IncomeID,
	DR.RaceID
	FROM nutricion.dbo.Transformed_Nutrition TN
	LEFT JOIN DimensionalNutricion.dbo.DimAge DA ON DA.Age_years = TN.Age_years
	LEFT JOIN DimensionalNutricion.dbo.DimEducation DE ON DE.Education = TN.Education
	LEFT JOIN DimensionalNutricion.dbo.DimGender DG ON DG.Gender = TN.Gender
	LEFT JOIN DimensionalNutricion.dbo.DimIncome DI ON DI.Income = TN.Income
	LEFT JOIN DimensionalNutricion.dbo.DimRace DR ON DR.Race_Ethnicity = TN.Race_Ethnicity