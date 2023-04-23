with 
    store_sales as (select * from {{ ref('stores_per_transaction_amount') }}),
    top_store_sales as (
        select 
          store_id,
          transaction_amount

        from 
            store_sales
        order by transaction_amount desc 
        limit 10
    )
    select * from top_store_sales