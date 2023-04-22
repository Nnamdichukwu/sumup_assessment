with 
    transactions as (select * from {{ ref('fct_transactions') }} where status = 'accepted'),
    stores as (select * from {{ ref('dim_stores_devices') }}),
    store_sales as (
        select 
            stores.country,
            stores.typology, 
            count(*) as number_of_sales,
            sum(transactions.amount) as transaction_amount
        from  
            transactions
        inner join stores on transactions.store_id = stores.store_id
        group by rollup (stores.country, stores.typology)    
    )
    select * from store_sales