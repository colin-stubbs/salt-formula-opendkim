{# opendkim #}

{## import settings from map.jinja ##}
{% from "opendkim/map.jinja" import opendkim_settings with context %}

{% if 'lookup' in opendkim_settings and 'pkgs' in opendkim_settings.lookup %}
opendkim:
  pkg.installed:
    - pkgs: {{ opendkim_settings.lookup.pkgs | tojson }}
{% endif %}

{# EOF #}
