with 
    time_per_transaction as (select * from {{ ref('int_transactions') }}),
    order_transactions as (
       select 
         store_id, 
         happened_at,
         first_transaction,
         time_from_first_transaction,
         row_number() over(partition by store_id order by happened_at asc ) as ordered_transactions
        from 
          time_per_transaction  
        group by store_id, happened_at, first_transaction, time_from_first_transaction
    ),
    avg_time_first_five_txn as (
        select 
            store_id,
            avg(time_from_first_transaction) as avg_time_in_days_to_complete_first_five
        from 
            order_transactions 
        where 
            ordered_transactions <= 5
        group by rollup (store_id)
    )
    select 
        case when store_id is null then 'Total' else store_id end as stores,
        avg_time_in_days_to_complete_first_five
    from 
        avg_time_first_five_txn
