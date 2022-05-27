select
    {{dbt_utils.surrogate_key(['order_id','order_date'])}} as id,
    order_id,
    order_date,
    count(*)
    from {{ref('stg_orders')}}
    group by 2,3