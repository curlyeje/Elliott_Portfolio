-- This dataset was taken from data.gov and was inputted from the State of California. Contains counts of inpatient 
-- hospitalizations and emergency department visits for patients with Behavioral Health Disorders.

-- count refers to the Total Mental Health inpatient hospitalization discharges or emergency department visits per demographic category value.

-- total refers to the Total inpatient hospitalization discharges or emergency department visits per demographic category value.

-- percent refers to the Percent of All inpatient hospitalization discharges or emergency department visits per demographic category value.


SELECT *
FROM hospital_encounters_for_behavioral_health_cleaned;

-- Data Cleaning Steps

-- Will clean the data by removing backticks from column names using the ALTER TABLE function. 
-- This will help make it easily accessible and more readable. 

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Year` year INT;

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Geography` geography TEXT(50);

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Pattype` patient_type TEXT(50);

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Category` category TEXT(50);

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Cat_desc` demographic_category_value TEXT(50);

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Dxgroup` diagnosis_group TEXT(50);

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Count` count INT;

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Total` total INT;

ALTER TABLE hospital_encounters_for_behavioral_health_cleaned
CHANGE `Percent` percent DOUBLE;

-- Will use the ROUND function to change percent column to nearest 2 decimal places

SELECT *, ROUND(percent, 2) as percentages
FROM hospital_encounters_for_behavioral_health_cleaned;

-- Will use the UPDATE statement to update percent column 

UPDATE hospital_encounters_for_behavioral_health_cleaned
SET percent = ROUND(percent, 2);

-- Will check to make sure UPDATE worked correctly. It worked. 

Hospital Encounters SQL Project/UPDATE screenshot.png
	
SELECT *
FROM hospital_encounters_for_behavioral_health_cleaned;

-- Exploratory Data Analysis

-- 1. How have mental health disorders changed over time? 

-- Used an advance window function to find the rolling total of the Mental Health inpatients hospitalization discharges or 
-- emergency department visits. There has been an influx of patients from the years of 2020 - 2022

SELECT year, SUM(count) as total_count, 
SUM(SUM(count)) OVER (ORDER BY year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS rolling_total
FROM hospital_encounters_for_behavioral_health_cleaned
GROUP BY year
ORDER BY year ASC;

-- 2. Which year had the highest number of behavioral health-related hospital encounters? 

-- The year 2022 had the highest number of behavioral health-related hosptial encounters with a total of 317,653,552

SELECT year, SUM(total)
FROM hospital_encounters_for_behavioral_health_cleaned
GROUP BY year
ORDER BY year DESC;

-- 3. What proportion of total hospital discharges were due to substance use disorders? 

-- The proportion of total hospital discharges was 6.36% due to substance use disorders. 

SELECT diagnosis_group, ROUND(SUM(percent), 2)
FROM hospital_encounters_for_behavioral_health_cleaned
WHERE diagnosis_group = 'Substance Use Disorders' ;


-- 4. Which patient type (inpatient vs. emergency) shows higher behavioral health service usage? 

-- Inpatient vs. emegency visits shows there being the same number at 216 totaling up to 432 rows. 

SELECT patient_type, COUNT(patient_type)
FROM hospital_encounters_for_behavioral_health_cleaned
GROUP BY patient_type;


-- 5. What are the top 3 leading demographic category values? 
-- All Discharges (including other diagnosis not listed), Female, and Male are the most in the Inpatient hospitalization discharges or ED visits 

SELECT demographic_category_value, SUM(count) as demographic_count
FROM hospital_encounters_for_behavioral_health_cleaned
GROUP BY demographic_category_value
ORDER BY demographic_count DESC
LIMIT 3;

--  6. What are the lowest demographic category values? 
--  American Indian/Alaska Native, Other Payer, and Uninsured are the lowest in the Inpatient hospitalization discharges or ED visits

SELECT demographic_category_value, SUM(count) as demographic_count
FROM hospital_encounters_for_behavioral_health_cleaned
GROUP BY demographic_category_value
ORDER BY demographic_count ASC
LIMIT 3;

-- 7. What is the total demographic category value? 
--   Total is 219,078,738

SELECT SUM(count)
FROM hospital_encounters_for_behavioral_health_cleaned;







					









