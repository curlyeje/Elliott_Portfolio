
# SQL Deep Dive — Healthcare Analytics Case Study
## SQL Skills, Analysis, and Recommendations (Snowflake → Tableau)

**Author:** Elliott Earley  
**Platform:** Snowflake SQL  
**Dataset:** LYRA_BIG_DEMO.PUBLIC  
**Reporting Period (when applicable):** 2023-12-01 → 2025-12-01 (end-exclusive)  
**Last Updated:** 2025-12-26  

---

## Purpose of This Document

This document showcases **end-to-end SQL proficiency** in a healthcare analytics context.  
It demonstrates not only *how* queries were written, but also *why* they were written that way and *what decisions the results support*.

Each question includes:
- The business question
- The SQL approach and techniques used
- Key analysis takeaways
- Actionable recommendations

This mirrors how analytics work is reviewed in real healthcare organizations.

---

## Question 1 — Monthly New Enrollments

### Business Question
How are member enrollments trending month over month?

### SQL Approach
- Truncate enrollment dates to calendar month
- Aggregate enrollments at a monthly grain
- Order results chronologically for trend analysis

### SQL Concepts Demonstrated
- `DATE_TRUNC`
- Aggregation with `COUNT(*)`
- Time-series grouping

### SQL
```sql
SELECT
  DATE_TRUNC('month', ENROLL_DATE) AS enrollment_month,
  COUNT(*) AS new_enrollments
FROM LYRA_BIG_DEMO.PUBLIC.D_MEMBERS
GROUP BY enrollment_month
ORDER BY enrollment_month ASC;
```

**Screenshot**: <img width="1589" height="1253" alt="q01_monthly_new_enrollments_sql_output_updated" src="https://github.com/user-attachments/assets/6cb023cf-d5ec-4dbd-a7c9-41bc0ea58a33" />


### Analysis
- Enrollment trends act as an early signal of demand and growth.
- Sustained growth suggests effective acquisition or employer expansion.
- Volatility may reflect seasonality or onboarding cycles.

### Recommendations
- Track enrollments monthly as a core growth KPI.
- Investigate sudden spikes or drops to identify drivers.
- Use enrollment trends to anticipate capacity needs.

---

## Question 2 — Median Days to First Completed Session

### Business Question
How long does it take members to complete their first session after enrolling?

### SQL Approach
- Identify each member’s first completed session using `MIN(SESSION_DATE)`
- Join to enrollment records
- Calculate time-to-care using `DATEDIFF`
- Use `MEDIAN` to reduce outlier influence

### SQL Concepts Demonstrated
- Subqueries and joins
- `MIN()` aggregation
- `DATEDIFF`, `MEDIAN()`

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
**Screenshot**: <img width="1280" height="656" alt="q02_median_days_to_first_completed_session_sql_output" src="https://github.com/user-attachments/assets/2c14ef5f-3ee3-48a2-9125-4dcb19dd17d0" />

### Analysis
- Longer delays increase drop-off risk and delay clinical impact.
- Median provides a more stable measure than average.
- Extreme values may indicate access bottlenecks or data issues.

### Recommendations
- Set clear internal benchmarks for time-to-first-session.
- Prioritize fast scheduling for newly enrolled members.
- Monitor this metric as an access health indicator.

---

## Question 3 — No-Show Rate (Appointments vs Sessions)

### Business Question
How often do members miss scheduled care events?

### SQL Approach
- Calculate totals and no-shows separately
- Combine appointment and session results using `UNION ALL`
- Compute rates via conditional aggregation

### SQL Concepts Demonstrated
- `UNION ALL`
- Conditional aggregation (`IFF`)
- Rate calculations

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
**Sceenshot**: <img width="1434" height="732" alt="q03_no_show_rate_by_event_type_sql_output" src="https://github.com/user-attachments/assets/a4ce870c-886f-43eb-b928-eb6f309790b4" />

### Analysis
- No-shows reduce effective capacity and continuity of care.
- Differences by event type reveal engagement friction points.

### Recommendations
- Use reminders and confirmations to reduce no-shows.
- Focus interventions on early visits where no-show risk is highest.

---

## Question 4 — Cancellation Rate by Group

### Business Question
Which groups cancel most often, and what does that reveal about access friction?

### SQL Approach
- Bucket appointment lead times using `CASE`
- Normalize cancellation flags
- Combine appointment and session data
- Segment by modality and timing

### SQL Concepts Demonstrated
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
**Screenshot**: <img width="2280" height="2155" alt="q04_cancellation_rate_sql_output_final_cleaned" src="https://github.com/user-attachments/assets/92589ed5-7b52-4442-8e69-6e35cf3d69a9" />


### Analysis
- High cancellation rates indicate scheduling friction.
- Longer lead times and certain modalities are more prone to cancellations.

### Recommendations
- Reduce long lead times where possible.
- Promote lower-cancellation modalities when appropriate.
- Use this metric to refine scheduling strategies.

---

## Question 5 — Sessions per Active Member

### Business Question
How engaged are active members?

### SQL Approach
- Filter to completed sessions
- Aggregate at member level
- Compute average engagement

### SQL Concepts Demonstrated
- CTEs
- Member-level aggregation

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
**Screenshot**:<img width="4116" height="1596" alt="q05_sessions_per_active_member_sql_output_readable_v2" src="https://github.com/user-attachments/assets/ab831539-2fc7-4d8c-b296-15021ccb8c93" /> 

### Analysis
- Low session counts suggest shallow engagement.
- One-and-done behavior limits clinical improvement.

### Recommendations
- Encourage follow-up scheduling during the first session.
- Track progression to 2+, 3+, and 5+ sessions.

---

## Question 6 — Claims Status Mix

### Business Question
What share of claims are paid, denied, or pending?

### SQL Approach
- Aggregate claims by status
- Use window functions to compute distribution

### SQL Concepts Demonstrated
- Window functions
- Distribution analysis

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
**Screenshot**: 
<img width="3465" height="1480" alt="q06_claim_status_mix_sql_output" src="https://github.com/user-attachments/assets/6f65c4c4-ccf2-4525-88af-b52f6a171092" />

### Analysis
- Paid % reflects billing effectiveness.
- Pending claims represent cash-flow risk.
- Denials create rework and revenue leakage.

### Recommendations
- Monitor claims mix monthly.
- Break denials down by payer and code.
- Actively manage aging pending claims.

---

## Question 7 — Average Cost per Completed Session

### Business Question
What is the unit cost of delivering care?

### SQL Approach
- Filter to completed sessions with valid cost
- Compute average cost and volume

### SQL Concepts Demonstrated
- Data quality filtering
- Cost aggregation

### SQL
```sql
SELECT
  ROUND(AVG(SESSION_COST_USD), 2) AS avg_cost_per_completed_session_usd,
  COUNT(*) AS completed_sessions
FROM LYRA_BIG_DEMO.PUBLIC.F_SESSIONS
WHERE STATUS = 'Completed'
  AND SESSION_COST_USD IS NOT NULL;
```

### Analysis
- Unit cost directly affects PMPM and budgeting.
- Small changes scale rapidly at high volume.

### Recommendations
- Monitor trends over time.
- Pair cost metrics with outcomes to ensure value.

---

## Question 8 — High / Urgent Ticket Rate

### Business Question
Are high-severity support issues increasing over time?

### SQL Approach
- Aggregate tickets by month
- Isolate High/Urgent priorities
- Compute severity rate

### SQL Concepts Demonstrated
- Time-series aggregation
- Conditional counting

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

### Analysis
- Rising severity signals operational stress.
- Often precedes declines in member satisfaction.

### Recommendations
- Use as an early-warning KPI.
- Investigate root causes by category.

---

## Question 9 — Baseline Severity Distribution

### Business Question
What is the clinical acuity of members entering care?

### Analysis
- High baseline severity implies complex care needs.
- Provides context for utilization and cost metrics.

### Recommendations
- Fast-track high-severity members.
- Align care intensity to baseline need.

---

## Question 10 — Outcome Improvement by Session Count

### Business Question
Do members with more sessions experience better outcomes?

### Analysis
- Clear dose–response relationship exists.
- Low session counts limit improvement.

### Recommendations
- Focus on reducing early disengagement.
- Set expectations for multi-session care.

---

## Final Takeaway

This SQL work demonstrates the ability to:
- Frame healthcare business questions
- Write clean, production-quality SQL
- Interpret results in clinical and operational context
- Deliver insights leaders can act on
