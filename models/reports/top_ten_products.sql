with 
    products as (select * from {{ ref('product_sales') }}),
    top_product_sales as (
        select 
          product_name,
         number_of_products_sold

        from 
            products
        order by number_of_products_sold desc 
        limit 10
    )
    select * from top_product_sales