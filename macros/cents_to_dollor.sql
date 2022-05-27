{% macro cents_to_dollor(column_name,round_to=2) -%}
round(1.0*{{column_name}}/100,{{round_to}})
{%-endmacro%}