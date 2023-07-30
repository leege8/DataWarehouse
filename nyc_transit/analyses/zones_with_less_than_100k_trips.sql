With all_trips as
(select t.*,
        {{null_to_NA("zone")}} as zone
from mart__fact_all_taxi_trips t
left join mart__dim_locations pl on t.PUlocationID = pl.LocationID)

SELECT zone,
       count(*) as number_of_trip,
FROM all_trips
group by All
having count(*) < 100000
