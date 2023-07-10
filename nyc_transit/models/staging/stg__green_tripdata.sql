with source as (
	
	select * from {{ source('main', 'green_tripdata') }}
),

renamed as (

	select 
		VendorID::bigint AS VendorID,
		lpep_pickup_datetime::timestamp AS lpep_pickup_datetime,
		lpep_dropoff_datetime::timestamp AS lpep_dropoff_datetime,

		CASE WHEN store_and_fwd_flag = 'Y' THEN TRUE
		     WHEN store_and_fwd_flag = 'N' THEN FALSE
		ELSE NULL END AS store_and_fwd_flag,
		RatecodeID::bigint AS RatecodeID,
		PULocationID::bigint AS PULocationID,
		DOLocationID::bigint AS DOLocationID,
		passenger_count::bigint AS passenger_count,
		trip_distance::double AS trip_distance,
		fare_amount::double AS fare_amount,
		extra::double AS extra,
		mta_tax::double AS mta_tax,
		tip_amount::double AS tip_amount,
		tolls_amount::double AS tolls_amount,
		improvement_surcharge::double AS improvement_surcharge,
		total_amount::double AS total_amount,
		payment_type::int AS payment_type,
		trip_type::int AS trip_type,
		congestion_surcharge::double AS congestion_surcharge,
		filename

	from source
)

select * from renamed
