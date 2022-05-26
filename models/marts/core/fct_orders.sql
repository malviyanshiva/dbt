with payments as(
    select * from {{ref('stg_payments')}}
),

orders as(
    select * from {{ref('stg_orders')}}
),

order_payments as (
    select order_id,
    sum(case when status='success' then Amount end) as Amount
    from payments
    group by 1
),

final as (
    select orders.order_id,
    orders.customer_id,
    orders.ORDER_DATE,
    coalesce(order_payments.Amount,0) as Amount
    from orders
    left join order_payments using(order_id)
)
select * from final