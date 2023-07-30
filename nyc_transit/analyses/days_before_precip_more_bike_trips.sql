--count the number of trips by each day
With trips_count AS (
select cast(started_at_ts as date) as date,
	count(*) as trip_count
from {{ ref('mart__fact_all_bike_trips') }}
group by all
order by cast(started_at_ts as date)),

--identify days with either precipitation or snow, mark these days as 'Y'
all_trips AS (
select  a.date,
	trip_count,
	case when prcp > 0 then 'Y'
	     when snow > 0 then 'Y'
	else 'N' end as prcp_or_snow
from trips_count a
join {{ ref('stg__central_park_weather') }} b
on a.date = b.date
order by a.date),

--use lead to get the number of trips and weather condition of the next day
preceeding_trips AS (
select *,
	lead(prcp_or_snow) over (order by date) AS next_prcp_or_snow,
	lead(trip_count) over (order by date) AS next_trip_count
from all_trips)

--only interested in the days that have precipitation or snow and days right before that
--use avg to compute the average number of trips before and on precipitation or snow days. 
select  avg(trip_count) AS trip_count_preceding_prcp_or_snow,
	avg(next_trip_count) AS trip_count_with_prcp_or_snow
from preceeding_trips
where prcp_or_snow = 'N' and next_prcp_or_snow = 'Y'
-- when the next day is 'Y' and the day before is 'N'(no precipitation or snow)
