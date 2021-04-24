## Project name

Ansible playbooks written for my own purposes & training.

## Table of contents
- [Project name](#project-name)
- [Table of contents](#table-of-contents)
- [General info](#general-info)
- [configure-vm](#configure-vm)
- [install-docker](#install-docker)
- [create-technical-user](#create-technical-user)
- [update-profile](#update-profile)
- [change-root-pass](#change-root-pass)
- [create-nfs-share](#create-nfs-share)
- [mount-nfs-share](#mount-nfs-share)
## General info

Repo contains ansible playbooks used for automate tasks on virtual machines. Often they are supported by shell scritps.

## configure-vm

Playbook used for initial configuration of vm. It realizes following tasks:
- new user creation,
- installing necessary software,
- hardening ssh service,
- personalisation of bash,
- personalisation of ufw (firewall)

## install-docker

Playbook used for installing docker & docker compose with additional customizations:
- adding docker repo,
- installation of docker,
- adding user to docker group,
- installation of docker-compose,
- configuration & start of service

## create-technical-user
Playbook used for add new, technical user on remote server:
- check if user already exists or not,
- create if not exist,
- allow paswordless sudo,
- add public SSH key to allow logging-in.

## update-profile
Playbok running script that will download latest version of profile configuration
- download script,
- run,
- do cleanup

## change-root-pass
Playbook can be used to change root password in all servers to the same
- just change password

## create-nfs-share
Playbook that creates a nfs-share
- install necessary packages
- create vg and lv from already attached pv
- mount new volume an add entry to /etc/fstab
- create exports

## mount-nfs-share
Playbook that mounts existing nfs-share
- install necessary packages
- mount nfs an add entry to /etc/fstab