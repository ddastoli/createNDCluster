# vSphere variables
vsphere_dc          = "DC1"
vsphere_ds          = "datastorem4"
cluster     = "Edge"
vm_folder   = "CiscoLive"
vm_template = "centostemplate"
vm_portgroup = "VM Network"
vm_name            = "vnd1"
vm_network_ip      = "10.48.169.210"
vm_network_mask    = 24
vm_network_gateway = "10.48.169.1"
host = "dom-esxi-m4-4.cisco.com"

# List of VMs to deploy in the scenario
vm_list = {
  "vnd1" = {
    vm_name            = "vnd1"
    vm_network_ip      = "10.48.170.107/24"
    vm_network_mask    = 24
    vm_network_gateway = "10.48.170.1"
    vm_firstMaster        = "True"
  },
  "vnd2" = {
    vm_name            = "vnd2"
    vm_network_ip      = "10.48.170.108/24"
    vm_network_mask    = 24
    vm_network_gateway = "10.48.170.1"
    vm_firstMaster        = "False"
  },
  "vnd3" = {
    vm_name            = "vnd3"
    vm_network_ip      = "10.48.170.109/24"
    vm_network_mask    = 24
    vm_network_gateway = "10.48.170.1"
    vm_firstMaster        = "False"
  }
}
