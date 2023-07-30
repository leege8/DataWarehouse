select date, precipitation,
       MIN(precipitation) OVER weather_window AS min_precipitation,
       MAX(precipitation) OVER weather_window AS max_precipitation,
       AVG(precipitation) OVER weather_window AS avg_precipitation,
       SUM(precipitation) OVER weather_window AS sum_precipitation,
       MIN(snowfall) OVER weather_window AS min_snowfall,
       MAX(snowfall) OVER weather_window AS max_snowfall,
       AVG(snowfall) OVER weather_window AS avg_snowfall,
       SUM(snowfall) OVER weather_window AS sum_snowfall
from {{ ref('stg__daily_citi_bike_trip_counts_and_weather') }}
WINDOW weather_window AS (
	ORDER BY date
    	ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING
)
