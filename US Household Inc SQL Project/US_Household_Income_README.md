# U.S. Household Income Project

This project was conducted in **MySQL Workbench**, focusing on **U.S.
Household Income** data segmented by **State, City, and Income Type**.\
An additional table, `statistics`, was **INNER JOINED** with the main
dataset to calculate **mean and median values**, enabling comparisons
across different regions and income categories.\
The ultimate goal was to determine which areas are performing well in
terms of income distribution, while also uncovering geographic and
demographic patterns.

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
        leveraging the `ID` column (primary key).\
    -   Removed unnecessary or redundant entries to maintain dataset
        integrity.
3.  **Column Adjustments**
    -   **State_Name**: Corrected grammatical inconsistencies and
        standardized capitalization with the `UPDATE` statement.\
    -   **Missing Values**: Populated missing county and city names
        using cross-referenced data.\
    -   **Type Column**: Standardized inconsistent naming conventions
        for income categories.\
    -   **ALand (Land Area) & AWater (Water Area)**: Inspected for `0`
        or `NULL` values, ensuring complete and reliable entries.

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

------------------------------------------------------------------------

## Repository Links

-   [SQL Queries & Data Cleaning
    Steps](https://github.com/curlyeje/Elliott_Portfolio/tree/main/US%20Household%20Income%20SQL%20Project)
