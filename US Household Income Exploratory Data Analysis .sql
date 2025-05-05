-- US Household Income Exploratory Data Analysis

SELECT * 
FROM us_household_income
;

SELECT * 
FROM us_household_income_statistics
;

-- Look at SUM for Area of Land, biggest land is Alaska

SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC 
;

-- Alaska has the biggest area of water

SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC 
;

-- Top 10 By Land 

SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC 
LIMIT 10
;

-- Top 10 By Water 

SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10 
;

-- Will JOIN both tables together 

SELECT * 
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;


SELECT u.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0;


-- Will explore the top 10 states with the highest household income

SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;


SELECT Type, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 1 DESC
LIMIT 10
;


SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 3 DESC
LIMIT 20
;


SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 4 DESC
LIMIT 20
;

SELECT * 
FROM us_household_income
WHERE Type = 'Community'
;


SELECT Type, COUNT(Type),ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
LIMIT 20
;

SELECT u.State_Name
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
