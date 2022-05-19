with customers as(
    select * from {{ref('stg_customers')}}
),

orders as (
    select * from {{ref('stg_orders')}}
),

payments as (
    select * from {{(ref('fct_orders'))}}
),

customer_orders_date_and_count as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

customers_orders as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders_date_and_count.first_order_date,
        customer_orders_date_and_count.most_recent_order_date,
        coalesce(customer_orders_date_and_count.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders_date_and_count using (customer_id)

),

final as(
    select 
        customers_orders.customer_id,
        customers_orders.first_name,
        customers_orders.last_name,
        customers_orders.first_order_date,
        customers_orders.most_recent_order_date,
        customers_orders.number_of_orders,
        cast(payments.Amount as varchar) as lifetime_value
        from customers_orders
        left join payments using(customer_id)
)
select * from final