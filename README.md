ansible-icon-prep
=========

Role to install prerequisites for running a P-Rep node on the ICON Blockchain.

Requirements
------------

-  Ansilble v2.8+

Role Variables
--------------

Defaults:
```yml
network_name: "mainnet"
reverse_proxy_type: nginx
nginx_type: block42
sync_db: true
data_dir: "{% if network_name == 'mainnet' %}icon{% else %}PREP-TestNet{% endif %}"

node_exporter_enabled: true
nginx_exporter_enabled: true
blackbox_exporter_enabled: true
cadvisor_enabled: true

node_exporter_port: 9100
nginx_exporter_port: 9113
blackbox_exporter_port: 9115
cadvisor_port: 8080
```

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
