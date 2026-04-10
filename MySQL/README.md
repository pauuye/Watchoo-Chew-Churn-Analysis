# MySQL — WCC Customer Churn EDA

This folder contains the SQL script used for exploratory data analysis (EDA) on the `wcc_customer_churn.csv` dataset, loaded into MySQL as the `netflix` table.

---

## File

| File | Description |
|---|---|
| `WCC_EDA.sql` | Full EDA pipeline — data validation, deduplication, and analytical queries |

---

## What the Script Does

### Data Validation
- Checks for duplicate records using `ROW_NUMBER() OVER(PARTITION BY ...)` across all key fields
- Validates `customer_id` length to confirm UUID formatting consistency
- Inspects distinct values and field ranges (e.g. age, churned flag)

### Exploratory Analysis

**Demographics**
- Customer distribution by gender with percentage share
- Age bracketing into four groups: Young Adult (18–29), Adult (30–44), Middle Age (45–59), Senior (60+)
- Churn rate and churn share by age bracket
- Average watch hours and monthly fee by age bracket

**Subscription Behaviour**
- Churn rate and user share by subscription type (Basic, Standard, Premium)
- Subscription type breakdown by age bracket — identifies the most popular plan per group

**Device Usage**
- Device usage distribution by age bracket (TV, Mobile, Laptop, Desktop, Tablet)
- Churn rate by device type — ranked by highest churned percentage

**Region**
- Total customers and churn count by region
- Monthly revenue and churn rate by region — identifies high-value, high-risk markets

**Payment Methods**
- Churn rate by payment method
- Most used payment method by age bracket

---

## Key SQL Patterns Used

```sql
-- Age bracketing with CASE WHEN
CASE 
    WHEN age BETWEEN 18 AND 29 THEN 'Young Adult (18-29)'
    WHEN age BETWEEN 30 AND 44 THEN 'Adult (30-44)'
    WHEN age BETWEEN 45 AND 59 THEN 'Middle Age (45-59)'
    WHEN age >= 60 THEN 'Senior (60+)'
END AS Bracket

-- Churn rate calculation
CONCAT(ROUND(SUM(churned) / COUNT(*) * 100, 2), '%') AS churn_rate

-- Window function for percentage share
CONCAT(ROUND(total_count / SUM(total_count) OVER() * 100, 2), '%') AS percentage

-- Most used value across columns using GREATEST + CASE
CASE GREATEST(Basic, Standard, Premium)
    WHEN Basic THEN 'Basic'
    WHEN Standard THEN 'Standard'
    WHEN Premium THEN 'Premium'
END AS Top_Availed
```

---

## Key Findings from SQL Analysis

| Area | Finding |
|---|---|
| Age & Churn | Middle Age (45-59) and Senior (60+) segments have the highest churn concentration |
| Watch Hours | Lower average daily watch time correlates with higher churn across age groups |
| Subscription | Basic plan has the highest churn rate and lowest average watch hours |
| Devices | All age groups use a spread of devices; no single device dominates across brackets |
| Region | South America and Europe show weaker retention than Oceania and Africa |
| Payment | Crypto payment method shows notable correlation with churn — may reflect payment reliability issues |

---

## Recommendations from EDA

- **Loyalty programme for Basic subscribers** — they churn most and watch the least. A usage-based incentive could improve both.
- **Re-engagement flow for 45+ users** — targeted content recommendations or simplified onboarding may reduce early drop-off.
- **Investigate Crypto payment failures** — if payment processing is unreliable for Crypto users, this directly causes avoidable churn.
- **Regional content strategy review** — South America and Europe churn at higher rates; local content investment or pricing adjustment may help.

---

## How to Run

1. Load `wcc_customer_churn.csv` into a MySQL database as a table named `netflix`
2. Open `WCC_EDA.sql` in MySQL Workbench or your preferred SQL client
3. Run queries section by section — each block is commented with its purpose and findings
