with source as (
      select * from {{ source('sumup', 'transaction') }}
),
renamed as (
    select
        cast(id as string) as transaction_id,
        cast(device_id as string) as device_id,
        product_name,
        product_sku,
        product_name_4 as product_category,
        amount,
        status,
        card_number,
        cvv,
        created_at,
        happened_at

    from source
)
select * from renamed
  