WITH all_trips AS (
  SELECT
    pickup_datetime,
    {{null_to_NA("zone")}} as zone
  FROM {{ ref('mart__fact_all_taxi_trips') }} t
  LEFT JOIN {{ ref('mart__dim_locations') }} pl ON t.PUlocationID = pl.LocationID
  where zone in ('Newark Airport', 'Jamaica Bay')
  -- Out of Memory Error at 29% completion. Reduce the dataset by specifying two zones. 
)

SELECT
  zone,
  AVG(time_diff) AS avg_time_between_pickups_sec
FROM (
  SELECT
    zone,
    EXTRACT(EPOCH FROM (LEAD(pickup_datetime, 1) OVER (PARTITION BY zone ORDER BY pickup_datetime) - pickup_datetime)) AS time_diff
  FROM all_trips
) AS time_diff_table
GROUP BY zone
