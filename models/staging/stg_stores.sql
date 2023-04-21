with source as (
      select * from {{ source('sumup', 'store') }}
),
renamed as (
    select
        id,
        name,
        address,
        city,
        country,
        created_at,
        typology,
        customer_id

    from source
)
select * from renamed
  