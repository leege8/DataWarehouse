With all_trips as
(select tpep_pickup_datetime,
	tpep_dropoff_datetime,
	fare_amount,
        {{null_to_NA("borough")}} as borough,
        {{null_to_NA("zone")}} as zone
from {{ ref('stg__yellow_tripdata') }} t
left join {{ ref('mart__dim_locations') }} pl
on t.PUlocationID = pl.LocationID
where zone in ('Newark Airport', 'Jamaica Bay')
 -- Out of Memory Error at 20% completion. Reduce the dataset by specifying two zones
)

select tpep_pickup_datetime,
       tpep_dropoff_datetime,
       fare_amount,
       AVG(fare_amount) OVER (PARTITION BY borough) AS borough_average_fare_amount,
       AVG(fare_amount) OVER (PARTITION BY zone) AS zone_average_fare_amount,
       AVG(fare_amount) OVER () AS overall_average_fare_amount
from all_trips
