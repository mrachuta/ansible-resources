## Project name

Ansible playbooks and roles used to configure and operate a small homelab.

## Table of contents

- [Project name](#project-name)
- [General info](#general-info)
- [Prerequisites and usage](#prerequisites-and-usage)
- [Playbooks](#playbooks)
  - [configure-vm](#configure-vm)
  - [customize-bash](#customize-bash)
  - [configure-proxmox-cluster](#configure-proxmox-cluster)
  - [provision-node-exporter](#provision-node-exporter)
  - [provision-wireguard](#provision-wireguard)
  - [manage-spaceship-dns](#manage-spaceship-dns)
  - [provision-hashicorp-vault](#provision-hashicorp-vault)
  - [change-root-password](#change-root-password)
- [Roles](#roles)
  - [vm_configuration](#vm_configuration)
  - [bash_customization](#bash_customization)
  - [vm_vault_authentication](#vm_vault_authentication)

## General info

The repository contains playbooks for virtual machines, Proxmox VE nodes,
monitoring, networking, DNS, and Vault. Local inventory, host variables, and
runtime configuration are intentionally excluded from version control.

## Prerequisites and usage

- Use a supported Python environment and install the controller dependencies:

  ```bash
  python -m pip install -r requirements.txt
  ansible-galaxy collection install -r requirements.yml
  ```

- Create a local inventory and the required host or group variables before
  running a playbook. The controller account must be able to connect to the
  selected hosts and use privilege escalation where required.
- Use the static inventory for manually managed hosts. Add the Proxmox dynamic
  inventory only when it has been configured locally.
- Select hosts explicitly and preview non-destructive changes first:

  ```bash
  ansible-playbook -i inventory/default.yml -e "target_hosts=<host-or-group>" <playbook>.yml --check --diff
  ```

- Some playbooks can obtain connection or service credentials from a configured
  secret-management service. Keep its local authentication material outside the
  repository. The same playbooks can use ordinary inventory-based connections
  when that integration is disabled.
- Read the variables in the relevant role defaults and local host/group
  variables before applying changes to production hosts.

## Playbooks

### configure-vm

- Applies the `vm_configuration` role to new or existing Linux virtual
  machines.
- Installs baseline packages and configures local accounts, privileges, and
  authorized SSH keys.
- Applies operating-system security settings, SSH daemon hardening, and
  distribution-specific configuration.
- Supports an initial bootstrap connection as well as subsequent management
  runs with the regular automation account.
- Requires suitable connection variables and elevated privileges; review the
  role variables before the first run on a host.

### customize-bash

- Applies the `bash_customization` role to a selected user account.
- Installs and configures shell-oriented tools, including Bash, Vim, and tmux
  customizations.
- Deploys aliases, prompt configuration, editor settings, and terminal
  multiplexer configuration.
- Keeps the generated hostname prompt colour stable across repeated runs.
- Requires the target user to exist and the remote connection to have
  privilege-escalation rights.

### configure-proxmox-cluster

- Configures common operating-system settings on Proxmox VE nodes.
- Manages the configured package repositories and applies locale and timezone
  settings.
- Installs the configured administrator public SSH key on the nodes.
- Can use the shared authentication role when secure controller-side
  authentication is enabled.
- Run it only against the intended Proxmox node group and review repository
  choices for the installed Proxmox version.

### provision-node-exporter

- Installs and configures Prometheus Node Exporter on selected hosts.
- Creates the dedicated service account and required textfile-collector
  directories.
- Optionally deploys transport-security files for non-Kubernetes hosts.
- Publishes an additional metric describing pending operating-system updates.
- Requires the `prometheus.prometheus` collection and network access from the
  monitoring system to the configured exporter endpoint.

### provision-wireguard

- Installs WireGuard and its required operating-system packages.
- Deploys the interface configuration and a local administration helper.
- Enables IP forwarding and ensures the WireGuard service starts at boot.
- Restarts the interface only when its rendered configuration changes.
- Requires a complete, locally configured WireGuard settings source before an
  apply; verify routing and firewall requirements for every target host.

### manage-spaceship-dns

- Builds the desired DNS A-record set from inventory and host variables.
- Reconciles those records with the configured DNS provider API.
- Runs API operations from the Ansible controller rather than target hosts.
- Prints the calculated record set before submitting changes.
- Use a narrowly scoped target group and review the planned records, because an
  apply updates live DNS.

### provision-hashicorp-vault

- Installs HashiCorp Vault and configures it as a managed system service.
- Deploys the local TLS material and persistent storage configuration.
- Initializes and unseals a new instance only when required by its current
  state.
- Optionally installs and schedules a backup integration after its external
  dependencies have been prepared.
- Run only against a dedicated Vault host, keep recovery material offline, and
  validate backup and recovery procedures separately.

### change-root-password

- Generates a new random password for the target system's root account.
- Applies the password using the operating system's password-hashing support.
- Records the generated value in protected local controller storage.
- Does not depend on the shared Vault authentication flow.
- Run against a single, explicitly selected host and ensure an independent
  recovery access path exists before rotating an administrative credential.

## Roles

### vm_configuration

- Provides the baseline Linux VM configuration used by `configure-vm.yml`.
- Creates optional technical and regular user accounts with configurable
  privileges and SSH keys.
- Configures baseline packages, firewall behaviour, SELinux behaviour, and SSH
  daemon hardening.
- Supports bootstrap credentials for an initial VM setup and a regular
  inventory-based connection for later runs.
- Requires elevated privileges and the collections listed in `requirements.yml`.

### bash_customization

- Configures the interactive environment of an existing user account.
- Manages Bash aliases, prompt settings, Vim plugins and configuration, and
  tmux configuration.
- Uses idempotent downloads and Git checkouts so unchanged configuration is not
  rewritten on subsequent runs.
- Allows user-specific values such as the target user, group, aliases, and
  prompt colour to be overridden.
- Requires an existing target user and privilege escalation on the managed host.

### vm_vault_authentication

- Provides an opt-in, reusable connection-preparation role for other
  playbooks.
- Retrieves the configured automation connection data from the controller-side
  secret-management integration.
- Sets the Ansible connection variables in memory before target-host tasks run.
- Is skipped unless its caller explicitly enables it and supplies a credential
  source.
- Requires the HashiCorp Vault collection and locally configured authentication
  only when the role is enabled.
