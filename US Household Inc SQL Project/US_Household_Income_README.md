# U.S. Household Income Project

This project was conducted in **MySQL Workbench**, focusing on **U.S.
Household Income** data segmented by **State, City, and Income Type**.\
An additional table, `statistics`, was **INNER JOINED** with the main
dataset to calculate **mean and median values**, enabling comparisons
across different regions and income categories.\
The ultimate goal was to determine which areas are performing well in
terms of income distribution, while also uncovering geographic and
demographic patterns.

📊 [View the Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/USHouseholdIncomeProject/Dashboard1#1)

------------------------------------------------------------------------

## Data Cleaning Process

To ensure accuracy and consistency, several cleaning and validation
steps were performed:

1.  **Statistics Table**
    -   No data cleaning required, as the `statistics` table was already
        well-structured and ready for analysis.
2.  **Main Household Income Table**
    -   **Duplicate Records**: Identified duplicates using the
        `ROW_NUMBER() OVER(PARTITION BY ...)` window function,
        leveraging the `ID` column (primary key).
```sql
SELECT * 
FROM (
SELECT row_id, 
id, 
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_household_income_cleaned
) AS duplicates
WHERE row_num > 1
;
```
        
    -   Removed unnecessary or redundant entries to maintain dataset
        integrity.
```sql
DELETE FROM us_household_income_cleaned
WHERE row_id IN (
		SELECT row_id 
		FROM (
		SELECT row_id, 
		id, 
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_household_income_cleaned
		) AS duplicates
WHERE row_num > 1)
;
```
3.  **Column Adjustments**
    -   **State_Name**: Corrected grammatical inconsistencies and
        standardized capitalization with the `UPDATE` statement.
```sql
UPDATE us_household_income_cleaned
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;
```

    -   **Missing Values**: Populated missing county and city names
        using cross-referenced data.

```sql
UPDATE us_household_income_cleaned
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;
```
  
    -   **Type Column**: Standardized inconsistent naming conventions
        for income categories.
```sql
UPDATE us_household_income_cleaned
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;
```
  
    -   **ALand (Land Area) & AWater (Water Area)**: Inspected for `0`
        or `NULL` values, ensuring complete and reliable entries.

  ```sql
SELECT DISTINCT Awater, Aland
FROM us_household_income_cleaned
WHERE Aland = 0 OR Aland = ''  OR Aland IS NULL
;
```

------------------------------------------------------------------------

## Exploratory Data Analysis (EDA)

After cleaning, exploratory queries were conducted to extract meaningful
insights. Key findings include:

1.  **Geographic Observations**
    -   **Alaska and Texas** emerged as the states with the largest land
        areas.\
    -   **Alaska** also reported the most extensive water area.\
    -   Identified the **Top 10 states by land area** and **Top 10
        states by water area** for geographic distribution analysis.

        <img width="2078" height="1050" alt="Area of Land by State" src="https://github.com/user-attachments/assets/66d0abcf-e1ad-4d01-8941-edf35ad8fa0e" />

        <img width="2582" height="1016" alt="Area of Water by State" src="https://github.com/user-attachments/assets/df597d0f-4070-498e-b2bc-9b6398d8a630" />


2.  **Household Income Rankings**
    -   Ranked the **Top 10 states by average household income**:
        -   The **District of Columbia** led with the highest average
            household income.\
    -   Identified the **Bottom 5 states by average household income**:
        -   **Puerto Rico** recorded the lowest figures.
3.  **Regional and Demographic Insights**
    -   **Municipalities** recorded the **highest average household
        income** overall.\
    -   **Urban and Community areas** displayed the **lowest averages**,
        highlighting economic disparities.\
    -   **Census Designated Places (CDPs)** reported an average U.S.
        household income of **\$116,376**.\
    -   At the city level, **Delta Junction, Alaska** reported the
        **highest average household income at \$242,857**.

        <img width="2078" height="1050" alt="Area of Land by State" src="https://github.com/user-attachments/assets/eea6418e-ed87-4c4a-a211-ab155d5b2e6a" />

        <img width="704" height="704" alt="Area of Water by Type" src="https://github.com/user-attachments/assets/b8337fd0-2e6b-4b35-9945-06b54a81e2f4" />



------------------------------------------------------------------------

## Key Insights

-   **Geographic scale** (land and water area) can influence income
    distribution across states.\
-   While wealth is concentrated in certain regions (e.g., District of
    Columbia), **systemic disparities remain evident** across states and
    territories.\
-   **Municipalities outperform urban and community regions**,
    suggesting structural or policy-driven differences in income
    generation.\
-   **Smaller communities like Delta Junction** can still achieve
    exceptionally high income averages, offering unique perspectives on
    localized economic performance.

