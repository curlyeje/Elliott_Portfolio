# OpenEMR Data Analysis Project

## Overview
This project demonstrates how I installed and configured **OpenEMR**, populated it with synthetic patient records, and used SQL queries to extract insights for operational and clinical reporting. I then built a dashboard to present my findings, simulating a realistic healthcare data workflow while ensuring all data is **dummy/fake**.

---

## Steps

### 1. Installation
- Installed **OpenEMR** (Apache, PHP, MySQL stack).
- Configured database and admin user via the web installer.
- Verified access with initial practice setup.

### 2. Data Entry (Dummy Data)
- **Demographics:** Added patients into `patient_data` with DOB, sex, insurance.
- **Scheduling:** Created appointments in `openemr_postcalendar_events` (linked to providers via `pc_aid`).
- **Encounters:** Recorded SOAP notes and vitals through `form_encounter`.
- **Diagnosis & Billing:** Added ICD-10 and CPT codes on fee sheets (stored in `billing`).
- **Medications:** Entered prescriptions in the `prescriptions` table.
- **Medical Problems:** Logged conditions in the Lists module.

### 3. Revenue Cycle Simulation
- Registered patients with insurance.
- Scheduled appointments and documented encounters.
- Captured charges (ICD-10 + CPT).
- Generated claims and simulated submissions.
- Posted payments/adjustments to simulate adjudication.
- Produced patient statements for balances.

### 4. SQL Queries
**Patient count:**
```sql
SELECT sex, COUNT(*) as count
FROM patient_data
GROUP BY sex;
```

**Age distribution:**
```sql
SELECT CASE
  WHEN TIMESTAMPDIFF(YEAR, DOB, '2025-08-20') < 18 THEN 'Under 18'
  WHEN TIMESTAMPDIFF(YEAR, DOB, '2025-08-20') BETWEEN 18 AND 64 THEN '18-64'
  ELSE '65+'
END AS age_group,
COUNT(*) AS total
FROM patient_data
GROUP BY age_group;
```

**Appointments by provider:**
```sql
SELECT pc_aid AS provider_id, COUNT(*) AS appt_count
FROM openemr_postcalendar_events 
GROUP BY pc_aid

```

**Encounters per month:**
```sql
SELECT DATE_FORMAT(fe.date, '%Y-%m') AS year_month,
       COUNT(*) AS encounters
FROM form_encounter fe
GROUP BY year_month
ORDER BY year_month;
```

**Top 10 prescribed drugs:**
```sql
SELECT TRIM(drug), COUNT(*) AS prescriptions_count
FROM prescriptions
GROUP BY TRIM(drug)
ORDER BY prescriptions_count DESC
LIMIT 10;
```

**Most used CPT codes:**
```sql
SELECT b.code, b.code_text, COUNT(*) AS usage_count
FROM billing b
WHERE b.code_type IN ('CPT','CPT4') AND b.activity = 1
GROUP BY b.code, b.code_text
ORDER BY usage_count DESC
LIMIT 10;
```

### 5. Dashboard
I connected Tableau/Power BI to the MySQL database and built:
- **KPIs:** Total patients, encounters YTD.
- **Age distribution:** Bar chart by age bucket.
- **Appointments by provider:** Ranking of workload.
- **Encounters trend:** Monthly line chart.
- **Top medications:** Top 10 prescribed.
- **Top CPT codes:** Most frequently billed.

---

## Deliverables
- **SQL queries** for key healthcare metrics.
- **Dashboard** visualizing patients, utilization, prescriptions, and revenue cycle indicators.
- **Synthetic dataset** ensuring HIPAA-safe exploration.

---

## Key Learnings
- Gained hands-on experience with **EHR data models** (OpenEMR schema).
- Practiced the **healthcare revenue cycle** end-to-end.
- Learned to query and interpret **clinical and billing data**.
- Built a portfolio-ready **dashboard** for healthcare analytics.

---

## Disclaimer
All data used in this project are **dummy/fake**. No protected health information (PHI) or real patient data were used.

