with 
    country_sales as (select * from {{ ref('sales_per_country_and_typology') }}),
    avg_amount AS (
        select
            country,
            avg_transaction_amount
        from 
            country_sales 
        where 
            country is not null and typology is null   
      
    )
    select  * from avg_amount