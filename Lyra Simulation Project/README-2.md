
# Healthcare Analytics Case Study  
## Prioritized KPI Analysis & Visualization (Snowflake → Tableau)

**Author:** Elliott Earley  
**Focus Areas:** Healthcare Analytics, Clinical Operations, Revenue Cycle, Member Experience  
**Last Updated:** 2025-12-26  

---

## 1. Project Overview

This project is an end-to-end **healthcare analytics case study** designed to demonstrate how raw healthcare data can be transformed into **clear, executive-ready insights**.

The project answers **10 core analytical questions** spanning:
- Enrollment growth
- Access and scheduling friction
- Engagement and utilization
- Revenue cycle health
- Cost efficiency
- Support and operational risk
- Clinical severity and outcomes

Rather than visualizing every possible metric, this project intentionally **prioritizes the most decision-critical questions**—the ones leaders act on most often.

---

## 2. Reporting Period

All time-based metrics use a consistent reporting window:

- **Start (inclusive):** December 1, 2023  
- **End (exclusive):** December 1, 2025  

This creates a clean **24-month analysis window**, avoiding partial months and ensuring metrics are comparable across domains.

---

## 3. Full Question Set (Q1–Q10)

The SQL worksheet answers the following questions:

1. **Monthly New Enrollments**  
2. **Median Days from Enrollment to First Completed Session**  
3. **No-Show Rate (Appointments vs Sessions)**  
4. **Cancellation Rate by Group (Lead Time, Modality, Weekend vs Weekday)**  
5. **Sessions per Active Member**  
6. **Claims Status Mix (Paid vs Denied vs Pending)**  
7. **Average Cost per Completed Session**  
8. **High / Urgent Support Ticket Rate (Trending)**  
9. **Baseline Clinical Severity Distribution**  
10. **Outcome Improvement by Session Count Bucket**  

All 10 questions are fully defined and answered in SQL.

---

## 4. Why Only Some Questions Were Visualized

While all 10 questions were analyzed in SQL, **only Questions 1, 4, 6, 7, and 8 were visualized in Tableau**.

### Reason for Prioritization

These five questions were selected because they represent the **highest-impact KPIs for leadership decision-making**:

| Question | Why It Was Prioritized |
|--------|------------------------|
| Q1 – Enrollments | Growth and demand signal |
| Q4 – Cancellations | Access friction and experience risk |
| Q6 – Claims Mix | Revenue cycle and cash-flow health |
| Q7 – Cost per Session | Unit economics and cost control |
| Q8 – High/Urgent Tickets | Early warning signal for operational breakdowns |

The remaining questions (Q2, Q3, Q5, Q9, Q10) provide **important analytical context**, but are typically:
- Used for deeper operational or clinical analysis
- Reviewed by analytics or clinical teams
- Less frequently shown on executive dashboards

This prioritization mirrors how analytics teams operate in real organizations.

---

## 5. Step-by-Step: How This Project Was Built

### Step 1: Metric Definition & Business Framing
Each question was first translated into:
- A clear **business question**
- A precise **metric definition**
- Explicit **calculation logic**
- Defined **data grain** (member-level, session-level, monthly, etc.)

This ensures stakeholders and analysts interpret the metric the same way.

---

### Step 2: SQL Development in Snowflake
A structured SQL worksheet was created using the `LYRA_BIG_DEMO.PUBLIC` schema.

Key practices used:
- Explicit joins and filters
- Clear grouping logic
- Consistent reporting period alignment
- Defensive logic to prevent data quality issues (e.g., negative time intervals)

Each query produces a **clean, analysis-ready output table**.

---

### Step 3: Querying Curated Tables
Queries pull from core healthcare fact and dimension tables, including:
- `D_MEMBERS`
- `F_SESSIONS`
- `F_APPOINTMENTS`
- `F_CLAIMS`
- `F_TICKETS`
- `F_OUTCOMES`
- `V_SESSIONS_ENRICHED`

The outputs are shaped specifically for visualization (aggregated, labeled, and time-aligned).

---

### Step 4: Visualization in Tableau
Only the **highest-priority KPIs (Q1, Q4, Q6, Q7, Q8)** were connected to Tableau.

In Tableau:
- Each SQL query acts as a trusted data source
- Metrics are visualized using appropriate chart types:
  - Line charts for trends
  - Bar charts for comparisons
  - Percentage views for mix and rates
- Color, layout, and labeling are optimized for executive readability

The result is a **focused dashboard** that tells a clear story without overwhelming the viewer.

---

### Step 5: Interpretation & Recommendations
For every metric—visualized or not—the analysis includes:
- Key takeaways (what the data shows)
- Business or clinical implications
- Actionable recommendations leaders could realistically implement

This reinforces that analytics is about **decision support**, not just charts.

---

## 6. What This Project Demonstrates

This project showcases the ability to:

- Translate vague questions into well-defined KPIs
- Write production-quality SQL in Snowflake
- Apply consistent reporting logic across domains
- Prioritize metrics based on business value
- Build Tableau visuals that executives can immediately understand
- Connect operational, financial, and clinical data into one narrative

---

## 7. How a Hiring Manager Can Use This Project

A hiring manager can:
- Review the SQL to assess technical depth
- Review the Tableau visuals to assess communication skills
- Follow the README to understand *why* certain metrics were emphasized
- See evidence of real-world analytics judgment and prioritization

This mirrors how analytics work is actually done in healthcare organizations.

---

## 8. Closing Summary (Plain English)

> This project starts with raw healthcare data, applies clear metric definitions and SQL logic in Snowflake, and ends with focused Tableau dashboards that highlight the metrics leaders care about most—growth, access, cost, revenue, and operational risk.

---
