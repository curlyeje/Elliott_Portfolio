# Hospital Encounters for Behavioral Health Disorders

This project analyzes **hospital encounters (inpatient hospitalizations and emergency department visits) related to behavioral health disorders** in the State of California.  

The dataset was sourced from **[Data.gov](https://data.gov/)** and prepared for analysis by cleaning and standardizing column names. The analysis explores trends over time, demographic breakdowns, and diagnosis groups using SQL and Tableau for visualization.  

---

## 📊 Interactive Dashboard  
👉 [Click here to view the Tableau Dashboard](https://public.tableau.com/app/profile/elliott.earley/viz/HospitalEncountersProject/Dashboard1#2)

<img width="1998" height="1598" alt="Dashboard 1" src="https://github.com/user-attachments/assets/858c3bef-902e-4550-91bc-361204b7bdae" />


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

<img width="269" height="78" alt="Question # 1 Answer" src="https://github.com/user-attachments/assets/5bd55151-6d1e-4143-a9db-bef967808162" />


---

### 2. Which year had the highest number of behavioral health-related encounters?  
- **2022** recorded the highest encounters with **317,653,552 total discharges/visits**.  

<img width="145" height="80" alt="Question # 2 Answer" src="https://github.com/user-attachments/assets/bc62ad41-5247-4c21-9a02-195ed6a4009f" />


---

### 3. What proportion of total hospital discharges were due to substance use disorders?  
- Substance use disorders accounted for **6.36%** of all encounters.  

<img width="305" height="44" alt="Question # 3 Answer" src="https://github.com/user-attachments/assets/d7a13ce7-3534-474d-851a-0bff300fc19e" />

---

### 4. Inpatient vs. Emergency Department Usage  
- The dataset contained **216 inpatient** and **216 emergency department entries**, totaling **432 records**.  

 <img width="242" height="58" alt="Question # 4 Answer" src="https://github.com/user-attachments/assets/a55b0ddb-cef2-469a-8d73-369a7cd18209" />


---

### 5. Top 3 Demographic Categories  
- **All Discharges**  
- **Female**  
- **Male**  

<img width="458" height="76" alt="Question # 5 Answer" src="https://github.com/user-attachments/assets/08ac0f4a-f750-4160-b46b-64ffa96f5a6d" />


---

### 6. Lowest Demographic Categories  
- **American Indian/Alaska Native**  
- **Other Payer**  
- **Uninsured**  

<img width="444" height="79" alt="Question # 6 Answer" src="https://github.com/user-attachments/assets/24301b97-9892-4ece-b1f1-ce9658b639c8" />


---

### 7. Total Encounters Counted  
- The dataset included a total of **219,078,738** encounters.  

<img width="186" height="48" alt="Question # 7 Answer" src="https://github.com/user-attachments/assets/f14268b4-34d4-4508-8aa2-7d9d5077ff51" />


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
