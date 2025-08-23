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
interactive dashboard.
🔗 [View the
Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/WorldLifeExpectancyProject_17556279430760/Dashboard1)

<img width="1998" height="1598" alt="Dashboard 1-2" src="https://github.com/user-attachments/assets/912fe576-4516-465b-b4f7-d469fb2fb8d5" />


------------------------------------------------------------------------

## Data Cleaning Process

To ensure accuracy and reliability, the dataset underwent multiple data
cleaning steps:

1.  **Duplicate Checks**
    -   Used the `ROW_NUMBER() OVER(PARTITION BY ...)` window function
        along with `CONCAT(country, year)` to identify duplicates.
    -   Found and resolved **3 duplicate records**.
2.  **Handling Missing Data**
    -   Investigated blank values in critical columns such as
        **Status**, **Life Expectancy**, and **Country**.
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
        expectancy increased by 6 years** (2007 → 2022).
    -   Some countries showed dramatic improvements; for example,
        **Haiti, Zimbabwe, and Eritrea** experienced increases of **20+
        years** in life expectancy.

        <img width="2006" height="1050" alt="Country-Level Life Expectancy_ Highest vs  Lowest" src="https://github.com/user-attachments/assets/2bdb8f17-5a32-4097-a23c-26825964a153" />

2.  **Economic Correlations**
    -   Countries with **lower GDP** generally had **lower life
        expectancy**.
    -   Countries with **higher GDP** showed significantly **higher life
        expectancy**.
    -   On average:
        -   **High GDP countries** → Life expectancy \~ **74 years**
        -   **Low GDP countries** → Life expectancy \~ **65 years**
     
<img width="1850" height="1048" alt="Average Life Expectancy by GDP" src="https://github.com/user-attachments/assets/64a307d9-dab6-4388-a8f6-77a1ed2ddd83" />

    
3.  **Development Status Insights**
    -   The dataset revealed **66.83 developing countries** versus **79.20 developed countries based on the average life expectancy.
        developed countries**.
    -   Developing countries consistently lagged behind in life
        expectancy compared to developed nations.

        <img width="1068" height="1106" alt="Average Life Expectancy by Development Status" src="https://github.com/user-attachments/assets/15a61259-7de3-4d7e-b3a8-41e020413027" />

4.  **Impact of Health Factors**
    -   **BMI (Body Mass Index)** showed noticeable correlation patterns
        when compared to life expectancy.
    -   **Adult Mortality** provided deeper insights into national
        health systems and challenges. For example:
        -   The **United States of America** reported a **rolling total
            of 931 adult mortalities** from 2007--2022.

            <img width="2006" height="1050" alt="Life Expectancy vs Adult Mortality and BMI" src="https://github.com/user-attachments/assets/1c64fbd7-32e9-473b-8f9b-10cf5352d3b1" />


------------------------------------------------------------------------

## Key Insights

-   Life expectancy is **steadily improving worldwide**, but disparities
    remain between developing and developed nations.
-   **GDP is a strong predictor** of a country's average life
    expectancy.
-   Countries with weaker health systems still face challenges related
    to **adult mortality, BMI, and disease prevalence**.
-   Global health efforts have contributed to improved outcomes, but
    **systemic inequalities** remain a critical issue.

------------------------------------------------------------------------

## Repository Links

-   [SQL Queries & Cleaning
    Steps](https://github.com/curlyeje/Elliott_Portfolio/tree/main/World%20Life%20Expectancy%20SQL%20Project)
-   [Tableau
    Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/WorldLifeExpectancyProject_17556279430760/Dashboard1)
