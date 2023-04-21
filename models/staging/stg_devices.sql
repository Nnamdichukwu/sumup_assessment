with source as (
      select * from {{ source('sumup', 'device') }}
),
renamed as (
    select
        id,
        type,
        store_id

    from source
)
select * from renamed
  