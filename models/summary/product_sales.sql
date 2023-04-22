with 
    transactions as (select * from {{ ref('fct_transactions') }} where status = 'accepted'),
    products_sold as (
        select 
            product_name,
            count(*) as number_of_products_sold,
            sum(amount) as transaction_amount
        from 
            transactions 
        group by 
            product_name
    ) 
    select * from products_sold