with 
    typology_sales as (select * from {{ ref('sales_per_country_and_typology') }}),
    avg_amount AS (
        select
            typology,
            avg_transaction_amount
        from 
            typology_sales 
        where 
            typology is not null and country is null   
       
    )
    select  * from avg_amount