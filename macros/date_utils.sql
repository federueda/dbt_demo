
-- macro to get the season from the started_at
{% macro get_season(x)%}

CASE
WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2)
THEN 'WINTER'
WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (3,4,5)
THEN 'SPRING'
WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8)
THEN 'SUMMER'
ELSE 'AUTUMN'
END

{% endmacro %}

-- macro to get the type of the day from the started_at
{% macro day_type(x)%}

CASE
WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN ('Sat','Sun')
THEN 'WEEKEND'
ELSE 'BUSINESS_DAY'
END

{% endmacro %}