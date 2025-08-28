# Hospital Encounters for Behavioral Health Disorders (with Epic Context)

This project analyzes **hospital encounters (inpatient hospitalizations and emergency department visits) related to behavioral health disorders** in the State of California.  

The dataset was sourced from **[Data.gov](https://data.gov/)** and prepared for analysis by cleaning and standardizing column names. The analysis explores trends over time, demographic breakdowns, and diagnosis groups using SQL and Tableau for visualization.  

> **Epic context:** In Epic, similar reporting is generated using **Clarity tables** that capture inpatient and emergency department activity. Examples include `PAT_ENC` (patient encounters), `V_VISIT` (visit dimension), `CLARITY_SER` (providers), and diagnosis detail tables like `PAT_ENC_DX` and `CLARITY_EDG`. Behavioral health encounters are often pulled specifically through **Epic Behavioral Health modules** with integration to **Resolute (billing)** and **Cadence (scheduling)**.

---

## 📊 Interactive Dashboard  
👉 [Click here to view the Tableau Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/HospitalEncountersProject/Dashboard1#2)

<img width="1998" height="1598" alt="Dashboard 1" src="https://github.com/user-attachments/assets/858c3bef-902e-4550-91bc-361204b7bdae" />

The dashboard provides an interactive view of hospitalization and emergency department visits for patients with behavioral health disorders across different demographics.  

> **Epic context:** In an Epic reporting environment, this dashboard would connect to **Clarity or Caboodle**. Equivalent reporting is often done in **SlicerDicer** for behavioral health utilization trends.

---

## 🧹 Data Cleaning  

To make the dataset easier to work with, several adjustments were made:  

- Removed backticks from column names.  
- Renamed columns for readability (e.g., `Pattype` → `patient_type`, `Cat_desc` → `demographic_category_value`).  
- Rounded percentages to **two decimal places**.  

Example SQL commands:  

```sql
ALTER TABLE hospital_encounters_for_behavioral_health_cleaned 
  CHANGE Pattype patient_type TEXT(50);

UPDATE hospital_encounters_for_behavioral_health_cleaned 
  SET percent = ROUND(percent, 2);
```

📸 [Data Cleaning Screenshot](https://github.com/curlyeje/Elliott_Portfolio/blob/c77845817a9b45b490ba565e491639815fe37540/Hospital%20Encounters%20SQL%20Project/Hosptial_Encounters%20Table%20.png)  

> **Epic context:** In Epic, data cleaning is often unnecessary at the SQL layer because **Clarity ETL jobs** normalize source data from Chronicles. Column renaming is similar to creating **Clarity views** or using **Caboodle semantic layers** for analyst readability.

---

## 🔍 Exploratory Data Analysis  

### 1. How have mental health disorders changed over time?  
- Hospital encounters increased significantly between **2020–2022**.  
- SQL used a rolling total window function.  

> **Epic context:** This trend would come from `PAT_ENC` joined with `CLARITY_EDG` filtered by behavioral health diagnoses. Analysts often trend admissions by `CONTACT_DATE` and diagnosis groups.

---

### 2. Which year had the highest number of behavioral health-related encounters?  
- **2022** recorded the highest encounters with **317,653,552 total discharges/visits**.  

> **Epic context:** Similar counts would come from `V_VISIT` with encounter types = inpatient/emergency. Discharges are tracked in `DISCH_INFO` or by using discharge disposition codes.

---

### 3. What proportion of total hospital discharges were due to substance use disorders?  
- Substance use disorders accounted for **6.36%** of all encounters.  

> **Epic context:** Analysts would filter by ICD-10 codes related to **F10–F19 (substance-related disorders)** in `PAT_ENC_DX`. Ratios are derived by dividing encounter subsets by all discharges in `PAT_ENC`.

---

### 4. Inpatient vs. Emergency Department Usage  
- The dataset contained **216 inpatient** and **216 emergency department entries**, totaling **432 records**.  

> **Epic context:** The **patient type** dimension aligns to `VISIT_TYPE_C` in Epic Clarity. Inpatient = “I”, Emergency = “E”. ED visits are captured in `ED_ENC` as well for triage and arrival details.

---

### 5. Top 3 Demographic Categories  
- **All Discharges**  
- **Female**  
- **Male**  

> **Epic context:** Gender distribution maps to `ZC_SEX` in Clarity. Discharge counts by demographic are reported through joins between `PATIENT` and `PAT_ENC`.

---

### 6. Lowest Demographic Categories  
- **American Indian/Alaska Native**  
- **Other Payer**  
- **Uninsured**  

> **Epic context:** Race/Ethnicity are in `PATIENT.RACE_C` joined to `ZC_RACE`. Payer/coverage types are from `COVERAGE` and `PAYOR_PLAN`. Analysts often slice utilization by insurance type for equity analysis.

---

### 7. Total Encounters Counted  
- The dataset included a total of **219,078,738** encounters.  

> **Epic context:** Similar counts are obtained from `PAT_ENC` with filtering by service dates and encounter types. For Behavioral Health Service Lines, departments in `CLARITY_DEP` tied to Behavioral Health are often filtered.

---

## ⚙️ Tools & Technologies  
- **SQL (MySQL)** for data cleaning and exploration  
- **Tableau** for interactive visualization  
- **GitHub** for version control and portfolio presentation  

> **Epic context:** In Epic, SQL would target **Clarity (SQL Server/Oracle)**. Analysts would also leverage **Reporting Workbench** and **SlicerDicer** alongside external BI tools (Tableau/Power BI).

---

## 📌 Key Takeaways  
- Behavioral health hospitalizations **spiked during 2020–2022**.  
- **Substance use disorders** remain a significant contributor to hospital encounters.  
- **Demographics such as gender and discharge type** provide key insights into utilization trends.  

> **Epic context:** These findings align with Epic **Clarity reports** used by hospital systems to monitor **behavioral health service utilization**, payer mix, and demographic disparities.

---

## 📂 Repository Contents  
- SQL scripts for cleaning and analysis  
- Tableau dashboard link  
- Screenshots of query results  
