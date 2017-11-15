===
OpenDKIM
===

Formulas to set up and configure the OpenDKIM service.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``opendkim``
-------

Installs the OpenDKIM package.

``opendkim.config``
-------

Configures the OpenDKIM package.

``opendkim.genkey_default``
-------

Will generate a default key if the default key file does not yet exist.

``opendkim.keys``
-------

Will create private key files based on private key content stored in pillar.

``opendkim.service``
-------

Will configure sysconfig file for service and ensure service is enabled and running.

Includes:
  - opendkim
  - opendkim.config
  - opendkim.keys

Includes are to enable require/watch options for config/etc files. Use the 'manage' options under 'config', and don't define keys, to disable this if you only want the service to be managed.

===
TODO
===

1. Configure firewalld to permit port if OpenDKIM should be accessible.
