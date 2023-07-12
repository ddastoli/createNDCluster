variable "vsphere_server" {
  type        = string
  description = "vSphere vCenter URL"
}

variable "vsphere_username" {
  type        = string
  description = "vSphere vCenter username"
}

variable "vsphere_password" {
  type        = string
  description = "vSphere vCenter password"
  sensitive   = true
}

variable "vsphere_dc" {
    description = "Datacenter name in vSphere vCenter where the VM will be created"
}

variable "vsphere_ds" {
    description = "Datastore name in vSphere vCenter where the VM will be stored"
}

variable "cluster" {
    description = "Cluster name in vSphere vCenter where the VM will be deployed"
}

variable "host" { 
    description = "Host name in vSphere vCenter where the VM will be deployed. Optional, if ommited the host will be selected automatically"
    default = null 
    }

variable "vm_portgroup1" {
    description = "VM Template name that will be cloned to create the new VM"
}

variable "vm_portgroup2" {
    description = "VM Template name that will be cloned to create the new VM"
}

variable "vm_list" {
  type = map(object({
    vm_name            = string
    vm_network_ip      = string
    vm_network_gateway = string
    vm_firstMaster     = bool
  }))
}

variable "vm_folder" {
    description = "Folder where the new VM will be placed within the Datacenter in vSphere vCenter"
}

variable "vm_domain" {
  description = "Domain name to be configured in the VM. Optional, if ommited lab.local will be used"
  default = "lab.local"
}

variable "vm_portgroup" {
    description = "Port Group where the VM interface will be connected. By default, quarantine will be used"
    default = "quarantine"
}