{% macro grant_schemas(role) %}
{% set sql %}
    select 'grant usage on schema {{ target.schema }} to application role {{ role }}';
{% endset %}

{% do run_query(sql) %}
{% do log("Privileges granted", info=True) %}
{% endmacro %}
