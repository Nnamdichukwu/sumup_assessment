with 
    transactions as (select * from {{ ref('fct_transactions') }}),
    stores as (select * from {{ ref('dim_stores') }}),
    devices as (select * from {{ ref('dim_devices') }}),

    create_star_schema as ( 
        select 
            {{dbt_utils.star(from= ref('fct_transactions'), relation_alias= 'transactions', except=['device_id', 'device_sk'] )}},
            {{dbt_utils.star(from= ref('dim_stores'), relation_alias= 'stores' )}},        
            {{dbt_utils.star(from= ref('dim_devices'), relation_alias= 'devices', except=['store_id', 'store_sk'] )}},
        from 
            transactions 
        left  join  
            devices on transactions.device_sk = devices.device_sk
        inner join 
            stores on stores.store_sk = devices.store_sk
    ),
    get_first_store_txn as(
        select 
            *,
            min(happened_at) over(partition  by store_id) as first_transaction 
        from 
            create_star_schema
        {{dbt_utils.group_by(n=22)}}
    )
        select 
            *,
            date_diff(happened_at, first_transaction, day) as time_from_first_transaction 
        from 
            get_first_store_txn
