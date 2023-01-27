USE japan_real_estate_data
GO

-- PHASE 1: DATABASE SETUP --

-- remove columns that are irrelvant to project

ALTER TABLE aichi_23
DROP COLUMN MunicipalityCode, FloorPlan, Structure, Use, Breadth, CityPlanning, CoverageRatio, FloorAreaRatio, Period

ALTER TABLE kanagawa_14
DROP COLUMN MunicipalityCode, FloorPlan, Structure, Use, Breadth, CityPlanning, CoverageRatio, FloorAreaRatio, Period

ALTER TABLE osaka_27
DROP COLUMN MunicipalityCode, FloorPlan, Structure, Use, Breadth, CityPlanning, CoverageRatio, FloorAreaRatio, Period

ALTER TABLE Saitama_11
DROP COLUMN MunicipalityCode, FloorPlan, Structure, Use, Breadth, CityPlanning, CoverageRatio, FloorAreaRatio, Period

ALTER TABLE tokyo_13
DROP COLUMN MunicipalityCode, FloorPlan, Structure, Use, Breadth, CityPlanning, CoverageRatio, FloorAreaRatio, Period

-- remove rows from prefecture table that is irrelvant for current scope
DELETE FROM prefecture_code
WHERE Code NOT IN ( 23, 14, 27, 11, 13 );

-- establish a primary key to create relation with other tables
-- need a column to be NOT NULL in order to declare as primary key
ALTER TABLE prefecture_code
ALTER COLUMN Code int NOT NULL;

ALTER TABLE prefecture_code
ADD PRIMARY KEY (Code);
-- create stored procedure to add prefecture_code column to every table and update it with the pre-determiend prefecture code
-- created a stored procedure so that it is reproduceable and therefore scalable for future operations if company decides to include other prefectures
GO
CREATE PROCEDURE add_foreign_key @table varchar(100), @prefecture_code int

AS
BEGIN
	DECLARE @SQL VARCHAR(200), @SQL2 VARCHAR(200)

	SET @SQL = CONCAT('alter table ', @table, ' add prefecture_code int')
	SET @SQL2 = CONCAT('update ', @table, ' set prefecture_code = ', @prefecture_code, ' where prefecture_code is null')

	print @SQL
	print @SQL2
	EXEC (@SQL)
	EXEC (@SQL2)
END
-- add foreign key columns to every table 
EXEC add_foreign_key @table = 'aichi_23', @prefecture_code = 23
EXEC add_foreign_key @table = 'kanagawa_14' , @prefecture_code = 14
EXEC add_foreign_key @table = 'osaka_27' , @prefecture_code = 27
EXEC add_foreign_key @table = 'Saitama_11', @prefecture_code = 11
EXEC add_foreign_key @table = 'tokyo_13', @prefecture_code = 13


-- create stored procedure that declares a prefecture_code column as foreign key and connects it with primary key in prefecture_code table
GO
CREATE PROCEDURE connect_PK_FK @table varchar(100)

AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @SQL VARCHAR(200)
	SET @SQL = CONCAT('alter table ', @table, ' add foreign key ( prefecture_code ) references prefecture_code ( Code )' )

	EXEC (@SQL)
END

-- execution of stored procedures
EXECUTE connect_PK_FK @table = 'aichi_23'
EXECUTE connect_PK_FK @table = 'kanagawa_14'
EXECUTE connect_PK_FK @table = 'osaka_27'
EXECUTE connect_PK_FK @table = 'Saitama_11'
EXECUTE connect_PK_FK @table = 'tokyo_13'


-- create stored procedure that changes the datatype into appropriate dataypes
GO
CREATE PROCEDURE change_datatype @table varchar(100)

AS
BEGIN
	SET NOCOUNT ON
	DECLARE @SQL VARCHAR(MAX)

	SET @SQL = CONCAT('ALTER TABLE ', @table, ' ALTER COLUMN MinTimeToNearestStation TINYINT; ALTER TABLE ', @table, ' ALTER COLUMN MaxTimeToNearestStation TINYINT; ALTER TABLE ', 
					   @table, ' ALTER COLUMN TradePrice BIGINT; ALTER TABLE ', @table, ' ALTER COLUMN Area INT; ALTER TABLE ', @table, ' ALTER COLUMN UnitPrice INT; ALTER TABLE ', 
					   @table, ' ALTER COLUMN Frontage FLOAT; ALTER TABLE ', @table, ' ALTER COLUMN TotalFloorArea INT; ALTER TABLE ', @table, ' ALTER COLUMN BuildingYear INT; ') 


	PRINT @SQL
	EXEC(@SQL)
END

-- execute stored procedure
EXEC change_datatype @table = 'aichi_23'
EXEC change_datatype @table = 'kanagawa_14'
EXEC change_datatype @table = 'osaka_27'
EXEC change_datatype @table = 'saitama_11'
EXEC change_datatype @table = 'tokyo_13'

-- END OF PHASE 1 --

-- PHASE 2: DATA DISCOVERY --

-- Finding out basic information about the dataset. Finding what columns may be combined to generate useful insights

-- Started off with what types of building we have in the dataset
SELECT DISTINCT Type
FROM tokyo_13 -- given that we are mainly focusing on residential buildings, we are going to ignore Forest Land and Agricultural Land from the dataset

-- Next, I counted how many of each type of building there are
SELECT Type, COUNT(Type) AS TypeCount
FROM tokyo_13
GROUP BY Type
ORDER BY TypeCount DESC -- Pre-owned condominiums seems to be the dominant type. Followed by Residential Land(Land and Building) and Residential Land(Land Only)

-- Average TradePrice per Building Type
SELECT Type, AVG(TradePrice) AS AverageTradePricePerType
FROM tokyo_13
WHERE DistrictName NOT IN('', '(No Address)') AND Type NOT IN ('Forest Land', 'Agricultural Land')
GROUP BY Type
ORDER BY AverageTradePricePerType DESC -- Residential Land(Land and Building) and Residential Land(Land Only) have the highest average TradePrice


-- Finding the Average Trade Price per district and what type of building it is. There were some outliers that were misrepresenting the
-- averages, making it seem like some districts had the highest average, but there were only a handful of rows of that district.
-- So, I filtered out any districts that have less than 200 (median) appearances in the dataset. 
SELECT Type, DistrictName, AVG(TradePrice) AveragePerDistrict
FROM tokyo_13
WHERE DistrictName NOT IN('', '(No Address)') AND Type NOT IN ('Forest Land', 'Agricultural Land')
GROUP BY Type, DistrictName
HAVING COUNT(DistrictName) >= 200
ORDER BY AveragePerDistrict DESC

-- In Tokyo, Shakujiidai, Shimotakaido, and Akatsutsumi have the highest average Trade Price.

-- Location is important in Japan, especially since many people don't own cars, homes that are near train stations are likely to be valued at a higher price due to its utility
SELECT MinTimeToNearestStation, AVG(TradePrice) AS AvgTradePrice
FROM tokyo_13
GROUP BY MinTimeToNearestStation
HAVING MinTimeToNearestStation != 0
ORDER BY AvgTradePrice DESC; -- as you can see from this, locations that are close or relatively close to train stations tend to have a higher trade price


/*
Analyses:
		- step 1: Highest COUNT of building Type in each prefecture
			- Find average TradePrice for each Municipality
				- Find average TradePrice for each DistrictName
					- Divide TradePrice by Area to find PricePerArea
						- Find the lowest ratio to find the best places
						- Justify by finding the average MinTimeToNearestStation
*/

-- step 1
-- Returns the building type with the highest count per prefecture
GO
CREATE VIEW HighestTypeCount
AS 
SELECT EnName, Type, COUNT(Type) as highesttypecount
FROM prefecture_code p
JOIN aichi_23 a on p.Code = a.prefecture_code
GROUP BY EnName, Type
HAVING COUNT(Type)= (SELECT MAX(mycount) FROM ( 
												SELECT Type, Count(Type) AS mycount FROM aichi_23 group by Type
												) a
					)
					
UNION

SELECT EnName, Type, COUNT(Type) as highesttypecount
FROM prefecture_code p
JOIN tokyo_13 a on p.Code = a.prefecture_code
GROUP BY EnName, Type
HAVING COUNT(Type)= (SELECT MAX(mycount) FROM ( 
												SELECT Type, Count(Type) AS mycount FROM tokyo_13 group by Type
												) a
					)
					
UNION

SELECT EnName, Type, COUNT(Type) as highesttypecount
FROM prefecture_code p
JOIN kanagawa_14 a on p.Code = a.prefecture_code
GROUP BY EnName, Type
HAVING COUNT(Type)= (SELECT MAX(mycount) FROM ( 
												SELECT Type, Count(Type) AS mycount FROM kanagawa_14 group by Type
												) a
					) 
UNION

SELECT EnName, Type, COUNT(Type) as highesttypecount
FROM prefecture_code p
JOIN osaka_27 a on p.Code = a.prefecture_code
GROUP BY EnName, Type
HAVING COUNT(Type)= (SELECT MAX(mycount) FROM ( 
												SELECT Type, Count(Type) AS mycount FROM osaka_27 group by Type
												) a
					)

UNION

SELECT EnName, Type, COUNT(Type) as highesttypecount
FROM prefecture_code p
JOIN saitama_11 a on p.Code = a.prefecture_code
GROUP BY EnName, Type
HAVING COUNT(Type)= (SELECT MAX(mycount) FROM ( 
												SELECT Type, Count(Type) AS mycount FROM saitama_11 group by Type
												) a
					) 

SELECT * FROM HighestTypeCount

/* It looks like Aichi has Residential Land(Land Only) as its highest count, and Tokyo has pre-owned condominiums as its highest. The other three have Land and Building as the highest count*/
-- Given that Japan as a country is not very large, it is uncommon to see large mansions or estates. Only the ultra rich are able to afford the land to build such a home
-- The average size of a home in Japan is around 93 square meters, or about 1000 square feet. Many Japanese people live in an apartment or condominium complexes that range from 3 to 12 stories high.

select * from tokyo_13;




GO 
CREATE VIEW [Trade Price To Area] 
AS
WITH cte_aichi AS(
SELECT TOP 1 EnName, Type, Municipality, AVG(TradePrice) AS AvgTradePrice, AVG(TradePrice / Area ) AS TradePriceToArea, COUNT(Municipality) AS MUNICOUNT
FROM prefecture_code p
INNER JOIN aichi_23 a on p.Code = a.prefecture_code
WHERE Type NOT IN ('Agricultural Land', 'Forest Land') AND Type = 'Residential Land(Land Only)'
GROUP BY EnName, Type, Municipality
HAVING COUNT(Municipality) >1000
ORDER BY TradePriceToArea ASC),

cte_kanagawa AS(
SELECT TOP 1 EnName, Type, Municipality, AVG(TradePrice) AS AvgTradePrice, AVG(TradePrice / Area ) AS TradePriceToArea, COUNT(Municipality) AS MUNICOUNT
FROM prefecture_code p
INNER JOIN kanagawa_14 k ON p.Code = k.prefecture_code
WHERE Type = 'Residential Land(Land and Building)'
GROUP BY EnName, Type, Municipality
HAVING COUNT(Municipality) > 1000
ORDER BY TradePriceToArea ASC),

cte_osaka AS(
SELECT TOP 1 EnName, Type, Municipality, AVG(TradePrice) AS AvgTradePrice, AVG(TradePrice / Area ) AS TradePriceToArea, COUNT(Municipality) AS MUNICOUNT
FROM prefecture_code p
INNER JOIN osaka_27 k ON p.Code = k.prefecture_code
WHERE Type = 'Residential Land(Land and Building)'
GROUP BY EnName, Type, Municipality
HAVING COUNT(Municipality) > 1000
ORDER BY TradePriceToArea ASC),

cte_saitama AS(
SELECT TOP 1 EnName, Type, Municipality, AVG(TradePrice) AS AvgTradePrice, AVG(TradePrice / Area ) AS TradePriceToArea, COUNT(Municipality) AS MUNICOUNT
FROM prefecture_code p
INNER JOIN saitama_11 k ON p.Code = k.prefecture_code
WHERE Type = 'Residential Land(Land and Building)'
GROUP BY EnName, Type, Municipality
HAVING COUNT(Municipality) > 1000
ORDER BY TradePriceToArea ASC),

cte_tokyo AS(
SELECT TOP 1 EnName, Type, Municipality, AVG(TradePrice) AS AvgTradePrice, AVG(TradePrice / Area ) AS TradePriceToArea, COUNT(Municipality) AS MUNICOUNT
FROM prefecture_code p
INNER JOIN tokyo_13 k ON p.Code = k.prefecture_code
WHERE Type = 'Pre-owned Condominiums'
GROUP BY EnName, Type, Municipality
HAVING COUNT(Municipality) > 1000
ORDER BY TradePriceToArea ASC)

SELECT * FROM cte_aichi
UNION
SELECT * FROM cte_kanagawa
UNION
SELECT * FROM cte_osaka
UNION
SELECT * FROM cte_saitama
UNION
SELECT * FROM cte_tokyo


SELECT * FROM [Trade Price To Area]
-- Answers the "where" question. Now need to answer the "what" question by finding out what characterstics of a building we should be looking for.
select *, (AverageTradePrice / Area ) AS AvgTradePriceToArea from [Most Common Area with Trading price]



GO
CREATE VIEW [Most Common Area with Trading price]
AS


WITH cte_aichi_23 AS
( SELECT TOP 3 EnName, Type, Area, AVG(TradePrice) AS AverageTradePrice, COUNT(Area) AS AreaCount
FROM prefecture_code p
INNER JOIN aichi_23 a  ON p.Code = a.prefecture_code
GROUP BY EnName, Type, Area
ORDER BY AreaCount DESC
),
cte_kanagawa_14 AS
( SELECT TOP 3 EnName, Type, Area, AVG(TradePrice) AS AverageTradePrice, COUNT(Area) AS AreaCount
FROM prefecture_code p
INNER JOIN kanagawa_14 k on p.Code = k.prefecture_code
GROUP BY EnName, Type, Area
ORDER BY AreaCount DESC
), cte_osaka_27 AS
( SELECT TOP 3 EnName, Type, Area, AVG(TradePrice) AS AverageTradePrice, COUNT(Area) AS AreaCount
FROM prefecture_code p
INNER JOIN osaka_27 o ON p.Code = o.prefecture_code
GROUP BY EnName, Type, Area
ORDER BY AreaCount DESC 
), cte_saitama_11 AS
(SELECT TOP 3 EnName, Type, Area, AVG(s.TradePrice) AS AverageTradePrice, COUNT(s.Area) AS AreaCount
FROM prefecture_code p
INNER JOIN saitama_11 s on p.Code = s.prefecture_code
GROUP BY EnName, Type, Area
ORDER BY AreaCount DESC
), cte_tokyo_13 AS
(SELECT TOP 3 EnName, Type, Area, AVG(t.TradePrice) AS AverageTradePrice, COUNT(T.Area) AS AreaCount
FROM prefecture_code p
INNER JOIN tokyo_13 t on p.Code = t.prefecture_code
GROUP BY EnName, Type, Area
ORDER BY AreaCount DESC

)

SELECT * FROM cte_aichi_23
UNION
SELECT * FROM cte_kanagawa_14
UNION
SELECT * FROM cte_osaka_27
UNION
SELECT * FROM cte_saitama_11
UNION
SELECT * FROM cte_tokyo_13

select *, (AverageTradePrice / Area ) AS AvgTradePriceToArea from [Most Common Area with Trading price]



-- run Most Common Area with Trading price view
select * from [Most Common Area with Trading price]
-- looks like most people live in a pre-owned condominium rather than a residential building like a house. Especially in Tokyo, where the top 5 most common areas are all Pre-owned condominums


--This view allows us to see how many of each type of land is available in each prefecture. 

-- idk what this is, I don't think it works
GO
CREATE VIEW [Types of Land per Prefecture] AS

SELECT *
FROM
(
	SELECT EnName, Type, Area
	FROM prefecture_code p
	JOIN tokyo_13 t ON p.Code = t.prefecture_code
) AS SourceTable PIVOT( COUNT(Area) FOR Type IN ([Forest Land],
												 [Residential Land(Land Only)],
												 [Pre-Owned Condominiums],
												 [Residential Land(Land and Building)],
												 [Agricultural Land])) AS PivotTable
UNION

SELECT *
FROM
(
	SELECT EnName, Type, Area
	FROM prefecture_code p
	JOIN saitama_11 s ON p.Code = s.prefecture_code
) AS SourceTable PIVOT( COUNT(Area) FOR Type IN ([Forest Land],
												 [Residential Land(Land Only)],
												 [Pre-Owned Condominiums],
												 [Residential Land(Land and Building)],
												 [Agricultural Land])) AS PivotTable
UNION

SELECT *
FROM
(
	SELECT EnName, Type, Area
	FROM prefecture_code p
	JOIN kanagawa_14 k ON p.Code = k.prefecture_code
) AS SourceTable PIVOT( COUNT(Area) FOR Type IN ([Forest Land],
												 [Residential Land(Land Only)],
												 [Pre-Owned Condominiums],
												 [Residential Land(Land and Building)],
												 [Agricultural Land])) AS PivotTable
UNION

SELECT *
FROM
(
	SELECT EnName, Type, Area
	FROM prefecture_code p
	JOIN osaka_27 o ON p.Code = o.prefecture_code
) AS SourceTable PIVOT( COUNT(Area) FOR Type IN ([Forest Land],
												 [Residential Land(Land Only)],
												 [Pre-Owned Condominiums],
												 [Residential Land(Land and Building)],
												 [Agricultural Land])) AS PivotTable
UNION

SELECT *
FROM
(
	SELECT EnName, Type, Area
	FROM prefecture_code p
	JOIN aichi_23 a ON p.Code = a.prefecture_code
) AS SourceTable PIVOT( COUNT(Area) FOR Type IN ([Forest Land],
												 [Residential Land(Land Only)],
												 [Pre-Owned Condominiums],
												 [Residential Land(Land and Building)],
												 [Agricultural Land])) AS PivotTable

SELECT EnName, [Residential Land(Land Only)], [Pre-Owned Condominiums], [Residential Land(Land and Building)]
FROM [Types of Land per Prefecture]
ORDER BY [Residential Land(Land and Building)] DESC
/*As we can see from this table:
	- Tokyo's highest Building Type is Pre-Owned Condominiums
	- Osaka, Kanagawa, and Saitama have Residential Land(Land and Building) as their most common building type
	- Aichi's most common building type is Residential Land(Land Only)
*/




GO
SELECT Type, Area, AVG(TradePrice) AS AverageTradePrice, COUNT(Area) AS CondoCount
FROM saitama_11
WHERE Type = 'Pre-owned Condominiums'
GROUP BY Type, Area
ORDER BY COUNT(Area) DESC, AverageTradePrice DESC -- In Condominiums, most people have an area between 50-80 square meters

SELECT Type, Area, AVG(TradePrice) AS AverageTradePrice, COUNT(Area) AS ResLandAndBuildingCount
FROM saitama_11
WHERE Type = 'Residential Land(Land and Building)'
GROUP BY Type, Area
ORDER BY COUNT(Area) DESC, AverageTradePrice DESC --in Residential land (land and building), most people have an area between 100-130

SELECT Type, Area, AVG(TradePrice) AS AverageTradePrice, COUNT(Area) AS ResLandOnlyCount
FROM saitama_11
WHERE Type = 'Residential Land(Land Only)'
GROUP BY Type, Area
ORDER BY COUNT(Area) DESC, AverageTradePrice DESC --in Residential land (land only), most people have an area between 100-165


SELECT avg_res_land_price, AVG(TradePrice)
FROM prefecture_code p
INNER JOIN saitama_11 s ON p.Code = s.prefecture_code
WHERE Type = 'Residential Land(Land Only)'
GROUP BY avg_res_land_price

-- Creates a view that calculates the average trade price per prefecture
GO
CREATE VIEW [Average Trade Price Per Prefecture]
AS

SELECT EnName, AVG(a.TradePrice) AverageTradePricePerPrefecture
FROM prefecture_code p
JOIN aichi_23 a on p.Code = a.prefecture_code
GROUP BY EnName

UNION

SELECT EnName, AVG(k.TradePrice) AverageTradePricePerPrefecture
FROM prefecture_code p 
JOIN kanagawa_14 k on p.Code = k.prefecture_code
GROUP BY EnName

UNION

SELECT EnName, AVG(o.TradePrice) AverageTradePricePerPrefecture
FROM prefecture_code p 
JOIN osaka_27 o on p.Code = o.prefecture_code
GROUP BY EnName

UNION 

SELECT EnName, AVG(s.TradePrice) AverageTradePricePerPrefecture
FROM prefecture_code p 
JOIN saitama_11 s on p.Code = s.prefecture_code
GROUP BY EnName

UNION

Select EnName, AVG(t.TradePrice) AverageTradePricePerPrefecture
FROM prefecture_code p
JOIN tokyo_13 t on p.Code = t.prefecture_code
GROUP BY EnName

select * from [Average Trade Price Per Prefecture]
--Tokyo has the highest average trade prices for real estate, but it has also has the highest count of buildings as well and a high cost of living. 
--Tokyo is also a very popular destination for business trips, personal vacations, and tourism in general. As the capital of the country, it has many attractive qualities
-- that draw people to it. 


select * from prefecture_code

select * from aichi_23

select * from [Most Common Area with Trading price]


GO
CREATE VIEW [Most Common Area with Trading Price RowNumber] AS
SELECT *, ROW_NUMBER() OVER (PARTITION BY EnName ORDER BY EnName) RowNumber
FROM [Most Common Area with Trading price]

SELECT * FROM [Most Common Area with Trading Price RowNumber]

select * from [Average Trade Price Per Prefecture]
select * from HighestTypeCount
select * from [Trade Price To Area]