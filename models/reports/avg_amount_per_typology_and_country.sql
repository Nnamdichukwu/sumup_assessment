with 
    country__and_typology_sales as (select * from {{ ref('sales_per_country_and_typology') }}),
    avg_amount AS (
        select
            country,
            typology,
            avg_transaction_amount
        from 
            country__and_typology_sales 
        where 
            country is not null and typology is not null   
 
    )
    select  * from avg_amount