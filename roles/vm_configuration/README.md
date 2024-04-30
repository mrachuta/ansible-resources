# vm_configuration role

Role to install software, configure accounts and privileges and some security aspects.

## Requirements

If you want to allow remote access via SSH using keys, generate them before launching of the role.

## Role Variables

### User-provided variables:

`remove_root_password`

Type: boolean

Description: Remove password from root account to prevent direct login


`create_technical_user`

Type: boolean

Description: Switch to create or not technical user account


`technical_user`

Type: string

Description: Name of technical user (to be used for example as ansible user in future)

`technical_user_ssh_key_path`

Type: string

Description: Full path to public ssh key to be added to technical user account

`create_default_user`

Type: boolean

Description: Switch to create or not defalt user account

`default_user`

Type: string

Description: Name of your user to be used on server

`default_user_ssh_key_path`

Type: string

Description: Full path to public ssh key to be added to your user account

`default_user_password_download_path`

Type: string
Description: Full path to save your password on local machine

`add_default_user_to_sudo`

Type: boolean

Description: Add user to sudo or wheel group

`passwordless_sudo`

Type: boolean

Description: Allow to use sudo without password

`set_selinux_permissive`

Type: boolean

Description: Disable SELinux

`disable_system_firewall`

Type: boolean

Description: Disable system firewall

`disable_oci_firewall`

Type: boolean

Description: Disable system firewall on Oracle Cloud instance (Ubuntu)

`ufw_rules`

Type: dict

Description: Rules to be added to ufw; see *defaults/main.yml* for more details

### Other variables:

* see *vars/main.yml* file.

* devsec ssh_hardening role variables available at https://github.com/dev-sec/ansible-collection-hardening/tree/master/roles/ssh_hardening

## Dependencies

`remote_user` should be able to perfom commands with root privileges.

Role requires following collections to be installed before launching the role:
  - *community.general*
  - *ansible.posix*
  - *devsec.hardening*

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
