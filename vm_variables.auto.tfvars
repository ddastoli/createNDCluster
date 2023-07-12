# vSphere variables
vsphere_dc          = "DC1"
vsphere_ds          = "datastorem4"
cluster     = "Edge"
vm_folder   = "CiscoLive"
host = "dom-esxi-m4-4.cisco.com"
vm_portgroup1 = "VM Network"
vm_portgroup2 = "VM Network"

# List of VMs to deploy in the scenario
vm_list = {
  "vnd1" = {
    vm_name            = "vnd1"
    vm_network_ip      = "10.48.170.107/24"
    vm_network_gateway = "10.48.170.1"
    vm_firstMaster     = true
  },
  "vnd2" = {
    vm_name            = "vnd2"
    vm_network_ip      = "10.48.170.108/24"
    vm_network_gateway = "10.48.170.1"
    vm_firstMaster     = false
  },
  "vnd3" = {
    vm_name            = "vnd3"
    vm_network_ip      = "10.48.170.109/24"
    vm_network_gateway = "10.48.170.1"
    vm_firstMaster     = false
  }
}
