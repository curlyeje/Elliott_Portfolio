
# SQL Deep Dive — Healthcare Analytics Case Study
## Demonstrating SQL Skills Across Business, Clinical, and Revenue Domains

**Author:** Elliott Earley  
**Platform:** Snowflake SQL  
**Dataset:** LYRA_BIG_DEMO.PUBLIC  
**Reporting Period (when applicable):** 2023-12-01 → 2025-12-01 (end-exclusive)  
**Last Updated:** 2025-12-26  

---

## Purpose of This Document

This document is designed specifically to **showcase SQL proficiency** for hiring managers and technical reviewers.

Each section:
- Restates the **business question**
- Explains the **SQL approach**
- Highlights **key SQL concepts used**
- Includes the **actual SQL query**

The focus is on **clarity, correctness, and real-world analytics practices**—not just syntax.

---

## Question 1 — Monthly New Enrollments

### Business Question
How are member enrollments trending month over month?

### SQL Approach
- Truncate enrollment dates to calendar month
- Aggregate counts at a monthly grain
- Sort chronologically for trend analysis

### SQL Concepts Demonstrated
- `DATE_TRUNC`
- Aggregation with `COUNT(*)`
- Grouping and ordering
- Time-series preparation for visualization

### SQL
```sql
SELECT
  DATE_TRUNC('month', ENROLL_DATE) AS enrollment_month,
  COUNT(*) AS new_enrollments
FROM LYRA_BIG_DEMO.PUBLIC.D_MEMBERS
GROUP BY enrollment_month
ORDER BY enrollment_month ASC;
```

---

## Question 2 — Median Days to First Completed Session

### Business Question
How long does it take, on average, for members to complete their first session after enrolling?

### SQL Approach
- Identify first completed session per member using `MIN(SESSION_DATE)`
- Join sessions to member enrollment records
- Calculate day-level differences
- Use median to reduce outlier influence

### SQL Concepts Demonstrated
- Subqueries and joins
- `MIN()` aggregation
- `DATEDIFF`
- `MEDIAN()` for robust central tendency

### SQL
```sql
SELECT 
  MEDIAN(DATEDIFF('day', m.enroll_date, fs.first_completed_session_date))
    AS median_days_to_first_completed_session
FROM LYRA_BIG_DEMO.PUBLIC.D_MEMBERS m
JOIN (
  SELECT
    member_id,
    MIN(session_date) AS first_completed_session_date
  FROM LYRA_BIG_DEMO.PUBLIC.F_SESSIONS
  WHERE status = 'Completed'
  GROUP BY member_id
) fs
  ON m.member_id = fs.member_id;
```

---

## Question 3 — No-Show Rate (Appointments vs Sessions)

### Business Question
How often do members miss scheduled care events, and does this differ between appointments and sessions?

### SQL Approach
- Calculate totals and no-shows separately
- Combine results using `UNION ALL`
- Derive rates via conditional aggregation

### SQL Concepts Demonstrated
- `UNION ALL`
- Conditional aggregation with `IFF`
- Rate calculations
- Multi-metric output shaping

### SQL
```sql
SELECT
  'Appointments' AS metric_type,
  COUNT(*) AS total,
  SUM(IFF(APPT_STATUS='No-Show',1,0)) AS no_shows,
  ROUND(SUM(IFF(APPT_STATUS='No-Show',1,0)) / COUNT(*), 3) AS no_show_rate
FROM LYRA_BIG_DEMO.PUBLIC.F_APPOINTMENTS

UNION ALL

SELECT
  'Sessions' AS metric_type,
  COUNT(*) AS total,
  SUM(IFF(STATUS='No-Show',1,0)) AS no_shows,
  ROUND(SUM(IFF(STATUS='No-Show',1,0)) / COUNT(*), 3) AS no_show_rate
FROM LYRA_BIG_DEMO.PUBLIC.F_SESSIONS;
```

---

## Question 4 — Cancellation Rate by Group

### Business Question
Which groups cancel most often, and what does that reveal about access friction?

### SQL Approach
- Bucket appointment lead times
- Normalize cancellation flags
- Combine appointment and session data
- Segment by modality and timing

### SQL Concepts Demonstrated
- `CASE` statements
- Bucketing logic
- Multi-source `UNION ALL`
- Dimensional segmentation

### SQL
```sql
SELECT
  event_type,
  lead_time_bucket,
  modality,
  is_weekend,
  COUNT(*) AS total_events,
  SUM(canceled_flag) AS canceled_events,
  ROUND(SUM(canceled_flag) / COUNT(*), 3) AS cancellation_rate
FROM (
  SELECT
    'Appointment' AS event_type,
    CASE
      WHEN LEAD_TIME_DAYS <= 3  THEN '0–3 days'
      WHEN LEAD_TIME_DAYS <= 7  THEN '4–7 days'
      WHEN LEAD_TIME_DAYS <= 14 THEN '8–14 days'
      WHEN LEAD_TIME_DAYS <= 30 THEN '15–30 days'
      ELSE '30+ days'
    END AS lead_time_bucket,
    MODALITY,
    NULL AS is_weekend,
    IFF(APPT_STATUS = 'Canceled', 1, 0) AS canceled_flag
  FROM LYRA_BIG_DEMO.PUBLIC.F_APPOINTMENTS

  UNION ALL

  SELECT
    'Session' AS event_type,
    NULL AS lead_time_bucket,
    MODALITY,
    IS_WEEKEND,
    IFF(STATUS = 'Canceled', 1, 0) AS canceled_flag
  FROM LYRA_BIG_DEMO.PUBLIC.V_SESSIONS_ENRICHED
)
GROUP BY event_type, lead_time_bucket, modality, is_weekend;
```

---

## Question 5 — Sessions per Active Member

### Business Question
How engaged are active members during the reporting period?

### SQL Approach
- Filter to completed sessions
- Aggregate sessions at member level
- Compute population-level averages

### SQL Concepts Demonstrated
- Common Table Expressions (CTEs)
- Member-level aggregation
- KPI derivation

### SQL
```sql
WITH sessions_by_member AS (
  SELECT
    MEMBER_ID,
    COUNT(*) AS completed_session_count
  FROM LYRA_BIG_DEMO.PUBLIC.F_SESSIONS
  WHERE STATUS = 'Completed'
  GROUP BY MEMBER_ID
)
SELECT
  COUNT(*) AS active_members,
  SUM(completed_session_count) AS total_completed_sessions,
  ROUND(SUM(completed_session_count) / COUNT(*), 2) AS sessions_per_active_member
FROM sessions_by_member;
```

---

## Question 6 — Claims Status Mix

### Business Question
What share of claims are paid, denied, or still pending?

### SQL Approach
- Aggregate claims by status
- Use window functions for percentage calculation

### SQL Concepts Demonstrated
- Window functions
- Distribution analysis
- Financial KPI logic

### SQL
```sql
SELECT
  CLAIM_STATUS,
  COUNT(*) AS claim_count,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER (), 4) AS pct_of_claims
FROM LYRA_BIG_DEMO.PUBLIC.F_CLAIMS
GROUP BY CLAIM_STATUS
ORDER BY claim_count DESC;
```

---

## Question 7 — Average Cost per Completed Session

### Business Question
What is the unit cost of delivering a completed session?

### SQL Approach
- Filter to valid, completed sessions
- Aggregate using `AVG()`
- Provide supporting volume context

### SQL Concepts Demonstrated
- Data quality filtering
- Cost aggregation
- Operational cost metrics

### SQL
```sql
SELECT
  ROUND(AVG(SESSION_COST_USD), 2) AS avg_cost_per_completed_session_usd,
  COUNT(*) AS completed_sessions
FROM LYRA_BIG_DEMO.PUBLIC.F_SESSIONS
WHERE STATUS = 'Completed'
  AND SESSION_COST_USD IS NOT NULL;
```

---

## Question 8 — High / Urgent Ticket Rate (Trend)

### Business Question
Are high-severity support issues increasing over time?

### SQL Approach
- Group tickets by month
- Isolate High/Urgent priorities
- Compute monthly severity rate

### SQL Concepts Demonstrated
- Time-series aggregation
- Conditional counts
- Trend analysis preparation

### SQL
```sql
SELECT
  DATE_TRUNC('month', CREATED_DATE) AS month,
  COUNT(*) AS total_tickets,
  SUM(CASE WHEN PRIORITY IN ('High','Urgent') THEN 1 ELSE 0 END) AS high_urgent_tickets,
  ROUND(
    SUM(CASE WHEN PRIORITY IN ('High','Urgent') THEN 1 ELSE 0 END) / COUNT(*),
    4
  ) AS pct_high_urgent
FROM LYRA_BIG_DEMO.PUBLIC.F_TICKETS
GROUP BY DATE_TRUNC('month', CREATED_DATE)
ORDER BY month;
```

---

## Question 9 — Baseline Severity Distribution

### Business Question
What is the clinical acuity of members when they enter care?

### SQL Approach
- Identify earliest outcome per member and instrument
- Aggregate by severity interpretation

### SQL Concepts Demonstrated
- Baseline identification logic
- Multi-level grouping
- Clinical data modeling

---

## Question 10 — Outcome Improvement by Session Count

### Business Question
Do members who complete more sessions experience greater improvement?

### SQL Approach
- Count sessions per member
- Join baseline and latest outcomes
- Bucket session counts and aggregate changes

### SQL Concepts Demonstrated
- Analytical joins
- Bucketed aggregation
- Outcome-based analytics

---

## Final Notes for Reviewers

This SQL work demonstrates:
- Strong analytical framing
- Clean, readable SQL
- Healthcare domain understanding
- Production-ready logic
- Business-focused data modeling

The queries are intentionally structured to support **direct Tableau visualization** and **executive reporting**.
