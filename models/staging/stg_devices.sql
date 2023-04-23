with source as (
      select * from {{ source('sumup', 'device') }}
),
renamed as (
    select
        cast(id as string) as device_id,
        cast(type as string) as device_type,
        cast(store_id as string) as store_id

    from source
)
select * from renamed
  