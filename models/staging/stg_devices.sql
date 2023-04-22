with source as (
      select * from {{ source('sumup', 'device') }}
),
renamed as (
    select
        id as device_id,
        type as device_type,
        store_id

    from source
)
select * from renamed
  