with source as (
      select * from {{ source('sumup', 'store') }}
),
renamed as (
    select
        id as store_id,
        name as store_name,
        address,
        city,
        country,
        created_at,
        typology,
        customer_id

    from source
)
select * from renamed
  