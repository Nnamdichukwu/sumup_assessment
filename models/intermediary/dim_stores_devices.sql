{{
  config(
  materialized = 'table',  

  labels= {'contains_pii': 'store_name'} 

  )
}}

with 
 stores AS (select * from {{ ref('stg_stores') }}),
 devices AS (select * from {{ ref('stg_devices') }}),

 stores_and_devices AS (
    select  
       {{ dbt_utils.generate_surrogate_key(['stores.store_id', 'devices.device_id']) }} as stores_and_devices_sk,
        stores.store_id,
        stores.store_name,
        devices.device_id,
        devices.device_type,
        stores.address,
        stores.city,
        stores.country,
        stores.typology,
        stores.customer_id,
        stores.created_at,
    from 
        stores 
    inner join 
        devices on stores.store_id = devices.store_id

    
 )
 select  * from  stores_and_devices 
