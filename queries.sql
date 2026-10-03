--Table: deliveries (cleaned data, 25,000 rows)
-- Late = actual hours > expected hours, failed deliveries not counted as late

-- 1: find delivery IDs used by more than one row
SELECT delivery_id, COUNT(*) AS times_used
FROM deliveries
GROUP BY delivery_id
HAVING COUNT(*) > 1;

-- 2: late rate by delivery partner
SELECT delivery_partner,
       AVG(late_not_failed) AS late_rate
FROM deliveries
GROUP BY delivery_partner
ORDER BY late_rate DESC;

-- 3: late rate by region
SELECT region,
       AVG(late_not_failed) AS late_rate
FROM deliveries
GROUP BY region
ORDER BY late_rate DESC;

-- 4: late rate by weather
SELECT weather_condition,
       AVG(late_not_failed) AS late_rate
FROM deliveries
GROUP BY weather_condition
ORDER BY late_rate DESC;

-- 5: the most delayed delivery in each weather type (failed ones left out)
SELECT weather_condition, clean_id, delivery_partner, delay_hours
FROM (
    SELECT weather_condition, clean_id, delivery_partner, delay_hours,
           ROW_NUMBER() OVER (
               PARTITION BY weather_condition
               ORDER BY delay_hours DESC
           ) AS rn
    FROM deliveries
    WHERE is_failed = 0
)
WHERE rn = 1;
