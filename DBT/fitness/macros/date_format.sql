{% macro format_date(date_column, format_string) %}
    TO_CHAR({{ date_column }}, '{{ format_string }}')
{% endmacro %}


