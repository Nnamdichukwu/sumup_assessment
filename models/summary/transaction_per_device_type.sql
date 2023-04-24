with 
    transactions as (select * from {{ ref('int_transactions') }} where status = 'accepted'),
   
    device_transactions as (
        select 
            device_type,
            sum(amount) as transaction_amount,
            count(*) as  transaction_count
        from 
            transactions 
        
        group  by rollup(device_type)
        
    )
    select 
        case when device_type is null then 'Total' else device_type end  as device_types,
        transaction_amount,
        transaction_count
     from device_transactions
