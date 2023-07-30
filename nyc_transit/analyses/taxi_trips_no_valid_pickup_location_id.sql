select a.*
from mart__fact_all_taxi_trips a
left join  mart__dim_locations b
on a.pulocationid = b.locationid
where b.locationid is null;
