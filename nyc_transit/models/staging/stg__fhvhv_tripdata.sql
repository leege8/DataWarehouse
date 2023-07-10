with source as (
	
	select * from {{ source('main', 'fhvhv_tripdata') }}
),

renamed as (

	select 
		hvfhs_license_num,
		dispatching_base_num,
		originating_base_num,
		request_datetime::timestamp AS request_datetime,
		on_scene_datetime::timestamp AS on_scene_datetime,
		pickup_datetime::timestamp AS pickup_datetime,
		dropoff_datetime::timestamp AS dropoff_datetime,
		PULocationID::bigint AS PULocationID,
		DOLocationID::bigint AS DOLocationID,
		trip_miles::double AS trip_miles,
		trip_time::bigint AS trip_time,
		base_passenger_fare::double AS base_passenger_fare,
		tolls::double AS tolls,
		bcf::double AS bcf,
		sales_tax::double AS sales_tax,
		congestion_surcharge::double AS congestion_surcharge,
		airport_fee::double AS airport_fee,
		tips::double AS tips,
		driver_pay::double AS driver_pay,

		CASE WHEN shared_request_flag = 'Y' THEN TRUE
		     WHEN shared_request_flag = 'N' THEN FALSE
		ELSE NULL END AS shared_request_flag,
		
		CASE WHEN shared_match_flag = 'Y' THEN TRUE
		     WHEN shared_match_flag = 'N' THEN FALSE
		ELSE NULL END AS shared_match_flag,

		CASE WHEN access_a_ride_flag = 'Y' THEN TRUE
		     WHEN access_a_ride_flag = 'N' THEN FALSE
		ELSE NULL END AS access_a_ride_flag,

		CASE WHEN wav_request_flag = 'Y' THEN TRUE
		     WHEN wav_request_flag = 'N' THEN FALSE
		ELSE NULL END AS wav_request_flag,

		CASE WHEN wav_match_flag = 'Y' THEN TRUE
		     WHEN wav_match_flag = 'N' THEN FALSE
		ELSE NULL END AS wav_match_flag,

		filename

	from source
)


select * from renamed

