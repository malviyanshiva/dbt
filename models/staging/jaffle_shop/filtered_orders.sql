with orders as (
    select * from {{ref('stg_orders')}}
    {{filter_according_order_status('status','placed')}}
)
select * from orders