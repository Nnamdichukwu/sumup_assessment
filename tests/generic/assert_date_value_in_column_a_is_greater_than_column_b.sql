{% test assert_date_value_in_column_a_is_greater_than_column_b(model, column_a, column_b, or_equal= True) %}
with validation AS(
    SELECT
      {{column_a}} as column_a,
      {{ column_b }} as column_b
    FROM {{ model}}
),
validation_errors AS (
    SELECT
   
    date_diff(cast(column_a as date), cast(column_b as date), day) as time_diff
    FROM validation
)
select * from validation_errors
 {% if or_equal == false %}
    where time_diff <= 0     

{% else %}  
   where time_diff < 0     
 {% endif %}
{% endtest %}