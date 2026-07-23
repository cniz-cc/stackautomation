output "vm_id" {
  description = "The vSphere managed object ID of the created VM."
  value       = vsphere_virtual_machine.ubuntu.id
}

output "vm_name" {
  description = "The full name of the VM as created in vCenter."
  value       = vsphere_virtual_machine.ubuntu.name
}

output "ip_address" {
  description = "The guest IP address reported by VMware Tools, used by downstream grains (e.g. the nginx asset)."
  value       = vsphere_virtual_machine.ubuntu.default_ip_address
}
