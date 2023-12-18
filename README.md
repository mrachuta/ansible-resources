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

Playbook used for installing docker & docker compose with additional customizations:
- adding docker repo,
- installation of docker,
- adding user to docker group,
- installation of docker-compose,
- configuration & start of service

## create-nfs-share
Playbook that creates a nfs-share,
- install necessary packages,
- create vg and lv from already attached pv,
- mount new volume an add entry to /etc/fstab,
- create exports

## mount-nfs-share
Playbook that mounts existing nfs-share,
- install necessary packages,
- mount nfs an add entry to /etc/fstab

## install-openvpn-server
Playbok that setup Openvpn server,
- install service via shell script,
- create initial user and download certificate
 
## provision-node-exporter
Playbook that creates a service node-exporter to provide metrics,
- basing on external role,
  - install role:
    ```
    ansible-galaxy collection install prometheus.prometheus
    ```
- customizations added (TLS)

## role: vm_configuration
Role that performing basic configuration on VM,
- installation of required software,
- create technical user,
- create default user,
- make hardening on SSH service,
- configure SELinux and firewall

## role: bash_customization
Role that performing basic configuration on VM,
- installation of required software,
- configure *.bash_aliases*,
- configure *.bashrc*,
- configure *vim*,
- configure *tmux*
