with 
    products as (select * from {{ ref('product_sales') }}),
    top_product_sales as (
        select 
          product_name,
          transaction_amount

        from 
            products
        order by transaction_amount desc 
        limit 10
    )
    select * from top_product_sales