with payments as(
    select
    id as customer_id,
    orderid as order_id,
    Amount as Amount,status
    from raw.stripe.payment
)
select * from payments