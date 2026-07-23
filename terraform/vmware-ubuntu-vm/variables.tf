variable "env_id" {
  description = "Unique Torque environment id, used to namespace the VM name so concurrent environments don't collide."
  type        = string
}

variable "vm_name" {
  description = "Base name for the virtual machine. Combined with env_id to guarantee uniqueness in vCenter."
  type        = string
  default     = "ubuntu-vm"
}

variable "datacenter" {
  description = "Name of the vSphere datacenter to deploy into."
  type        = string
}

variable "cluster" {
  description = "Name of the vSphere compute cluster (used to resolve the resource pool) to deploy into."
  type        = string
}

variable "datastore" {
  description = "Name of the vSphere datastore to place the VM's disks on."
  type        = string
}

variable "network" {
  description = "Name of the vSphere network/port group to attach the VM's NIC to."
  type        = string
}

variable "template_name" {
  description = "Name of the existing Ubuntu VM template (or content library template) to clone."
  type        = string
}

variable "num_cpus" {
  description = "Number of vCPUs to allocate to the VM."
  type        = number
  default     = 2
}

variable "memory" {
  description = "Amount of RAM in MB to allocate to the VM."
  type        = number
  default     = 4096
}

variable "disk_size_gb" {
  description = "Size in GB of the VM's primary disk. Must be >= the template's disk size."
  type        = number
  default     = 20
}

variable "domain" {
  description = "DNS domain used for guest OS customization."
  type        = string
  default     = "local"
}

variable "dns_server_list" {
  description = "DNS servers used for guest OS customization."
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}
