# Hospital Encounters for Behavioral Health Disorders

This project analyzes **hospital encounters (inpatient hospitalizations and emergency department visits) related to behavioral health disorders** in the State of California.  

The dataset was sourced from **[Data.gov](https://data.gov/)** and prepared for analysis by cleaning and standardizing column names. The analysis explores trends over time, demographic breakdowns, and diagnosis groups using SQL and Tableau for visualization.  

---

## 📊 Interactive Dashboard  
👉 [Click here to view the Tableau Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/HospitalEncountersProject/Dashboard1#2)  

The dashboard provides an interactive view of hospitalization and emergency department visits for patients with behavioral health disorders across different demographics.  

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

---

## 🔍 Exploratory Data Analysis  

### 1. How have mental health disorders changed over time?  
- Hospital encounters increased significantly between **2020–2022**.  
- SQL used a rolling total window function.  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/3068d39e5463b4e99f0a4652f84c77eb4760c4e2/Hospital%20Encounters%20SQL%20Project/Question%20%23%201%20Answer.png)  

---

### 2. Which year had the highest number of behavioral health-related encounters?  
- **2022** recorded the highest encounters with **317,653,552 total discharges/visits**.  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/d97668d013f5e1d517c2b423da8bc8c2ed56dda7/Hospital%20Encounters%20SQL%20Project/Question%20%23%202%20Answer.png)  

---

### 3. What proportion of total hospital discharges were due to substance use disorders?  
- Substance use disorders accounted for **6.36%** of all encounters.  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/eff6d9de95032956da8fbb8baccd9fc4d12f6c28/Hospital%20Encounters%20SQL%20Project/Question%20%23%203%20Answer.png)  

---

### 4. Inpatient vs. Emergency Department Usage  
- The dataset contained **216 inpatient** and **216 emergency department entries**, totaling **432 records**.  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/347cf02fc9360fee003f9d80c937edf678d0a589/Hospital%20Encounters%20SQL%20Project/Question%20%234%20Answer.png)  

---

### 5. Top 3 Demographic Categories  
- **All Discharges**  
- **Female**  
- **Male**  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/801a85bc5d3a9c3a6b35805e45eccf557b86f8cc/Hospital%20Encounters%20SQL%20Project/Question%20%235%20Answer.png)  

---

### 6. Lowest Demographic Categories  
- **American Indian/Alaska Native**  
- **Other Payer**  
- **Uninsured**  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/7d1ced1c300583276b74acf99db62a3c41dd9281/Hospital%20Encounters%20SQL%20Project/Question%20%236%20Answer.png)  

---

### 7. Total Encounters Counted  
- The dataset included a total of **219,078,738** encounters.  

📸 [View Result](https://github.com/curlyeje/Elliott_Portfolio/blob/e88fcd99c1fd69be098182ce601221473cd50ec0/Hospital%20Encounters%20SQL%20Project/Question%20%237%20Answer.png)  

---

## ⚙️ Tools & Technologies  
- **SQL (MySQL)** for data cleaning and exploration  
- **Tableau** for interactive visualization  
- **GitHub** for version control and portfolio presentation  

---

## 📌 Key Takeaways  
- Behavioral health hospitalizations **spiked during 2020–2022**.  
- **Substance use disorders** remain a significant contributor to hospital encounters.  
- **Demographics such as gender and discharge type** provide key insights into utilization trends.  

---

## 📂 Repository Contents  
- SQL scripts for cleaning and analysis  
- Tableau dashboard link  
- Screenshots of query results  
