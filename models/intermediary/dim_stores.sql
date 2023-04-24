{{
  config(
  materialized = 'table',  

  labels= {'contains_pii': 'store_name'} 

  )
}}

with 
 stores AS (select * from {{ ref('stg_stores') }}),


 stores_dim AS (
    select  
        {{dbt_utils.generate_surrogate_key(['store_id'])}} as store_sk,
        stores.store_id,
        stores.store_name,
        stores.address,
        stores.city,
        stores.country,
        stores.typology,
        stores.customer_id,
        stores.created_at,
    from 
        stores 
    

    
 )
 select  * from  stores_dim
