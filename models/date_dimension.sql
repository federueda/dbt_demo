/* 
Recommended dbt approach is to use CTEs

Select if you want to convert this model into a TABLES or MATERIALIZED VIEW
*/

{{ config(materialized='table') }}

WITH DATE_CTE AS (
    select
    
    TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
    DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AT,
    HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AT,

/*
    -- do this if used only once
    CASE
    WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN ('Sat','Sun')
    THEN 'WEEKEND'
    ELSE 'BUSINESS_DAY'
    END
    AS DAY_TYPE,

    -- do this if used only once
    CASE
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (3,4,5)
    THEN 'SPRING'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN'
    END
    AS STATION_OF_YEAR,
*/

    -- Now, if used several times, create a macro and use it when needed
    
    {{day_type('STARTED_AT')}} AS DAY_TYPE,
    {{get_season('STARTED_AT')}} AS STATION_OF_YEAR,
    
    from
    {{ source('demo', 'bike') }}
    where STARTED_AT != 'started_at'
    -- limit 5 -- to preview
)

SELECT *
FROM DATE_CTE