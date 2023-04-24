{{
  config(
  materialized = 'incremental',
  incremental_strategy= 'merge',
  unique_key = 'transaction_id',
  on_schema_change = 'sync_all_columns'

  )
}} 

with 
  transactions as (select * from {{ ref('stg_transactions') }}),

  
  
  all_transactions as ( 
    select 
        {{dbt_utils.generate_surrogate_key(['transaction_id'])}} as transaction_sk,
        transactions.transaction_id,
        device_id,
        {{dbt_utils.generate_surrogate_key(['device_id'])}} as device_sk,
        transactions.product_name,
        transactions.product_sku,
        transactions.product_category,
        transactions.amount,
        transactions.status,
        transactions.card_number,
        transactions.cvv, 
        transactions.happened_at,

    from 
      transactions
   
    {% if is_incremental() %}
    where 
        transactions.happened_at >= (select max(transactions.happened_at ) from {{ this }})
  
    {% endif %}  
    
  )
  select  
      *
  from 
      all_transactions