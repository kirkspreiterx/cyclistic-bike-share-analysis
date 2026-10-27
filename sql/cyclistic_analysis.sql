-- ==============================================================================
-- Cyclistic Bike-Share Case Study: Full SQL Pipeline (SQLite)
-- Author: Kirk Spreiter
-- Purpose: Consolidate 12 months of raw trip data, perform data cleaning/filtering,
--          and extract daily/monthly aggregations for Google Sheets visualization.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- STEP 1: Consolidate 12 Monthly Datasets into One Master Table
-- ------------------------------------------------------------------------------
CREATE TABLE all_trips AS
SELECT * FROM OCT26DIVY
UNION ALL SELECT * FROM SEPT26DIVY
UNION ALL SELECT * FROM AUG26DIVY
UNION ALL SELECT * FROM JULY26DIVY
UNION ALL SELECT * FROM JUNE26DIVY
UNION ALL SELECT * FROM MAY26DIVY
UNION ALL SELECT * FROM APR26DIVY
UNION ALL SELECT * FROM MAR26DIVY
UNION ALL SELECT * FROM FEB26DIVY
UNION ALL SELECT * FROM JAN26DIVY
UNION ALL SELECT * FROM DEC25DIVY
UNION ALL SELECT * FROM NOV25DIVY;

-- ------------------------------------------------------------------------------
-- STEP 2: Data Cleaning, Calculated Fields, & Outlier Removal
-- ------------------------------------------------------------------------------
CREATE TABLE cleaned_trips AS
SELECT 
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    end_station_name,
    member_casual,
    -- Calculate ride length in minutes
    ROUND((JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60, 2) AS ride_length_minutes,
    -- Extract day of week (0=Sunday, 1=Monday, ..., 6=Saturday)
    CAST(STRFTIME('%w', started_at) AS INTEGER) AS day_of_week,
    -- Extract month for seasonal trends
    STRFTIME('%m', started_at) AS trip_month
FROM all_trips
WHERE 
    -- Exclude invalid trip durations (trips under 1 minute or over 24 hours)
    (JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 >= 1
    AND (JULIANDAY(ended_at) - JULIANDAY(started_at)) * 24 * 60 <= 1440;

-- ------------------------------------------------------------------------------
-- STEP 3: Aggregation - Daily Usage Patterns (By User Type & Day of Week)
-- ------------------------------------------------------------------------------
SELECT 
    member_casual,
    CASE day_of_week
        WHEN 0 THEN 'Sun'
        WHEN 1 THEN 'Mon'
        WHEN 2 THEN 'Tue'
        WHEN 3 THEN 'Wed'
        WHEN 4 THEN 'Thu'
        WHEN 5 THEN 'Fri'
        WHEN 6 THEN 'Sat'
    END AS day_name,
    day_of_week,
    COUNT(ride_id) AS total_rides,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM cleaned_trips
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;

-- ------------------------------------------------------------------------------
-- STEP 4: Aggregation - Monthly Usage Patterns (By User Type & Month)
-- ------------------------------------------------------------------------------
SELECT 
    member_casual,
    trip_month,
    COUNT(ride_id) AS total_rides,
    ROUND(AVG(ride_length_minutes), 2) AS avg_ride_length_minutes
FROM cleaned_trips
GROUP BY member_casual, trip_month
ORDER BY trip_month, member_casual;
