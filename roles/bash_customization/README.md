# bash_customization role


Role to configure bash and assisting tools for specific user.

## Requirements

User whose environment will be modified, should be created before launching of the role. 
It's recommended to do this for example via role *vm_configuration*.

## Role Variables

### User-provided variables:

`bash_customization_default_user`

Type: string

Description: name of user to provision configuration for

`bash_customization_default_group`

Type: string

Description: group that user to provision configuration for belongs to

`bash_customization_bash_hostname_color`

Type: string

Description: color from bash 256color table to use as background for hostname in prompt for user that configuration is provisioned for

`bash_customization_bash_aliases_additional_entries`

Type: string

Description: additional bash aliases to be added to configuration file for user that configuration is provisioned for

### Other variables:

* see *vars/main.yml* file.

## Dependencies

`bash_customization_remote_user` should be able to perfom commands with root privileges.

## Additional information

### Tmux configuration

  1. Install all tmux plugins by hitting *CTRL + b* then quickly *SHIFT + i* in tmux
  2. Build *tmux-mem-cpu-load* plugin using following commands:
    ```
    cd $TMUX_PLUGIN_MANAGER_PATH/tmux-mem-cpu-load
    cmake .
    ```
  3. Restart session

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
      mkdir -p host_vars
      touch host_vars/localhost.yml
      ```
  2. Fill in variables in vars/host_vars/localhost/localhost.yml
  3. Run ansible-playbook with following parameters
      ```
      ansible-playbook customize-bash.yml \
      -e "target_hosts=localhost" \
      --connection=local 
      ```

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
