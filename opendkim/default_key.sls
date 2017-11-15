{# opendkim.default_key #}

{# Generate default.key if it does not already exist #}

opendkim-genkey-default:
  cmd.run:
    - name: opendkim-genkey --domain={{ domain }} :wq!


{# EOF #}
