# Power BI — WCC Customer Churn Analysis

This folder contains the Power BI report for interactive churn analysis on the `wcc_customer_churn.csv` dataset.

---

## File

| File | Description |
|---|---|
| `Churned_Analysis.pbix` | Power BI report — 2 pages covering the churn dashboard and written summary |

---

## Report Structure

### Page 1 — Dashboard
Interactive visual dashboard with cross-filtering across all visuals.

### Page 2 — Summary
Written narrative summarising key findings per dimension, with churn rates highlighted.

---

## KPI Cards

| Metric | Value |
|---|---|
| Churn Rate (%) | 50.30% |
| Avg. Watch Time (Hrs/s) | 11.65 |
| Total Revenue (USD) | $68.42K |

---

## Visuals

### Churn Rate (%) by User's Watch Time — Combo Line Chart
Plots customer count (bar) against churn rate (line) across daily watch time buckets.

| Watch Time | Churn Rate |
|---|---|
| 0–10 mins | 68.4% |
| 11–20 mins | 40.0% |
| 21–30 mins | 7.1% |
| 31–40 mins | 1.0% |
| 41–50 mins | 1.1% |
| 50+ mins | ~0% |

**Takeaway:** Churn drops sharply as daily watch time increases. Users watching less than 20 minutes per day are at very high churn risk.

---

### Engagement Behavior by Age Group: Watch Time vs Last Login Days — Scatter Chart
Plots average daily watch time (x-axis) against average last login days (y-axis), colour-coded by age group. A dotted reference line marks the average churn rate threshold.

**Age groups included:** Young Adult (18–24), Early Adult (25–34), Mid Adult (35–44), Mature Adult (45–54), Senior (55+)

**Takeaway:** No single age group clusters neatly below the churn threshold — churn is spread across all groups, but users with low watch time and high last-login-days (i.e. infrequent users) sit above the risk line.

---

### Churn Rate (%) by Device Usage — Bar Chart
Compares churn rate across five device types.

| Device | Churn Rate |
|---|---|
| Laptop | 51.79% |
| Mobile | 50.50% |
| Tablet | 50.00% |
| TV | 49.95% |
| Desktop | 49.21% |

**Takeaway:** Churn rates are fairly uniform across devices (~49–52%). Laptop, Mobile, and Tablet sit slightly higher, likely because these are multi-purpose devices with more competing distractions.

---

### Churn Rate (%) by Subscription Plan — Donut Chart
Breaks down churn distribution across subscription tiers.

| Plan | Churn Rate | Churn Share |
|---|---|---|
| Basic | 61.83% | 40.95% |
| Standard | 45.44% | 30.1% |
| Premium | 43.71% | 28.95% |

**Takeaway:** Basic is both the most subscribed plan and the highest churning one. Premium and Standard retain users at a notably better rate.

---

### Most Watched Movie/s and TV Series Genre — Horizontal Bar Chart
Ranks genres by total view count.

| Genre | Views |
|---|---|
| Drama | 731 |
| Documentary | 729 |
| Romance | 725 |
| Sci-Fi | 720 |
| Horror | 713 |
| Action | 697 |
| Comedy | 685 |

**Takeaway:** Drama is the most watched genre but records a high churn rate — second only to Action. Popularity alone does not guarantee retention.

---

## Slicers

Users can filter all visuals simultaneously using:

| Slicer | Options |
|---|---|
| Age Group | Young Adult, Early Adult, Mid Adult, Mature Adult, Senior |
| Subscription Type | Basic, Standard, Premium |
| Payment Method | Credit Card, Debit Card, PayPal, Gift Card, Crypto |
| Region | Asia, Africa, Europe, North America, Oceania, South America |

---

## Summary Page — Key Findings

| Dimension | Finding |
|---|---|
| Overall | Churn rate is 50.3% — approximately half of all subscribers did not renew |
| Age | Mature Adults (43–54) have the highest churn rate at 53.97% |
| Subscription | Basic plan records the highest churn at 61.83% — users may subscribe short-term for specific content |
| Device | Laptops, Mobile, and Tablets have the highest churn rates — multi-purpose use reduces focused viewing |
| Genre | Drama is most watched but has the second highest churn rate after Action |

---

## Recommendations

| Priority | Action |
|---|---|
| High | Flag users with under 20 mins daily watch time for automated re-engagement (push notifications, email, content prompts) |
| High | Introduce a Basic plan retention offer — trial upgrade, loyalty discount, or content bundle |
| Medium | Design a Mature Adult (43–54) retention strategy — curated content aligned to lifestyle and interests |
| Medium | Explore Drama and Action content depth — high viewership with high churn may signal a content completion or library gap |
| Low | Test device-specific UI improvements for Laptop and Mobile — reduce friction and distraction for casual viewers |
| Low | Use Desktop viewers as a retention benchmark — they have the lowest churn and highest focused engagement |

---

## How to Open

1. Download and install [Power BI Desktop](https://powerbi.microsoft.com/desktop)
2. Open `Churned_Analysis.pbix`
3. Use the slicers on Page 1 to filter by Age Group, Subscription Type, Payment Method, or Region
4. Navigate to Page 2 for the written summary of findings
