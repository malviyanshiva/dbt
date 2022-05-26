{% set payments_methods = ['credit_card','coupon','bank_transfer','git_cards'] %}

with payment as(
    select * from {{ref('stg_payments')}}
),

pivoted as (
    select
        order_id,
        {% for method in payments_methods %}
        sum(case when payment_method='{{method}}' then amount else 0 end) as {{method}}_amount
        {% if not loop.last %}
        ,
        {%endif%}
        {%endfor%}
        from payment
        where status='success'
        group by 1
)
select * from pivoted