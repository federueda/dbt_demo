/* 
Recommended dbt approach is to use CTEs

Select if you want to convert this model into a TABLES or MATERIALIZED VIEW
*/

{{ config(materialized='table') }}

WITH DAILY_WEATHER_CTE AS(

select 

date(time) as daily_weather,
weather,
temp,
pressure,
humidity,
clouds

from {{ source('demo', 'weather') }}

),

DAILY_WEATHER_AGGREGATE_CTE AS(

select

daily_weather,
weather,
round(avg(temp),2) as avg_temp,
round(avg(pressure),2) as avg_pressure,
round(avg(humidity),2) as avg_humidity,
round(avg(clouds),2) as avg_clouds

from DAILY_WEATHER_CTE

group by daily_weather, weather

-- use qualify because we cannot use WHERE statement in a GROUP BY statement
qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(weather) DESC) = 1

)

SELECT *
FROM DAILY_WEATHER_AGGREGATE_CTE