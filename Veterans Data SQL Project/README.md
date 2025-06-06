-- Data Cleaning Steps

-- Raw Data

-- Screenshot : https://github.com/curlyeje/Elliott_Portfolio/blob/9b0a6767c32628a03dfaa4902811d72a69ea188b/Veterans%20Data%20SQL%20Project/Raw%20Data.png

SELECT * 
FROM veterans_who_used_va_health_care;

-- Cleaned Data

-- Screenshot: https://github.com/curlyeje/Elliott_Portfolio/blob/3017d5c919a54fac20fcbc274e6fef5d448fff5a/Veterans%20Data%20SQL%20Project/Cleaned%20Data.png

SELECT * 
FROM veterans_who_used_va_health_care_cleaned;

-- Will change columns names to make it more readable and accessible
 
ALTER TABLE  veterans_who_used_va_health_care_cleaned
CHANGE `State Name` state_name TEXT(50);

ALTER TABLE  veterans_who_used_va_health_care_cleaned
CHANGE `Percent of Veterans who used VA Health Care` veterans_va_percentage DOUBLE;

ALTER TABLE  veterans_who_used_va_health_care_cleaned
CHANGE `Number of VA Health Care Patients` number_of_va_in_health_care INT;

ALTER TABLE  veterans_who_used_va_health_care_cleaned
CHANGE `Veteran Population` veteran_population DOUBLE;

ALTER TABLE  veterans_who_used_va_health_care_cleaned
CHANGE `Year` year INT;

-- Changed veteran_population to an INT

ALTER TABLE  veterans_who_used_va_health_care_cleaned
CHANGE veteran_population veteran_population INT;

-- ROUNDED percentages to the nearest whole number

SELECT ROUND((veterans_va_percentage) * 100, 0)
FROM veterans_who_used_va_health_care_cleaned;


-- Updated the calculation made on column: 	veterans_va_percentage

UPDATE veterans_who_used_va_health_care_cleaned
SET veterans_va_percentage = ROUND(veterans_va_percentage * 100, 0 ) ;

-- Check to make sure it updated 

-- Screenshot: https://github.com/curlyeje/Elliott_Portfolio/blob/8d025656ec1b55220c6df7028900ceabab6ffcf5/Veterans%20Data%20SQL%20Project/UPDATE%20Statement.png

SELECT veterans_va_percentage
FROM veterans_who_used_va_health_care_cleaned;

-- Will Confirm Calculation Columns (Audit Check)

-- There was 2 states in both the years 2013 and 2015 in which the percentages were not correct. 

 SELECT 
  ROW_NUMBER() OVER (ORDER BY state_name, year) AS row_num,
  state_name, 
  veterans_va_percentage, 
  year,
  ROUND((number_of_va_in_health_care / veteran_population) * 100, 0) AS test_check
FROM veterans_who_used_va_health_care_cleaned
WHERE veterans_va_percentage != ROUND((number_of_va_in_health_care / veteran_population) * 100, 0);

-- Screenshot

-- Will use the DELETE statement to remove these 2 rows from the data. 

DELETE FROM veterans_who_used_va_health_care_cleaned
WHERE ROUND((number_of_va_in_health_care / veteran_population) * 100, 0) != veterans_va_percentage;

-- Exploratory Data Analysis

 # 1. How has the percentage of veterans using VA health care changed over time?
-- In the years of 2010 - 2015, the change was approximately a 526 percentage points of increase on veterans using VA health care over this period of time. 

SELECT year, ROUND(AVG(veterans_va_percentage) * 100, 0) AS avg_va_usage_percent
FROM veterans_who_used_va_health_care_cleaned
GROUP BY year
ORDER BY year;

-- Created a CTE on avg_over_time 

WITH avg_over_time AS (
  SELECT year, 
    ROUND(AVG(veterans_va_percentage) * 100, 0) AS avg_va_usage_percent
  FROM veterans_who_used_va_health_care_cleaned
  GROUP BY year
)
SELECT 
  MAX(avg_va_usage_percent) - MIN(avg_va_usage_percent) AS percent_increase
FROM avg_over_time;

# 2. Which states have the highest and lowest percentage of veterans using VA health care?

-- Puerto Rico has the highest percentage of veterans using VA health care with 54 percent. 
--  Hawaii has the lowest percentage of veterans using VA health care with 16 percent. 

-- To find this answer, will use the MAX aggregate and DENSE RANK them based on the highest vs lowest percentages. 

SELECT state_name, MAX(veterans_va_percentage) as highest_percentage, 
	DENSE_RANK () OVER (ORDER BY MAX(veterans_va_percentage) DESC
    ) AS highest_rankings
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY highest_percentage DESC;

-- Screenshot 

SELECT state_name, MIN(veterans_va_percentage) AS lowest_percentage,
  DENSE_RANK() OVER (ORDER BY MIN(veterans_va_percentage) ASC
  ) AS lowest_rankings
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY lowest_percentage ASC;

-- Screenshot

# 3. How does the veteran population change over time in different states?

-- The overall veteran population does a steady decrease due to mulipltle factors that may possibly include long wait times,
--  geographic barriers, limited services, negative experiences, etc..

SELECT year, state_name,
  SUM(veteran_population) AS veteran_population_per_state,
  SUM(veteran_population) - LAG(SUM(veteran_population)) OVER (PARTITION BY state_name ORDER BY year) AS year_over_year_change
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name, year
ORDER BY state_name, year;

-- Screenshot

# 4. Which states experienced the largest increase in VA health care usage from 2010 to the most recent year? 

-- Florida, California, and Texas had the largest increase in VA health care from 2010 to the most recent year. 

SELECT state_name, MAX(number_of_va_in_health_care) as largest_increase
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY largest_increase DESC ;

# 5. Which states have the most efficient VA outreach (high percentage use with relatively small veteran populations)?

-- Puerto Rico, South Dakota, and Wymoning has the higher percentages of most efficient VA outreach with a smaller veteran population. 

-- Screenshot

SELECT state_name, MAX(veterans_va_percentage) as highest_percentage, MIN(veteran_population) as small_veteran_population
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY highest_percentage DESC, small_veteran_population ASC;

# 6. What was the national average of veterans using VA health care in a given year?
-- The national average of veterans using VA health care in a given was at its highest in 2015 with an average of approx 114,408

-- Screenshot

SELECT year, ROUND(AVG(number_of_va_in_health_care), 2) as national_average
FROM veterans_who_used_va_health_care_cleaned
GROUP BY year;


# 7. Which year had the highest overall percentage of VA health care usage?
-- The year 2015 had the highest overall percentage of VA health care usage with a 54 percent. 

-- Screenshot

SELECT year, MAX(veterans_va_percentage) as highest_percentage
FROM veterans_who_used_va_health_care_cleaned
GROUP BY year
ORDER BY highest_percentage DESC;

# 8. What is the total Veteran Population rounded to the nearest whole number?
-- In the years from 2010 - 2015, the total Veteran Population was approximately 130 million. 

SELECT ROUND(SUM(veteran_population), 0) as total_veteran_population
FROM veterans_who_used_va_health_care_cleaned;

# 9. What is the total Number of VA Patients in Health Care rounded to the nearest whole number.
-- In the years from 2010 - 2015, the total Veteran Population was approximately 40 million.

SELECT ROUND(SUM(number_of_va_in_health_care), 0) as number_of_va_in_health_care
FROM veterans_who_used_va_health_care_cleaned;

# 10. Which top 3 states have the highest population of Veterans?
-- In the years of 2010 - 2015, the top 3 states are California, Texas, and Florida.

SELECT state_name,ROUND(SUM(veteran_population), 0) as veteran_population
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY veteran_population DESC
LIMIT 3;

# 11. Which state had the highest number of VA Health Care Patients in the most recent year? 
-- Florida had the highest number of VA Health Care Patients in 2015 with a total of 504,267. 

-- Screenshot

SELECT MAX(year),state_name, MAX(number_of_va_in_health_care) as num_of_va_in_health_care
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY num_of_va_in_health_care DESC
LIMIT 1;


# 12. Which state had the lowest number of VA Health Care Patients in the most recent year?
-- District of Columbia had the lowest number of VA Health Care Patients in 2015 with a total of 8,226 

-- Screenshot

SELECT MAX(year),state_name, MIN(number_of_va_in_health_care) as num_of_va_in_health_care
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY num_of_va_in_health_care ASC
LIMIT 1;

# 13. Which state had the highest percentage of veterans in the most recent year?
-- Puerto Rico had the highest percentage of veterans in 2015 with 54% 

-- Screenshot

SELECT state_name, MAX(year), MAX(veterans_va_percentage) as veterans_va_percentage
FROM veterans_who_used_va_health_care_cleaned
GROUP BY state_name
ORDER BY veterans_va_percentage DESC;

 


