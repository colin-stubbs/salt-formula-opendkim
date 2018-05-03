{# opendkim.service #}

{## import settings from map.jinja ##}
{% from "opendkim/map.jinja" import opendkim_settings with context %}

include:
  - opendkim
  - opendkim.config
  - opendkim.keys

{% if opendkim_settings.service.manage == True %}
{% if opendkim_settings.sysconfig.manage == True and 'variables' in opendkim_settings.sysconfig %}
{{ opendkim_settings.lookup.locations.sysconfig_file }}:
  file.managed:
    - source: salt://opendkim/files/opendkim
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - require:
      - pkg: opendkim
{% endif %}

service-opendkim:
  service.running:
    - name: {{ opendkim_settings.service.name }}
    - enable: True
    - require:
      - pkg: opendkim
{% if opendkim_settings.sysconfig.manage == True %}
      - file: {{ opendkim_settings.lookup.locations.sysconfig_file }}
{% endif %}
{% if opendkim_settings.config.manage == True %}
      - file: {{ opendkim_settings.lookup.locations.KeyTable }}
      - file: {{ opendkim_settings.lookup.locations.SigningTable }}
      - file: {{ opendkim_settings.lookup.locations.ExternalIgnoreList }}
      - file: {{ opendkim_settings.lookup.locations.InternalHosts }}
      - file: {{ opendkim_settings.lookup.locations.config_file }}
{% endif %}
    - watch:
      - pkg: opendkim
{% if opendkim_settings.sysconfig.manage == True %}
      - file: {{ opendkim_settings.lookup.locations.sysconfig_file }}
{% endif %}
{% if opendkim_settings.config.manage == True %}
      - file: {{ opendkim_settings.lookup.locations.KeyTable }}
      - file: {{ opendkim_settings.lookup.locations.SigningTable }}
      - file: {{ opendkim_settings.lookup.locations.ExternalIgnoreList }}
      - file: {{ opendkim_settings.lookup.locations.InternalHosts }}
      - file: {{ opendkim_settings.lookup.locations.config_file }}
{% endif %}
{% endif %}
