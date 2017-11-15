{# opendkim.config #}

include:
  - opendkim

{## import settings from map.jinja ##}
{% from "opendkim/map.jinja" import opendkim_settings with context %}

{% if opendkim_settings.config.manage == True %}
{{ opendkim_settings.lookup.locations.base_config_dir }}:
  file.directory:
    - user: root
    - group: {{ opendkim_settings.lookup.group }}
    - mode: 0755

{{ opendkim_settings.lookup.locations.KeyTable }}:
  file.managed:
    - source: salt://opendkim/files/KeyTable
    - template: jinja
    - context:
      KeyTable: {{ opendkim_settings.config.KeyTable|default({}) }}
      key_file_location: {{ opendkim_settings.lookup.locations.keys_dir }}
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - mode: 0640
    - require:
      - file: {{ opendkim_settings.lookup.locations.base_config_dir }}

{{ opendkim_settings.lookup.locations.SigningTable }}:
  file.managed:
    - source: salt://opendkim/files/SigningTable
    - template: jinja
    - context:
      SigningTable: {{ opendkim_settings.config.SigningTable|default({}) }}
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - mode: 0640
    - require:
      - file: {{ opendkim_settings.lookup.locations.base_config_dir }}

{{ opendkim_settings.lookup.locations.ExternalIgnoreList }}:
  file.managed:
    - source: salt://opendkim/files/ExternalIgnoreList
    - template: jinja
    - context:
      ExternalIgnoreList: {{ opendkim_settings.config.ExternalIgnoreList|default([]) }}
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - mode: 0640
    - require:
      - file: {{ opendkim_settings.lookup.locations.base_config_dir }}

{{ opendkim_settings.lookup.locations.InternalHosts }}:
  file.managed:
    - source: salt://opendkim/files/InternalHosts
    - template: jinja
    - context:
      InternalHosts: {{ opendkim_settings.config.InternalHosts|default([]) }}
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - mode: 0640
    - require:
      - file: {{ opendkim_settings.lookup.locations.base_config_dir }}

{{ opendkim_settings.lookup.locations.config_file }}:
  file.managed:
    - source: salt://opendkim/files/opendkim.conf
    - template: jinja
    - context:
      config_options: {{ opendkim_settings.config.options }}
    - user: {{ opendkim_settings.lookup.user }}
    - group: {{ opendkim_settings.lookup.group }}
    - mode: 0644
    - require:
      - file: {{ opendkim_settings.lookup.locations.base_config_dir }}
{% endif %}

{# EOF #}

