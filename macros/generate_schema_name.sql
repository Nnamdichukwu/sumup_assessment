
{% macro generate_schema_name(custom_schema_name, node) %}
  {% set default_schema = target.schema %}
  {% if custom_schema_name is not none and target.name == 'default'%}
        sumup_{{custom_schema_name | trim }}
  {% if   custom_schema_name is not none and target.name == 'cicd' %}
         {{custom_schema_name}}   
    {% endif %}

  {% else %} 
          {{default_schema}}  

  {% endif %}  
{% endmacro %}