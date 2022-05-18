with payments as(
    select * from raw.stripe.payment
)
select * from payments