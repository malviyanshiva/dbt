{%- set orders_status=['returned','placed','completed','return_pending','shipped'] -%}

with orders as (
    select * from {{ref('stg_orders')}}
),

pivoted as(
    select customer_id,
    {%- for st in orders_status %}
    count(case when status='{{st}}' then status end) as {{st}}_count
    {%- if not loop.last -%}
    ,
    {%-endif-%}
    {%endfor%}
    from orders
    group by 1
    order by 1
)
select * from pivoted