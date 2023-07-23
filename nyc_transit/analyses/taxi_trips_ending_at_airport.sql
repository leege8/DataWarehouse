select count(*)
from mart__fact_all_taxi_trips a
join mart__dim_locations b
on a.dolocationid = b.locationid
where b.service_zone in ('Airports', 'EWR');
