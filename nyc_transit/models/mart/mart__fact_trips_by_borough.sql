With all_trips as
(select t.*,
        {{null_to_NA("borough")}} as borough
from {{ ref('mart__fact_all_taxi_trips') }} t
left join {{ ref('mart__dim_locations') }} pl
on t.PUlocationID = pl.LocationID)

SELECT borough,
       count(*) as number_of_trip
FROM all_trips
group by All
