
with 
    devices as (select * from  {{ ref('stg_devices') }}),
    dim_devices as(
        select 
            {{dbt_utils.generate_surrogate_key(['device_id'])}} as device_sk,
            device_id,
            device_type,
            store_id,
            {{dbt_utils.generate_surrogate_key(['store_id'])}} as store_sk
        from 
            devices 
    )
    select * from  dim_devices