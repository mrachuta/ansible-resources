# bash_customization role


Role to configure bash and assisting tools for specific user.

## Requirements

User whose environment will be modified, should be created before launching of the role. 
It's recommended to do this for example via role *vm_configuration*.

## Role Variables

### User-provided variables:

`default_user`

Type: string

Description: name of user to modify bash and other tools

`default_group`

Type: string

Description: name of user to modify bash and other tools

`bash_hostname_color`

Type: string

Description: color from bash 256color table to use as background for hostname in prompt

### Other variables:

* see *vars/main.yml* file.

## Dependencies

`remote_user` should be able to perfom commands with root privileges.

## Additional information

To install all tmux plugins hit CTRL + B + I in tmux, then restart your session.

## Example Playbook

```
- name: "Run role"
  hosts: servers
  become: true
  roles:
      - role: bash_customization
```

## License

Apache-2.0
