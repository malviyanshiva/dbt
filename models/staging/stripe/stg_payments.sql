with payments as(
    select
    id as payment_id,
    orderid as order_id,
    {{cents_to_dollor('Amount')}} as Amount,
    status,
    paymentmethod as payment_method
    from {{ source('payment', 'payment') }}
)
select * from payments