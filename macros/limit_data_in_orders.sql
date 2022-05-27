{%- macro limit_data_in_orders(column_name,days_count=3 )-%}
    where {{column_name}}>=dateadd('day',-{{days_count}},current_timestamp)
{%-endmacro-%}