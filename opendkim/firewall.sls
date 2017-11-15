{# opendkim.firewall #}

include:
  - opendkim

{## import settings from map.jinja ##}
{% from "opendkim/map.jinja" import opendkim_settings with context %}

{% if opendkim_settings.firewall.manage_permit == True %}
{% if opendkim_settings.firewall.type == 'firewalld' %}

{# Define OpenDKIM service in firewalld #}

opendkim-firewalld-service:
  cmd.run:
    - name: 'firewall-cmd --permanent --zone={{ opendkim_settings.firewall.zone }} --add-port={{ opendkim_settings.firewall.port }}/tcp'
    - unless: 'firewall-cmd --permanent --zone={{ opendkim_settings.firewall.zone }} --query-port={{ opendkim_settings.firewall.port }}/tcp'

opendkim-firewalld-reload:
  cmd.run:
    - name: 'firewall-cmd --reload'
    - onchanges:
      - cmd: opendkim-firewalld-service

{% else %}

{# TODO - run iptables commands to add rule/s #}

{% endif %}
{% endif %}

{# EOF #}
