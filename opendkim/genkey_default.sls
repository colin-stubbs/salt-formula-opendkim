{# opendkim.default_key #}

{## import settings from map.jinja ##}
{% from "opendkim/map.jinja" import opendkim_settings with context %}

{# Generate default.key provided it does not already exist #}

{% if opendkim_settings.config.default_key.generate == False %}
opendkim-genkey-default:
  cmd.run:
    - name: opendkim-genkey --directory={{ opendkim_settings.lookup.locations.keys_dir }} --domain={{ opendkim_settings.config.options.Domain }} --selector={{ opendkim_settings.config.default_key.selector }} {{ opendkim_settings.config.default_key.options }}
    - creates: {{ opendkim_settings.lookup.locations.keys_dir }}/{{ opendkim_settings.config.default_key.selector }}.private
{% endif %}

{# EOF #}

