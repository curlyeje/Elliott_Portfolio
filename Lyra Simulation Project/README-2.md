
# Reporting Period & Metric Alignment (README)

## Overview
This document explains the **reporting period** used in the SQL worksheet and how all metrics (Q1–Q10) are aligned to it. It also clarifies a common issue encountered in **Q6 (Claims Status Mix)** and how it was resolved.

**Owner:** Elliott Earley  
**Last Updated:** 2025-12-26  

---

## Reporting Period (Single Source of Truth)

All time-bounded metrics in this worksheet use the same fixed reporting window:

- **Start (inclusive):** `2023-12-01`
- **End (exclusive):** `2025-12-01`

This represents a **clean 24‑month window**:
- Includes December 2023 through November 2025
- Excludes December 2025 to avoid partial-month data
- Prevents off‑by‑one errors and month overlap

### Why “end‑exclusive”?
Using `< '2025-12-01'` (instead of `<=`) ensures:
- No partial months
- Consistent month-based reporting
- Industry-standard analytics practice

---

## Standard SQL Pattern Used Everywhere

All aligned queries use this shared CTE to guarantee consistency:

```sql
WITH reporting_period AS (
  SELECT
    TO_DATE('2023-12-01') AS start_date,
    TO_DATE('2025-12-01') AS end_date
)
```

Each metric then filters on the **appropriate date field** for that dataset.

---

## How Each Metric Uses the Reporting Period

| Question | Metric | Date Field Used |
|--------|-------|-----------------|
| Q1 | Monthly New Enrollments | `D_MEMBERS.ENROLL_DATE` |
| Q2 | Median Days to First Session | `ENROLL_DATE`, `SESSION_DATE` |
| Q3 | No‑Show Rate | Appointment Date / `SESSION_DATE` |
| Q4 | Cancellation Rate | Appointment Date / `SESSION_DATE` |
| Q5 | Sessions per Active Member | `F_SESSIONS.SESSION_DATE` |
| Q6 | Claims Status Mix | `F_CLAIMS.CREATED_DATE` |
| Q7 | Avg Cost per Completed Session | `F_SESSIONS.SESSION_DATE` |
| Q8 | High/Urgent Ticket Rate | `F_TICKETS.CREATED_DATE` |
| Q9 | Baseline Severity Distribution | `F_OUTCOMES.MEASURE_DATE` |
| Q10 | Outcome Change by Session Count | `SESSION_DATE`, `MEASURE_DATE` |

---

## Important Note on Q6 (Claims Status Mix)

### The Issue
An error occurred:

```
invalid identifier 'C.CLAIM_DATE'
```

This happened because **`CLAIM_DATE` does not exist** in the `F_CLAIMS` table.

### The Fix
Instead of `CLAIM_DATE`, the query uses:

- **`CREATED_DATE`** → the date the claim entered the system

This is the **best-practice choice** for defining a claims reporting population because it:
- Avoids mixing legacy claims with current workflows
- Keeps Pending % meaningful
- Aligns with revenue-cycle reporting standards

### Corrected & Aligned Q6 Logic
```sql
WITH reporting_period AS (
  SELECT 
    TO_DATE('2023-12-01') AS start_date,
    TO_DATE('2025-12-01') AS end_date
),
claims_in_period AS (
  SELECT
    c.CLAIM_STATUS
  FROM LYRA_BIG_DEMO.PUBLIC.F_CLAIMS c
  JOIN reporting_period rp ON 1=1
  WHERE c.CREATED_DATE >= rp.start_date
    AND c.CREATED_DATE <  rp.end_date
)
SELECT
  CLAIM_STATUS,
  COUNT(*) AS claim_count,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER (), 4) AS pct_of_claims
FROM claims_in_period
GROUP BY CLAIM_STATUS
ORDER BY claim_count DESC;
```

### How to Explain This Simply
> “Claims are filtered based on when they were created, so Paid, Denied, and Pending percentages reflect claims initiated during the reporting period—not historical backlog.”

---

## Why This Matters

Aligning all metrics to a single reporting period ensures:

- **Consistency:** Every KPI answers the same time-based question
- **Comparability:** Metrics can be compared across domains (clinical, ops, finance)
- **Trust:** Stakeholders know exactly what time window they are seeing
- **Scalability:** The reporting period can be changed in one place

---

## Summary (Plain English)

- The worksheet uses a **24‑month reporting period**
- Dates run from **Dec 1, 2023 → Dec 1, 2025**
- All queries are aligned using the same pattern
- Q6 was corrected to use `CREATED_DATE`, which is the right field
- The result is a clean, defensible, leadership-ready analytics foundation

---

If this workbook is extended or productionized, keep the reporting period centralized and documented here.
