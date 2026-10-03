Cleaning and analysing a delivery dataset (25,000 deliveries) with pandas, SQL and Tableau, to find what drives late deliveries.

**Live dashboard:** [https://public.tableau.com/views/DeliveryLogisticsAnalysis/DeliveryDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]

## THE DATA
"Delivery Logistics Dataset" from Kaggle (by Ayesha Seher). 15 columns: delivery partner, region, weather, distance, expected and actual delivery time, status, rating and cost. I couldn't confirm whether the data is real or generated, so findings are about this dataset only.

## PROBLEMS I FOUND AND WHAT I DID
| Problem | Rows | Decision |
|---|---|---|
| Same delivery ID repeated in two blocks (250.99 and 24750.01) | 500 | Different deliveries, so I kept them, flagged them and made a new unique ID |
| Both time columns stored as fake 1970 dates (the real value was hours) | 25,000 | Extracted the hours into new columns |
| The file's "delayed" flag included failed deliveries | 1,328 | Kept failed separate from late |
| "Delivered" orders with 0 hours | 255 | Flagged, not deleted (cause unknown) |
| Status labels didn't always match the hours (about 963 "delayed" rows weren't late by the hours, about 1,088 "failed" rows were) | about 2,000 | Built my own late flag from the hours and kept the original status |

Checked and not found: missing values, negative times, an incomplete last row. No rows were deleted.

## What I found
- **Weather is the main driver.** Late rate was 29.5% in stormy weather and 27.1% in rainy, against about 9% to 10% in clear, hot and cold weather.
- Carrier (about 16% to 19%) and region (about 16.5% to 18%) made only small differences.
- Average rating: 4.2 for delivered, 2.4 for delayed, 1.3 for failed.
- These are patterns, not proof of cause.

## Files
- `notebook (.ipynb)`: loading, checking, cleaning, and the same checks in SQLite
- `queries.sql`: the 5 SQL queries
- `delivery_logistics_clean.csv`: the cleaned data used in Tableau

## Dashboard notes
Built in Tableau Public with a calculated field (on time / late / failed), a parameter for the late threshold, and a click-to-filter action on carrier. The threshold slider only controls the weather chart.
