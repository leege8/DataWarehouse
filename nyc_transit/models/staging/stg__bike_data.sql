with source as (
	
	select * from {{ source('main', 'bike_data') }}
),

renamed as (

	select 
		ride_id,
		rideable_type,
		started_at::timestamp AS started_at,
		ended_at::timestamp AS ended_at,
		datediff('second', CAST(started_at AS timestamp), CAST(ended_at AS timestamp)) AS trip_duration,
		start_station_name,
		start_station_id,
		end_station_name,
		end_station_id,
		cast(start_lat as double) AS start_lat,
		cast(start_lng as double) AS start_lng,
		cast(end_lat as double) AS end_lat,
		cast(end_lng as double) AS end_lng,
		member_casual,
		filename
	from source where ride_id is not null
	
	union all
	
	select
		UUID()::varchar AS ride_id,
		'docked_bike' AS rideable_type,
		starttime::timestamp AS started_at,
		stoptime::timestamp AS ended_at,
		tripduration::bigint AS trip_duration,
		'start station name' AS start_station_name,
		'start station id' AS start_station_id,
		'end station name' AS end_station_name,
		'end station id' AS end_station_id,
		TRY_CAST('start station latitude' as double) AS start_lat,
		TRY_CAST('start station longitude' as double) AS start_lng,
		TRY_CAST('end station latitude' as double) AS end_lat,
		TRY_CAST('end station longitude' as double) AS end_lng,
		case when usertype = 'Subscriber' then 'member'
 		     when usertype = 'Customer' then 'casual'
		ELSE NULL END AS member_casual,
		filename
	from source where ride_id is null
		
)

select * from renamed
