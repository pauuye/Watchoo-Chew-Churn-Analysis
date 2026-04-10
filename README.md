# Watchoo Chew, Inc. — Customer Churn Analysis

End-to-end data analytics project covering SQL exploratory analysis, Excel dashboard reporting, and Power BI interactive analytics — built on a streaming platform customer dataset with 1,661 customers across multiple regions, devices, and subscription tiers.

---

## Project Structure

```
Netflix-Project/
│
├── README.md                                   # This file
│
├── data/
│     └── netflix_customer_churn.csv            # Source dataset
│
├── MySQL/                                      # Data cleaning, preparation & exploratory analysis
│     ├── README.md
│     ├── WCC_EDA.sql
│     └── Screenshots/
│       ├── Avg-Spending-Churn.png
│       ├── Avg-WatchHrs-Affects-Churn.png
│       ├── Churned by Age-Bracket.png
│       ├── Churned by Device.png
│       ├── Duplicate.png
│       └── Subs-Type.png
│
├── Excel/                                      # Excel dashboard — churn insights by segment
│     ├── README.md
│     ├── WCC_Churn.xlsx
│     └── Screenshots
│       ├── Dashboard.png
│       ├── Pivot Tables.png
│       └── Summary.png
│
└── PowerBI/                                    # Power BI dashboard
      ├── README.md
      ├── Churned Analysis.pbix
      └── Screenshots/
         ├── Dashboard.png
         └── Summary.png
```


---

## Project Workflow

```
Raw Data  →  SQL (Clean + EDA)  →  Excel (Dashboard + Pivot Analysis)  →  Power BI (Interactive Report)
```

1. **SQL** — raw `netflix` table is explored, deduplicated, and analysed across demographics, behaviour, and payment attributes
2. **Excel** — pivot tables and a visual dashboard surface churn patterns by age, region, subscription, device, and payment method
3. **Power BI** — interactive report with cross-filtered drill-down and churn KPIs (see `Churned_Analysis.pbix`)

---

## Dataset Overview

The dataset covers customer behaviour from a streaming platform across the following dimensions:

| Dimension | Values |
|---|---|
| Total Customers | 1,661 unique customers |
| Churned Customers | 1,027 |
| Overall Churn Rate | ~61.8% |
| Regions | Asia, Africa, Europe, North America, Oceania, South America |
| Subscription Types | Basic, Standard, Premium |
| Devices | TV, Mobile, Laptop, Desktop, Tablet |
| Payment Methods | Credit Card, Debit Card, PayPal, Gift Card, Crypto |

**Dataset fields:** `customer_id`, `age`, `age_group`, `gender`, `subscription_type`, `watch_hours`, `last_login_days`, `region`, `device`, `monthly_fee`, `churned`, `payment_method`, `number_of_profiles`, `avg_watch_time_per_day`, `favorite_genre`

---

## File Summaries

### `WCC_EDA.sql`
MySQL script for the full exploratory data analysis pipeline:
- Duplicate detection using `ROW_NUMBER() OVER(PARTITION BY ...)`
- Data standardisation checks (field lengths, distinct values)
- Age bracketing and churn rate analysis by demographic group
- Subscription type and payment method churn breakdowns
- Device usage and churn rate by device type
- Regional churn and monthly revenue analysis

→ See [MySQL/README.md](MySQL/README.md) for full documentation

---

### `WCC_Churn.xlsx`
Excel workbook — **Watchoo Chew: Customer Churn Analysis Dashboard**

Contains 4 sheets including raw data, a summary, pivot tables, and a visual dashboard. Key metrics:
- Churn rate by age group and subscription type
- Average watch hours and monthly fee by segment
- Device usage distribution and churn rate per device
- Regional churn rate and total monthly revenue
- Payment method usage and corresponding churn rate

**Key finding:** Basic subscribers account for 40.8% of all churned customers. Seniors (55+) have the highest churn share at 30.9%. South America has the highest regional churn rate at 18.3%.

→ See [Excel/README.md](Excel/README.md) for full documentation

---

### `Churned_Analysis.pbix`
Power BI interactive report for cross-filtered churn analysis.

Features KPI cards, churn breakdown visuals by segment, and slicers for region, subscription type, device, and payment method. Enables drill-down analysis across all churn dimensions.

---

## Key Findings

| Area | Finding |
|---|---|
| Subscription | Basic plan has the highest churn share (40.8%) and the lowest average watch hours |
| Age | Seniors (55+) have the highest churn share (30.9%), despite moderate average watch hours |
| Region | South America has the highest churn rate (18.3%); Oceania has the lowest (14.7%) |
| Payment | PayPal users have the highest churn rate (22.0%); Crypto users are the most stable |
| Device | Tablet users have the lowest average watch hours (10.3 hrs) and a higher churn tendency |
| Gender | Female customers represent the largest churn segment (36.5% of churned users) |
| Behaviour | Low daily watch time is the strongest behavioural indicator of churn |

---

## Recommendations

| Priority | Action |
|---|---|
| High | Introduce a loyalty or incentive programme targeting Basic plan subscribers before they lapse |
| High | Investigate PayPal payment failures or friction — address checkout experience issues |
| Medium | Design re-engagement campaigns for the 55+ segment (e.g. simplified UX, curated content) |
| Medium | Review South American and European market strategies — pricing, content library, or support gaps may be driving churn |
| Low | Consider targeted upsell prompts for high-engagement Basic users to move them to Standard |
| Low | Explore device-specific onboarding improvements for Tablet users to lift engagement |

---

## Tools Used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Data cleaning, deduplication, EDA |
| Microsoft Excel | Pivot analysis, static dashboard |
| Power BI Desktop | Interactive analytics, churn KPIs |
| DAX | Custom measures for KPIs and churn calculations |
| Power Query (M) | Data transformation within Power BI |

---

## Author
hire me, bitte
