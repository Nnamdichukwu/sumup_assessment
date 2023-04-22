with 
    transactions as (select * from {{ ref('fct_transactions') }}),
  
    store_transaction as (
            select 
                store_id,
                transaction_id,
                status as transaction_status,
                happened_at,
                min(happened_at) over(partition  by store_id) as first_transaction
             
            from 
                transactions
            
            group  by store_id, transaction_id, status,  transactions.happened_at 
     )
        select 
            *, 
            date_diff(happened_at, first_transaction, day) as time_from_first_transaction
        from 
            store_transaction
       