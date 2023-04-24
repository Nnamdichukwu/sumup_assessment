with 
    get_country_typology_transactions as (select * from {{ ref('int_transactions') }} where status = 'accepted'),
    
    store_sales as (
        select 
            country,
            typology, 
            count(*) as number_of_sales,
            avg(amount) as avg_transaction_amount
        from  
            get_country_typology_transactions

        group by rollup (country, typology)  
    --bigquery doesnt have cube or grouping sets syntax  
        UNION ALL 
         select 
            null as country,
            typology, 
            count(*) as number_of_sales,
            avg(amount) as avg_transaction_amount
        from  
            get_country_typology_transactions
        
        group by typology  

    )
    select * from store_sales