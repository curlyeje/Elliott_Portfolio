-- World Life Expetancy (Data Cleaning Project) 

-- Backup table was added as RAW Data 

-- Will pull up table that needs to be worked on

SELECT * 
FROM worldlifeexpectancy;

-- Will check for duplicates 

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM worldlifeexpectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;

-- Need to remove the 3 duplicates

-- Will use the Window function Row_NUMBER and will PARTITION BY  


SELECT * 
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM worldlifeexpectancy) AS Row_table
    WHERE Row_Num > 1
;
Screenshot 2025-05-31 at 12.18.17 PM

-- Now that we have identified the 3 duplicates, will use DELETE FROM to remove duplicates.

DELETE FROM worldlifeexpectancy
WHERE 
	Row_ID IN ( 
SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(		Country, Year)) AS Row_Num
	FROM worldlifeexpectancy) AS Row_table
    WHERE Row_Num > 1
    )
;

-- Noticed some blanks in the Status column, will further investigate

SELECT * 
FROM worldlifeexpectancy
WHERE Status = ''
;

-- Used the SELECT DISTINCT statment to find what the attributes are for Status column

SELECT DISTINCT(Status) 
FROM worldlifeexpectancy
WHERE Status <> ''
;

SELECT DISTINCT(Country)
FROM worldlifeexpectancy
WHERE Status = 'Developing'
;


-- This update did not work

UPDATE worldlifeexpectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
				FROM worldlifeexpectancy
				WHERE Status = 'Developing')
;
   
 --   Will need to JOIN the table to itself in order to populate the values as developing and developed respectively
   
UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;


-- Checking for blank field in value for USA 

SELECT * 
FROM worldlifeexpectancy
WHERE Country = 'United States of America'
;

-- Need to update table with respect to populating field for USA to status of developed.

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

-- Will check the Life expectancy column for blank fields

SELECT Country, Year, `Life expectancy`
FROM worldlifeexpectancy
WHERE `Life expectancy` = ''
;

--  Will filter out to know how many rows are blank for column Life expectancy 


SELECT Country, Year, `Life expectancy`
FROM worldlifeexpectancy
WHERE `Life expectancy` = ''
;


-- Will take the average of the following year plus the previous year, and will divide by 2


SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year -1
JOIN worldlifeexpectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year +1
WHERE t1.`Life expectancy` = ''
;


    UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year -1
JOIN worldlifeexpectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year +1
    SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT * 
FROM worldlifeexpectancy
;





    
    



