select  date, precipitation,
	(LAG(precipitation, 3, 0) OVER (ORDER BY date) +
	 LAG(precipitation, 2, 0) OVER (ORDER BY date) +
	 LAG(precipitation, 1, 0) OVER (ORDER BY date) +
	 precipitation +
	 LEAD(precipitation, 1, 0) OVER (ORDER BY date) +
	 LEAD(precipitation, 2, 0) OVER (ORDER BY date) +
	 LEAD(precipitation, 3, 0) OVER (ORDER BY date)) / 7 AS moving_avg_precipitation
from {{ ref('stg__daily_citi_bike_trip_counts_and_weather') }};
