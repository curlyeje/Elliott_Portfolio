-- World Life Expectancy Project (Exploratory Data Analysis)

SELECT * 
FROM worldlifeexpectancy
;

-- Will check for the past 15 years on MIN and MAX of life expectancy per country 

-- Top 3 countries Haiti, Zimbabwe, and Eritrea have increased their life expectancy over 15 years by over 20+ years.


SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 1) AS Life_Increase_Over_15_Years
FROM worldlifeexpectancy
GROUP BY Country 
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_Over_15_Years DESC
;


-- We have increased by 6 years as a world from 2007 - 2022

SELECT Year, ROUND(AVG(`Life expectancy`), 2) 
FROM worldlifeexpectancy
GROUP BY Year 
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Year ASC
;


-- Lower GDP's are correlated with lower life expectancies 

-- Higher GDP's are correlated with higher life expectancies

SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(GDP), 1) AS GDP 
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;

-- Will compare 1326 Rows towards the High GDP life expectancies which is 74. 

-- Will take the inverse of it, row count was 1612 for low GDP countries and the life expectancy was 65. 


SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) Low_GDP_Life_Expectancy
FROM worldlifeexpectancy
;

-- Take average and round to the 1st decimal place on life expectancy comparing developed to developing countries. 

SELECT Status, ROUND(AVG(`Life expectancy`), 1) 
FROM worldlifeexpectancy
GROUP BY Status
;

-- There are many countries that are still in developing phase, 161 developed vs 32 developed.

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`), 1) 
FROM worldlifeexpectancy
GROUP BY Status
;

-- Compare the country to the life expectancy with respect to BMI. 

SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp, ROUND(AVG(BMI), 1) AS BMI
FROM worldlifeexpectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI ASC
;

-- Will check the rolling total of adult mortalities per country. Filtered on USA which has a rolling total of 931 from 2007-2022

SELECT Country, 
Year, 
`Life expectancy`,
`Adult Mortality`, 
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM worldlifeexpectancy
WHERE Country LIKE 'United%'
;
