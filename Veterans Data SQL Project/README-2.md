# Veterans Who Used VA Health Care (2010--2015)

This dataset titled **"Veterans Who Used VA Health Care"** provides
annual data from 2010 to 2015 on the utilization of VA health services
across all U.S. states.

Each record includes: - State name
- Total veteran population
- Number of veterans who used VA health care
- Percentage of veterans utilizing these services

On average, about **27.6% of veterans** in each state used VA health
care annually, though this rate varied widely---from as low as **16%**
to as high as **54.5%**. The data shows significant differences in both
veteran population sizes and VA usage across states, with larger states
like **California** or **Texas** showing higher numbers of VA patients.

The dataset offers valuable insight into trends in health care access
and utilization among veterans over time, highlighting regional and
temporal variations that could inform policy or program development.

------------------------------------------------------------------------

## Tableau Dashboard

The project was finalized by building an interactive dashboard in
Tableau.\
🔗 [View the
Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/Veterans_Data_Project/Dashboard1)

<img width="1998" height="1598" alt="Dashboard 1-2" src="https://github.com/user-attachments/assets/6a7e4fc3-6357-49aa-b3d9-e8db99c342f4" />


------------------------------------------------------------------------

## Data Preparation & Cleaning

The project began with raw data extraction and cleaning. Screenshots of
raw vs. cleaned data can be found in the repository:

-   ![Raw
    Data](https://github.com/curlyeje/Elliott_Portfolio/blob/9b0a6767c32628a03dfaa4902811d72a69ea188b/Veterans%20Data%20SQL%20Project/Raw%20Data.png)
-   ![Cleaned
    Data](https://github.com/curlyeje/Elliott_Portfolio/blob/3017d5c919a54fac20fcbc274e6fef5d448fff5a/Veterans%20Data%20SQL%20Project/Cleaned%20Data.png "fig:")

Several SQL transformations were applied, including renaming columns for
readability, converting data types, rounding percentages, and removing
inconsistent records. Validation checks ensured accuracy in percentage
calculations.

------------------------------------------------------------------------

## Exploratory Data Analysis (EDA) Highlights

1.  VA health care usage increased by **over 5 percentage points**
    between 2010 and 2015.
2.  **Puerto Rico** had the highest VA usage rate (54%), while
    **Hawaii** had the lowest (16%).

   <img width="1854" height="1042" alt="VA Health Care Usage Rates by State" src="https://github.com/user-attachments/assets/655dfcc4-943a-47b1-8639-dd29f759bdb4" />


3.  Veteran populations generally **decreased over time**, possibly due
    to geographic or systemic barriers.

    <img width="1156" height="1050" alt="Veteran Population Over Time" src="https://github.com/user-attachments/assets/bb448692-2376-460c-834b-c36850eb3512" />

4.  **Florida, California, and Texas** saw the largest increases in VA locations

    <img width="1704" height="1050" alt="Total Amount of VA per State" src="https://github.com/user-attachments/assets/1ba072f5-78d3-4175-9782-a2fad737f4a0" />

5.  **Total veteran population (2010--2015): \~130 million.**\
6.  **Total VA patients (2010--2015): \~40 million.**\
7. **Florida** had the highest number of VA patients in 2015, while
    **D.C.** had the lowest.
8. **Puerto Rico** had the highest veteran VA usage percentage in 2015.

------------------------------------------------------------------------

## Repository Links

-   [SQL Queries &
    Screenshots](https://github.com/curlyeje/Elliott_Portfolio/tree/main/Veterans%20Data%20SQL%20Project)
