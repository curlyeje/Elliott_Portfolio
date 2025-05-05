-- US Household Income Data Cleaning


SELECT * 
FROM us_household_income
;

SELECT * 
FROM us_household_income_statistics
;

SELECT COUNT(id)
FROM us_household_income
;

SELECT COUNT(id)
FROM us_household_income_statistics
;

-- Will identify duplicates by taking the count of id and filtering greater than 1

SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

-- Created a subquery to filter on row_num being greater than 1 

SELECT * 
FROM (
SELECT row_id, 
id, 
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income
) AS duplicates
WHERE row_num > 1
;

-- Will remove duplicates by using the DELETE statement 

DELETE FROM us_household_income
WHERE row_id IN (
		SELECT row_id 
		FROM (
		SELECT row_id, 
		id, 
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income
		) AS duplicates
WHERE row_num > 1)
;

-- Checked for duplicates in the statistics table, there were none.

SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

-- Will check the DISTINCT states to identify if we need to standardize data in this column. Will order by the 1st column.

SELECT DISTINCT State_Name 
FROM us_household_income
GROUP BY State_Name
ORDER BY 1
;

-- Will update State name column "georia" to "Georgia"

UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

-- Will update state name column from "alabama" to "Alabama"

UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;


-- Will check for blank value in place in order to populate it with Autaugaville

SELECT *
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

-- UPDATE statement to populate place to Autaugaville

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

-- Will filter on Type column to identify possible types that are the same

SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;

-- Will use UPDATE STATEMENT to change "Boroughs" to "Borough" since they are the same type

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

-- Will check the awater and aland columns 

SELECT DISTINCT Awater, Aland
FROM us_household_income 
WHERE Aland = 0 OR Aland = ''  OR Aland IS NULL
;




