with trips_renamed as
(
    select
        type,
        pickup_datetime AS started_at_ts,
        dropoff_datetime AS ended_at_ts,
        duration_min,
        duration_sec
    from {{ ref('mart__fact_all_taxi_trips') }}
    union all
    select
        'bike' as type,
        started_at_ts,
        ended_at_ts,
        duration_min,
        duration_sec
    from {{ ref('mart__fact_all_bike_trips') }}
)

select
    type,
    started_at_ts,
    ended_at_ts,
    duration_min,
    duration_sec
from trips_renamed
