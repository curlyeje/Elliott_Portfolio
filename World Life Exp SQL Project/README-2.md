The World Life Expectancy Project was completed in MYSQL Workbench. The data consisted of different countries that had a specific 
population whom life expectancy fluctuates depending on key factors such as BMI, Diseases, Adult Mortality, etc... Data was collected 
from 2007 all the way up to 2022.

Here is my final visualization of this project using Tableau: 
https://public.tableau.com/app/profile/elliott.earley/viz/WorldLifeExpectancyProject_17556279430760/Dashboard1


Data Cleaning Steps: 

-- Checked for duplicates by using the Window Function ROW_NUMBER() OVER(PARTITION BY) and used CONCAT the Country and Year. 
3 duplicates were found
-- There were some blank values in the Status, life expectancy, and country columns so did some further invesigation. 
-- In order to identify the duplicates, I needed to use a JOIN clause to the same table in order to populate the values 
as developing and developed. 


Exploratory Data Analysis: 

-- Checked for the past 15 years on the MIN and MAX life expectancy per country. The top 3 were Haiti, Zimbabwe, and Eritrea 
over 15 years by over 20+ years. 
-- The world has increased the life expectancy by 6 years from 2007 - 2022. 
-- Found that lower GDP's were correlated with lower life expectancies and higher GDP's were correlated with higher life expectancies
-- The High GDP life expectancy age was 74. 
-- The lower GDP life expectancy age was 65. 



-- Found that there are many countries that are still in developing phase, 161 developing vs 32 developed
-- Compared countries to life expectancy that are related to BMI (Body Mass Indexes)
-- The United States of America adult mortalities had a rolling total of 931 from 2007 - 2022.
