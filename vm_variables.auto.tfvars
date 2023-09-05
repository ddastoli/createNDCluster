# vSphere variables
vsphere_dc          = "DatacenterACI"
vsphere_ds          = "Server2_M6_disk2"
vsphere_ds2          = "DIsk2M6_88"
cluster     = "Edge"
host = "10.48.170.87"
host2 = "10.48.170.88"

vm_portgroup1 = "VM Network"
vm_portgroup2 = "vND_Data"
nd_password = "ins3965!"
nd_ova_url = "http://aci-artifactory-001.insieme.local:8082/artifactory/atom-bld/releases/nd/v3.0.0.220/nd-dk9.3.0.0.220.ova"

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
