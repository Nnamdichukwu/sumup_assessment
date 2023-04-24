with 
    transactions as (select * from {{ ref('int_transactions') }} where status = 'accepted'),
    transaction_per_store as (
        select 
            store_id,
            sum(amount) as transaction_amount
        from 
            transactions
        
        group by 
            store_id
        
)
select *  from transaction_per_store   