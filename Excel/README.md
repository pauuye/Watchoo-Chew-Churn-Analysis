# Excel — WCC Customer Churn Dashboard

This folder contains the Excel workbook used for pivot table analysis and visual dashboard reporting on the `wcc_customer_churn.csv` dataset.

---

## File

| File | Description |
|---|---|
| `WCC_Churn.xlsx` | Excel workbook with raw data, pivot tables, summary, and dashboard |

---

## Workbook Structure

| Sheet | Contents |
|---|---|
| `netflix_customer_churn` | Raw dataset with an added `age_group` column for segmentation |
| `Summary` | Executive summary covering objectives, data preparation steps, analysis performed, and key findings |
| `Pivot Tables` | Aggregated tables covering churn by age group, region, subscription type, device, payment method, and gender |
| `Dashboard` | Visual dashboard — Watchoo Chew Churn Analysis |

---

## Dashboard Overview

The dashboard presents churn insights across the following dimensions:

**Subscription**
- Basic plan accounts for 40.8% of all churn
- Standard and Premium plans churn at comparable rates (~29–30%)
- Basic subscribers have the lowest average watch hours and pay the lowest monthly fee

**Age Group**
- Seniors (55+) have the highest churn share at 30.9%
- Mature Adults (45–54) follow at 19.3%
- Mid Adults (35–44) have the highest average watch hours (12.9 hrs) but still churn at 17.2%

**Region**
- South America has the highest churn rate at 18.3% and the highest average monthly revenue at $2,697
- Oceania has the lowest churn rate at 14.7%
- Europe and North America are tied at 17.3%

**Payment Method**
- PayPal users have the highest churn rate (22.0%)
- Crypto users have the lowest churn rate (18.3%)
- All payment methods sit in a relatively narrow churn band (18–22%)

**Device**
- Desktop users have the highest average watch hours (13.0 hrs)
- Tablet users have the lowest average watch hours (10.3 hrs)
- TV users average 12.6 hrs — second highest engagement by device

**Gender**
- Female customers represent the largest churned segment (36.5%)
- Male customers follow at 30.4%
- Other gender category sits at 33.1%

---

## Key Metrics (Overall)

| Metric | Value |
|---|---|
| Total Customers | 1,661 |
| Total Churned | 1,027 |
| Overall Churn Rate | ~61.8% |
| Average Watch Hours | 11.6 hrs |

---

## Key Findings

- Users with low daily average watch time are the strongest indicator of churn risk
- Basic plan subscribers churn at a disproportionately high rate relative to their user share
- South America generates the most monthly revenue but also has the highest churn — a high-value, high-risk market
- PayPal may have payment processing friction contributing to unintended churn
- Oceania shows the best retention, which could be used as a benchmark for other regions

---

## Recommendations

| Priority | Action |
|---|---|
| High | Target Basic plan churners with a time-limited loyalty offer or plan upgrade incentive |
| High | Audit PayPal payment experience — reduce failed or lapsed billing as a quick churn fix |
| Medium | Build a Senior (55+) retention programme — curated content, simpler UX, or personal outreach |
| Medium | Deep-dive South America — high revenue at risk; investigate content gaps or pricing sensitivity |
| Low | Use Oceania's retention data as a benchmark; replicate what's working there in other regions |
| Low | Explore Tablet-specific content or onboarding improvements to lift engagement for low-watch users |

---

## Data Preparation Notes

- No duplicates were found in the dataset
- `customer_id` confirmed as unique across all rows (UUID format)
- `age_group` column added in Excel for segmentation clarity
- Churn indicator values (0 and 1) confirmed consistent across the dataset
- Numeric fields (watch hours, daily watch time, monthly fees) validated for formatting
