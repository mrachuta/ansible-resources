## Project name

Ansible playbooks written for my own purposes & training.

## Table of contents
- [Project name](#project-name)
- [Table of contents](#table-of-contents)
- [General info](#general-info)
- [provision-node-exporter](#provision-node-exporter)
- [role: vm\_configuration](#role-vm_configuration)
- [role: bash\_customization](#role-bash_customization)
## General info

Repo contains ansible playbooks and roles used for automate tasks on virtual machines.
 
## provision-node-exporter
Playbook creates a service node-exporter to provide metrics:
- basing on external role,
  - install role:
    ```
    ansible-galaxy collection install prometheus.prometheus
    ```
- customizations added (TLS)
- ability to provision script that generates metrics related to pending host os updates

## role: vm_configuration
Role performs basic configuration on VM:
- install required software,
- create technical user,
- create default user,
- make hardening on SSH service,
- configure SELinux and firewall

## role: bash_customization
Role performs basic configuration on VM:
- installation of required software,
- configure *.bash_aliases*,
- configure *.bashrc*,
- configure *vim*,
- configure *tmux*
