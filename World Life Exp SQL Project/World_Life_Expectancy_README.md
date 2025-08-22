# World Life Expectancy Project (2007--2022)

This project, titled **"World Life Expectancy Project"**, was completed
in **MySQL Workbench** and visualized in **Tableau**. The dataset
provides information on **life expectancy across different countries**
from 2007 to 2022, with factors such as **BMI, diseases, adult
mortality, GDP, and development status** playing a critical role in
shaping global health outcomes.

Life expectancy is a key metric for understanding a country's overall
health, quality of life, and socio-economic development. This analysis
provides insight into global patterns, disparities between developing
and developed countries, and trends over the past 15 years.

------------------------------------------------------------------------

## Final Tableau Dashboard

The findings from this project were visualized in Tableau through an
interactive dashboard.\
🔗 [View the
Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/WorldLifeExpectancyProject_17556279430760/Dashboard1)

------------------------------------------------------------------------

## Data Cleaning Process

To ensure accuracy and reliability, the dataset underwent multiple data
cleaning steps:

1.  **Duplicate Checks**
    -   Used the `ROW_NUMBER() OVER(PARTITION BY ...)` window function
        along with `CONCAT(country, year)` to identify duplicates.\
    -   Found and resolved **3 duplicate records**.
2.  **Handling Missing Data**
    -   Investigated blank values in critical columns such as
        **Status**, **Life Expectancy**, and **Country**.\
    -   Applied logical imputation where possible.
3.  **Status Column Adjustment**
    -   To resolve missing values in the *Status* field (Developed
        vs. Developing), a **self-JOIN** on the table was performed to
        correctly classify countries.

------------------------------------------------------------------------

## Exploratory Data Analysis (EDA) Findings

The cleaned dataset was analyzed to extract meaningful insights about
life expectancy across nations. Key findings include:

1.  **Trends in Life Expectancy**
    -   Over the last **15 years**, the **world's average life
        expectancy increased by 6 years** (2007 → 2022).\
    -   Some countries showed dramatic improvements; for example,
        **Haiti, Zimbabwe, and Eritrea** experienced increases of **20+
        years** in life expectancy.
2.  **Economic Correlations**
    -   Countries with **lower GDP** generally had **lower life
        expectancy**.\
    -   Countries with **higher GDP** showed significantly **higher life
        expectancy**.\
    -   On average:
        -   **High GDP countries** → Life expectancy \~ **74 years**\
        -   **Low GDP countries** → Life expectancy \~ **65 years**
3.  **Development Status Insights**
    -   The dataset revealed **161 developing countries** versus **32
        developed countries**.\
    -   Developing countries consistently lagged behind in life
        expectancy compared to developed nations.
4.  **Impact of Health Factors**
    -   **BMI (Body Mass Index)** showed noticeable correlation patterns
        when compared to life expectancy.\
    -   **Adult Mortality** provided deeper insights into national
        health systems and challenges. For example:
        -   The **United States of America** reported a **rolling total
            of 931 adult mortalities** from 2007--2022.

------------------------------------------------------------------------

## Key Insights

-   Life expectancy is **steadily improving worldwide**, but disparities
    remain between developing and developed nations.\
-   **GDP is a strong predictor** of a country's average life
    expectancy.\
-   Countries with weaker health systems still face challenges related
    to **adult mortality, BMI, and disease prevalence**.\
-   Global health efforts have contributed to improved outcomes, but
    **systemic inequalities** remain a critical issue.

------------------------------------------------------------------------

## Repository Links

-   [SQL Queries & Cleaning
    Steps](https://github.com/curlyeje/Elliott_Portfolio/tree/main/World%20Life%20Expectancy%20SQL%20Project)\
-   [Tableau
    Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/WorldLifeExpectancyProject_17556279430760/Dashboard1)
