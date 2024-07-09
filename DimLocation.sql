SELECT DISTINCT LocationID, 
	LocationAbbr, 
	LocationDesc,
	isnull(Latitude,0) lat,
	isnull (Longitude,0) long
FROM Transformed_Nutrition
order by 1