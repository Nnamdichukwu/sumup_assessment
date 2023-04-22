with 
    transactions as (select * from {{ ref('fct_transactions') }} where status = 'accepted'),
    devices as (select * from {{ ref('dim_stores_devices') }}),
    device_transactions as (
        select 
            devices.device_type,
            sum(amount) as transaction_amount,
            count(*) as  transaction_count
        from 
            transactions 
        inner join 
            devices on transactions.device_id = devices.device_id
        group  by 1
        
    )
    select * from device_transactions
