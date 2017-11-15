opendkim:
  lookup:
    pkgs:
      - opendkim
  service:
    manage: True
    name: opendkim
  firewall:
    manage_permit: True
    type: firewalld
    zone: public
    port: 8891
  config:
    manage: True
    options:
      Domain: 'example.com'
      ExternalIgnoreList: 'refile:/etc/opendkim/ExternalIgnoreList'
      InternalHosts: 'refile:/etc/opendkim/InternalHosts'
      KeyTable: 'refile:/etc/opendkim/KeyTable'
      SigningTable: 'refile:/etc/opendkim/SigningTable'
      SignatureAlgorithm: 'rsa-sha256'
      UserID: 'opendkim:opendkim'
      PidFile: '/var/run/opendkim/opendkim.pid'
      Mode: 'sv'
      AutoRestart: 'Yes'
      AutoRestartRate: '10/1h'
      UMask: '002'
      Syslog: 'Yes'
      SyslogSuccess: 'Yes'
      LogWhy: 'Yes'
    default_key:
      generate: True
      options: '--restrict --subdomains --testmode'
      selector: 'non_default'
    KeyTable:
      example_key:
        domain: 'example.com'
        record: 'mail'
        key_file: 'example.private'
    SigningTable:
      '*@example.com': 'example_key'
      '*@*example.com': 'example_key'
    ExternalIgnoreList:
      - 127.0.0.1
      - ::1
      - 10.0.0.0/8
      - '*.internal.example.com'
    InternalHosts:
      - 127.0.0.1
      - ::1
      - 10.0.0.0/8
      - '*.internal.example.com'
  keys:
    default: |
      -----BEGIN RSA PRIVATE KEY-----
      MIICX%{BLAHKEYBLAH}%asdf
      -----END RSA PRIVATE KEY-----
    example: |
      -----BEGIN RSA PRIVATE KEY-----
      MIICX%{BLAHKEYBLAH}%asdf
      -----END RSA PRIVATE KEY-----
  sysconfig:
    manage: True
    variables:
      OPTIONS: "'-x /etc/opendkim.conf -P /var/run/opendkim/opendkim.pid'"
      DKIM_SELECTOR: 'default'
      DKIM_KEYDIR: '/etc/opendkim/keys'
