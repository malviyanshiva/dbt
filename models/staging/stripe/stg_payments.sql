with payments as(
    select
    id as USER_ID,
    orderid as Order_ID,
    Amount as Amount,status
    from raw.stripe.payment
)
select * from payments