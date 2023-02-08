# bash_customization role


Role to configure bash and assisting tools for specific user.

## Requirements

User whose environment will be modified, should be created before launching of the role. 
It's recommended to do this for example via role *vm_configuration*.

## Role Variables

### Required variables:

`default_user`

Type: string

Description: name of user to modify bash and other tools

`default_group`

Type: string

Description: name of user to modify bash and other tools

### Optional variables:

see *vars/main.yml* file.

## Dependencies

`remote_user` should be able to perfom commands with root privileges.

## Example Playbook

```
- name: "Run role"
  hosts: servers
  become: True
  roles:
      - role: bash_customization
```

## License


Apache-2.0
