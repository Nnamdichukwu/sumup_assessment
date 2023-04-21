with source as (
      select * from {{ source('sumup', 'transaction') }}
),
renamed as (
    select
        id,
        device_id,
        product_name,
        product_sku,
        product_name_4,
        amount,
        status,
        card_number,
        cvv,
        created_at,
        happened_at

    from source
)
select * from renamed
  