# vmware-ubuntu-vm

Torque-ready Terraform module that clones an existing Ubuntu template in VMware vSphere into a new virtual machine.

## Inputs

| Name | Description | Default |
|---|---|---|
| `env_id` | Unique Torque environment id, used to namespace the VM name | required |
| `vm_name` | Base name for the VM | `ubuntu-vm` |
| `datacenter` | vSphere datacenter name | required |
| `cluster` | vSphere compute cluster name | required |
| `datastore` | vSphere datastore name | required |
| `network` | vSphere network/port group name | required |
| `template_name` | Name of the Ubuntu template to clone | required |
| `num_cpus` | vCPU count | `2` |
| `memory` | RAM in MB | `4096` |
| `disk_size_gb` | Primary disk size in GB | `20` |
| `domain` | Guest OS customization domain | `local` |
| `dns_server_list` | Guest OS customization DNS servers | `["8.8.8.8", "8.8.4.4"]` |

## Outputs

| Name | Description |
|---|---|
| `vm_id` | vSphere managed object ID of the VM |
| `vm_name` | Full name of the VM as created in vCenter |
| `ip_address` | Guest IP address (from VMware Tools) - consumed by the `nginx-hello` Ansible asset |

## Example blueprint usage

```yaml
grains:
  ubuntu_vm:
    kind: terraform
    spec:
      source:
        store: stackautomation
        path: terraform/vmware-ubuntu-vm
      inputs:
        - env_id: '{{ .inputs.env_id }}'
        - datacenter: '{{ .inputs.vsphere_datacenter }}'
        - cluster: '{{ .inputs.vsphere_cluster }}'
        - datastore: '{{ .inputs.vsphere_datastore }}'
        - network: '{{ .inputs.vsphere_network }}'
        - template_name: '{{ .inputs.vsphere_template }}'
      outputs:
        - vm_id
        - vm_name
        - ip_address
```

Notes:
- The vSphere provider itself is configured by the Torque agent (`VSPHERE_SERVER` / `VSPHERE_USER` / `VSPHERE_PASSWORD` env vars) - this module intentionally contains no `provider` block or credentials.
- The template must already exist in vCenter with VMware Tools installed so `default_ip_address` resolves.
