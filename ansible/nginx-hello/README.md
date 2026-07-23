# nginx-hello

Torque-ready Ansible playbook that installs nginx on a target host and serves a static
page saying "hello from stack automation". Designed to run as a second grain that
depends on a compute grain (e.g. `terraform/vmware-ubuntu-vm`) and consumes its IP output.

## Expected inventory

| Group | Vars |
|---|---|
| `web_servers` (override with `target_group`) | `ansible_host`, `ansible_user`, `ansible_become: true`, optionally `ansible_ssh_private_key_file` |

## Inputs (extra-vars)

| Name | Description | Default |
|---|---|---|
| `greeting_message` | Text served on the index page | `hello from stack automation` |
| `http_port` | Port nginx listens on | `80` |

## Outputs

| Name | Description |
|---|---|
| `web_url` | URL of the running nginx site |
| `deploy_status` | `success` or `failed` |

## Example blueprint usage

```yaml
grains:
  nginx_hello:
    kind: ansible
    spec:
      source:
        store: stackautomation
        path: ansible/nginx-hello/playbook.yaml
      inventory-file:
        web_servers:
          hosts:
            ubuntu-vm:
              ansible_host: '{{ .grains.ubuntu_vm.outputs.ip_address }}'
          vars:
            ansible_user: '{{ .inputs.ssh_user }}'
            ansible_become: true
      inputs:
        - greeting_message: '{{ .inputs.greeting_message }}'
        - http_port: '{{ .inputs.http_port }}'
      outputs:
        - web_url
        - deploy_status
    depends-on: ubuntu_vm
```

No `teardown.yaml` is included — the only resource this playbook manages (the nginx
service and static page) lives entirely on the VM created by `ubuntu_vm`, which is
destroyed by that grain when the environment ends.
