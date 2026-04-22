## Project name

Ansible playbooks written for my own purposes & training.

## Table of contents
- [Project name](#project-name)
- [Table of contents](#table-of-contents)
- [General info](#general-info)
- [Playbooks](#playbooks)
  - [provision-node-exporter](#provision-node-exporter)
  - [change-root-password](#change-root-password)
  - [install-wireguard](#install-wireguard)
  - [manage-spaceship-dns](#manage-spaceship-dns)
- [Roles](#roles)
  - [vm\_configuration](#vm_configuration)
  - [role: bash\_customization](#role-bash_customization)
## General info

Repo contains Ansible playbooks and roles used to automate tasks.

## Playbooks

### provision-node-exporter
Playbook deploys `node-exporter` to expose metrics on target hosts. Features:
- based on external role,
  - install role:
    ```
    ansible-galaxy collection install prometheus.prometheus
    ```
- adding mTLS for data transit
- allowing to provision script that generates metrics related to pending host os updates

### change-root-password
Playbook changes the root password and saving it to file on Ansible controller. Features:
- generating random password
- saving it to Ansible controller
  
### install-wireguard
Playbook installs Wireguard. Features:
- installing Wireguard with custom configuration from template
- downloading `wireguard-install` script to make server administration easier

### manage-spaceship-dns
Playbok interacts with SpaceShip API and manage domains. Features:
- interacting with SpaceShip API to add/update domains

## Roles

### vm_configuration
Role performs basic configuration of VM. Features
- installing required software,
- creating technical user,
- creating default user,
- performing hardening over sshd service,
- configuring SELinux and firewall

### role: bash_customization
Role performs basic configuration of user environment:
- installing required software,
- configuring *.bash_aliases*,
- configuring *.bashrc*,
- configuring *vim*,
- configuring *tmux*
