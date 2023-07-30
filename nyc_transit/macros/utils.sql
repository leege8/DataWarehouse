{% macro flag_to_bool(column_name, true_value="Y", false_value="N", null_value=" ") -%}
(case
    when {{column_name}} = '{{true_value}}' then true
    when {{column_name}} = '{{false_value}}' then false
    when {{column_name}} = '{{null_value}}' then null
    when {{column_name}} is null then null
    else {{column_name}}
end)::bool
{%- endmacro %}


{% macro null_to_NA(column_name) -%}
(case
    when {{column_name}} is null then 'NA'
    else {{column_name}}
end)
{%- endmacro %}


{% test expect_column_values_to_be_between(model, column_name,
                                                   min_value=None,
                                                   max_value=None,
                                                   row_condition=None,
                                                   strictly=False
                                                   ) %}

{% set expression %}
{{ column_name }}
{% endset %}

{{ dbt_expectations.expression_between(model,
                                        expression=expression,
                                        min_value=min_value,
                                        max_value=max_value,
                                        group_by_columns=None,
                                        row_condition=row_condition,
                                        strictly=strictly
                                        ) }}


{% endtest %}
