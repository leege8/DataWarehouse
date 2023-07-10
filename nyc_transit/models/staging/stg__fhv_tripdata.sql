with source as (
	
	select * from {{ source('main', 'fhv_tripdata') }}
),

renamed as (

	select 
		dispatching_base_num,
		pickup_datetime::timestamp AS pickup_datetime,
		dropOff_datetime::timestamp AS dropOff_datetime,
		PUlocationID::double as PUlocationID,
		DOlocationID::double as DOlocationID,
		Affiliated_base_number,
		filename
	
	from source
)

select * from renamed

