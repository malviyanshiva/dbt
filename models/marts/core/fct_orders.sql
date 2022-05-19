with payments as(
    select * from {{ref('stg_payments')}}
),

order_payments as (
    select customer_id,
    sum(case when status='success' then Amount end) as Amount
    from payments
    group by 1
)
select * from order_payments