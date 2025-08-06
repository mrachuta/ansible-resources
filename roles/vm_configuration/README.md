# vm_configuration role

Role to install software, configure accounts and privileges and some security aspects.

## Requirements

If you want to allow remote access via SSH using keys, generate them before launching of the role.

## Role Variables

### User-provided variables:

`vm_configuration_remove_root_password`

Type: boolean

Description: Remove password from root account to prevent direct login


`vm_configuration_create_technical_user`

Type: boolean

Description: Switch to create or not technical user account


`vm_configuration_technical_user`

Type: string

Description: Name of technical user (to be used for example as ansible user in future)

`vm_configuration_technical_user_ssh_key_path`

Type: string

Description: Full path to public ssh key to be added to technical user account

`vm_configuration_create_default_user`

Type: boolean

Description: Switch to create or not defalt user account

`vm_configuration_default_user`

Type: string

Description: Name of your user to be used on server

`vm_configuration_default_user_ssh_key_path`

Type: string

Description: Full path to public ssh key to be added to your user account

`vm_configuration_default_user_password_download_path`

Type: string
Description: Full path to save your password on local machine

`vm_configuration_add_default_user_to_sudo`

Type: boolean

Description: Add user to sudo or wheel group

`vm_configuration_passwordless_sudo`

Type: boolean

Description: Allow to use sudo without password

`vm_configuration_set_selinux_permissive`

Type: boolean

Description: Disable SELinux

`vm_configuration_disable_system_firewall`

Type: boolean

Description: Disable system firewall

`vm_configuration_disable_oci_firewall`

Type: boolean

Description: Disable system firewall on Oracle Cloud instance (Ubuntu)

`vm_configuration_ufw_rules`

Type: dict

Description: Rules to be added to ufw; see *defaults/main.yml* for more details

### Other variables:

* see *vars/main.yml* file.

* devsec ssh_hardening role variables available at https://github.com/dev-sec/ansible-collection-hardening/tree/master/roles/ssh_hardening  
  **remember to prefix these variables with `vm_configuration_` prefix!**
## Dependencies

`vm_configuration_remote_user` should be able to perfom commands with root privileges.

Role requires following collections to be installed before launching the role:
  - *community.general*
  - *ansible.posix*
  - *devsec.hardening*

## Additional information

### Provisioning on WSL (RHEL 9 example)

  1. Prepare environment by running following commands (ensure that you are root)
      ```
      cd ansible-resources
      dnf install glibc-langpack-en python3-pip sudo
      dnf install curl --allowerasing
      pip3 install virtualenvwrapper
      export WORKON_HOME=~/venvs
      source /usr/local/bin/virtualenvwrapper.sh
      pip install ansible-core==2.16.*
      ansible-galaxy install -r roles/vm_configuration/meta/requirements.yml
      mkdir -p host_vars
      touch host_vars/localhost.yml
      ```
  2. Fill in variables in host_vars/localhost.yml
  3. Run ansible-playbook with following parameters
      ```
      ansible-playbook configure-vm.yml \ 
      -e "target_hosts=localhost" \
      --connection=local \
      --skip-tags vmc.03.04 \
      --skip-tags vmc.03.05 \
      --skip-tags vmc.03.06 \
      --skip-tags vmc.03.07 \
      --skip-tags vmc.configure-sshd
      ```

## Example Playbook

```
- name: "Run role"
  hosts: servers
  become: true
  roles:
    - role: vm_configuration
```

## License

Apache-2.0
