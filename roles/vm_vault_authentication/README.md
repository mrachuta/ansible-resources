# vm_vault_authentication role

Role to configure an Ansible SSH connection to a VM with credentials read from
Vault.

## Role Variables

`vm_vault_authentication_use_vault`

Type: boolean

Description: enables the role when true

`vm_vault_authentication_vault_secret_path`

Type: string

Description: KV v2 path containing the connection credentials; the role is not
run when this value is empty

`vm_vault_authentication_username_key`

Type: string

Description: key containing the SSH username

`vm_vault_authentication_ssh_private_key_key`

Type: string

Description: key containing the SSH private key

## Dependencies

The `community.hashi_vault` collection and a configured AppRole environment
are required when the role is enabled.

## License

Apache-2.0
