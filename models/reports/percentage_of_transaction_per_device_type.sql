with 
    transactions_per_device as (select  * from {{ ref('transaction_per_device_type') }}),
    percentage_per_type as (
        select 
            device_types,
            round(transaction_amount/(select transaction_amount from transactions_per_device where device_types = 'Total'),2) as percentage_transaction_amount,
            round(transaction_count/(select transaction_count from transactions_per_device where device_types = 'Total'),2) as percentage_transaction_count,
        from 
            transactions_per_device
        where device_types != 'Total'
    )
    select  * from percentage_per_type