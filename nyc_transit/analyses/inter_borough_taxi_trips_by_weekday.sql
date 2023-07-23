select
    diff.Weekday,
    trips_different_borough,
    trips_total,
    CONCAT(ROUND(trips_different_borough /trips_total * 100, 2), '%') AS Percentage_trips_different_borough
from
(
  select
      DAYOFWEEK(pickup_datetime) as Weekday,
      count(*) as trips_different_borough
  from mart__fact_all_taxi_trips a
  left join mart__dim_locations b
  on a.pulocationid = b.locationid
  left join mart__dim_locations c
  on a.dolocationid = c.locationid
where b.borough <> c.borough
group by DAYOFWEEK(pickup_datetime) ) diff

join
(
  select
      DAYOFWEEK(pickup_datetime) as Weekday,
      count(*) as trips_total
  from mart__fact_all_taxi_trips a
  left join mart__dim_locations b
  on a.pulocationid = b.locationid
  left join mart__dim_locations c
  on a.dolocationid = c.locationid
  group by DAYOFWEEK(pickup_datetime) ) total

on diff.Weekday = total.Weekday
ORDER BY diff.Weekday;

