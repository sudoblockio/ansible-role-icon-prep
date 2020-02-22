ansible-icon-prep
=========

Role to install prerequisites for running a P-Rep node on the ICON Blockchain.

Requirements
------------

-  Ansilble v2.8+

Role Variables
--------------

Defaults:
```
network_name: "mainnet"
app_type: block42
sync_db: true
```

Dependencies
------------

-  cloudalchemy.ansible-node-exporter

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

```
- hosts: servers
  roles:
     - ansible-icon-prep
  vars:
    network_name: "testnet"
    keystore_path: "{{ playbook_dir }}/../fixtures/keystore"
    keystore_password: "testing1."
```

License
-------

BSD

Author Information
------------------

An optional section for the role authors to include contact information, or a
website (HTML is not allowed).
