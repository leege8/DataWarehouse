With all_trips as
(select t.*,
        {{null_to_NA("borough")}} as borough,
        {{null_to_NA("zone")}} as zone
from {{ ref('mart__fact_all_taxi_trips') }} t
left join {{ ref('mart__dim_locations') }} pl on t.PUlocationID = pl.LocationID)

SELECT borough,
       zone,
       count(*) as number_of_trip,
       avg(duration_min) as average_duration_min,
       avg(duration_sec) as average_duration_sec,
FROM all_trips
group by All
