with payments as(
    select
    id as payment_id,
    orderid as order_id,
    Amount as Amount,status
    from {{ source('payment', 'payment') }}
)
select * from payments