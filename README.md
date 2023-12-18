## Project name

Ansible playbooks written for my own purposes & training.

## Table of contents
- [Project name](#project-name)
- [Table of contents](#table-of-contents)
- [General info](#general-info)
- [install-docker](#install-docker)
- [create-nfs-share](#create-nfs-share)
- [mount-nfs-share](#mount-nfs-share)
- [install-openvpn-server](#install-openvpn-server)
- [provision-node-exporter](#provision-node-exporter)
- [role: vm\_configuration](#role-vm_configuration)
- [role: bash\_customization](#role-bash_customization)
## General info

Repo contains ansible playbooks and roles used for automate tasks on virtual machines.

## install-docker

Playbook is installing docker & docker compose with additional customizations:
- adding docker repo,
- installation of docker,
- adding user to docker group,
- installation of docker-compose,
- configuration & start of service

## create-nfs-share
Playbook creates a nfs-share:
- basing on external role,
  - install role:
    ```
    ansible-galaxy collection install ansible.posix
    ```
- create vg and lv from already attached pv,
- mount new volume an add entry to /etc/fstab,
- create exports

## mount-nfs-share
Playbook mounts existing nfs-share:
- basing on external role,
  - install role:
    ```
    ansible-galaxy collection install ansible.posix
    ```
- mount nfs an add entry to /etc/fstab

## install-openvpn-server
Playbok sets-up Openvpn server:
- install service via shell script,
- create initial user and download certificate
 
## provision-node-exporter
Playbook creates a service node-exporter to provide metrics:
- basing on external role,
  - install role:
    ```
    ansible-galaxy collection install prometheus.prometheus
    ```
- customizations added (TLS)

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
