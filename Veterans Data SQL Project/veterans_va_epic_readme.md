# Veterans Who Used VA Health Care (2010–2015) (with Epic Context)

This dataset titled **"Veterans Who Used VA Health Care"** provides annual data from 2010 to 2015 on the utilization of VA health services across all U.S. states.  

Each record includes:  
- State name  
- Total veteran population  
- Number of veterans who used VA health care  
- Percentage of veterans utilizing these services  

On average, about **27.6% of veterans** in each state used VA health care annually, though this rate varied widely—from as low as **16%** to as high as **54.5%**. The data shows significant differences in both veteran population sizes and VA usage across states, with larger states like **California** or **Texas** showing higher numbers of VA patients.  

The dataset offers valuable insight into trends in health care access and utilization among veterans over time, highlighting regional and temporal variations that could inform policy or program development.  

> **Epic context:** Within Epic, similar utilization metrics would be sourced from **Clarity** and **Caboodle** using patient encounters (`PAT_ENC`), registration (`PATIENT`, `COVERAGE`), and problem lists (`CLARITY_EDG`, `PAT_ENC_DX`). Veterans Health Administration (VHA) implementations of Epic would additionally leverage **Healthy Planet** for population health tracking and care gap monitoring.

---

## Tableau Dashboard

The project was finalized by building an interactive dashboard in Tableau.  
🔗 [View the Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/Veterans_Data_Project/Dashboard1)

<img width="1998" height="1598" alt="Dashboard 1-2" src="https://github.com/user-attachments/assets/6a7e4fc3-6357-49aa-b3d9-e8db99c342f4" />

> **Epic context:** Epic reports would similarly be visualized using **SlicerDicer** for exploratory analysis and Tableau/Power BI when connecting to Clarity or Caboodle. Veteran usage KPIs could be grouped by state, facility (`CLARITY_DEP`), and payer (VA insurance mapping via `COVERAGE`).

---

## Data Preparation & Cleaning

The project began with raw data extraction and cleaning. Screenshots of raw vs. cleaned data can be found in the repository:

- ![Raw Data](https://github.com/curlyeje/Elliott_Portfolio/blob/9b0a6767c32628a03dfaa4902811d72a69ea188b/Veterans%20Data%20SQL%20Project/Raw%20Data.png)  
- ![Cleaned Data](https://github.com/curlyeje/Elliott_Portfolio/blob/3017d5c919a54fac20fcbc274e6fef5d448fff5a/Veterans%20Data%20SQL%20Project/Cleaned%20Data.png)  

Several SQL transformations were applied, including renaming columns for readability, converting data types, rounding percentages, and removing inconsistent records. Validation checks ensured accuracy in percentage calculations.  

> **Epic context:** In Clarity, ETL jobs from Chronicles already normalize data, but analysts often still need to validate **patient populations, encounter counts, and payer classifications** against registries and reporting workbench extracts.

---

## Exploratory Data Analysis (EDA) Highlights

1. **VA health care usage increased** by over 5 percentage points between 2010 and 2015.  

   > *Epic context:* In Epic, longitudinal usage trends would be derived from `PAT_ENC` encounter counts over time by filtering `FIN_CLASS` or `PAYOR_PLAN` specific to VA coverage.

2. **Puerto Rico** had the highest VA usage rate (54%), while **Hawaii** had the lowest (16%).  

   > *Epic context:* Similar geographic comparisons are possible using `ZIPCODE_INFO`, `PATIENT.ADDR_ZIP`, and linking to facility-level encounter counts in `CLARITY_DEP`.

3. Veteran populations generally **decreased over time**, possibly due to geographic or systemic barriers.  

   > *Epic context:* This parallels attrition trends in Epic registries, where analysts examine denominator shrinkage in registries such as **veteran cohorts** tracked in Healthy Planet.

4. **Florida, California, and Texas** saw the largest increases in VA locations.  

   > *Epic context:* Facility-level growth could be monitored through `CLARITY_DEP` (department) and `CLARITY_LOC` (location) tied to patient encounters.

5. **Total veteran population (2010–2015): ~130 million.**  

   > *Epic context:* Epic analysts would calculate population denominators via `PATIENT` and enrollment attributes (`COVERAGE`, `IDENTITY`), aligning cohorts to VA eligibility.

---

## Key Takeaways

- Veteran health care usage **varied significantly** by state and region.  
- VA usage **increased overall** despite declines in veteran population counts.  
- Larger states (California, Texas, Florida) demonstrated **higher concentrations of care delivery sites**.  
- Significant disparities in usage rates (e.g., Puerto Rico vs. Hawaii) highlight geographic differences in veteran access to care.  

> **Epic context:** Epic-based health systems would leverage these findings in **Healthy Planet dashboards** to measure access to care, regional gaps, and utilization patterns among veterans. Metrics would be tied to **risk-adjusted populations** and used for care gap closure and resource allocation.  

