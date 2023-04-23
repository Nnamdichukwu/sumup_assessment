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
  stores as (select * from  {{ ref('stg_stores') }}),
  devices as (select * from  {{ ref('stg_devices') }}),  
  
  all_transactions as ( 
    select 
        transactions.transaction_id,
        stores.store_id,
        devices.device_id,
        transactions.product_name,
        transactions.product_sku,
        transactions.product_category,
        transactions.amount,
        transactions.status,
        transactions.card_number,
        transactions.cvv, 
        transactions.happened_at,
        min(happened_at) over(partition  by stores.store_id) as first_transaction
    from 
      transactions
    inner join 
       devices on transactions.device_id = devices.device_id
    inner  join 
        stores on stores.store_id = devices.store_id  
    {% if is_incremental() %}
    where 
        transactions.happened_at >= (select max(transactions.happened_at ) from {{ this }})
  
    {% endif %}  
    group  by transactions.transaction_id,
              stores.store_id,
              devices.device_id,
              transactions.product_name,
              transactions.product_sku,
              transactions.product_category,
              transactions.amount,
              transactions.status,
              transactions.card_number,
              transactions.cvv, 
              transactions.happened_at
  )
  select  
      *,
       date_diff(happened_at, first_transaction, day) as time_from_first_transaction 
  from 
      all_transactions