{# opendkim.default_key #}

{## import settings from map.jinja ##}
{% from "opendkim/map.jinja" import opendkim_settings with context %}

include:
  - opendkim

{# Create private key files from pillar data #}

{{ opendkim_settings.lookup.locations.keys_dir }}:
  file.directory:
    - makedirs: True
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - file_mode: 0600
    - dir_mode: 750
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
    - require:
      - pkg: opendkim

{% for name, key_content in opendkim_settings.get('keys', {}).items() %}
{{ opendkim_settings.lookup.locations.keys_dir }}/{{ name }}.private:
  file.managed:
    - contents_pillar: opendkim:keys:{{ name }}
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - file_mode: 0600
    - require:
      - pkg: opendkim
{% endfor %}

{# EOF #}
