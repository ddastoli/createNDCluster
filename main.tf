data "vsphere_datacenter" "vsphere_dc" {
  name = var.vsphere_dc
}

data "vsphere_datastore" "vsphere_ds" {
  name          = var.vsphere_ds
  datacenter_id = data.vsphere_datacenter.vsphere_dc.id
}

data "vsphere_host" "host" {
  name          = var.host
  datacenter_id = data.vsphere_datacenter.vsphere_dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = "${data.vsphere_datacenter.vsphere_dc.id}"
}

data "vsphere_network" "vm_portgroup1" {
  name            = var.vm_portgroup1
  datacenter_id = data.vsphere_datacenter.vsphere_dc.id
}

data "vsphere_network" "vm_portgroup2" {
  name            = var.vm_portgroup2
  datacenter_id = data.vsphere_datacenter.vsphere_dc.id
}

data "vsphere_resource_pool" "default" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.vsphere_dc.id
}

data "vsphere_ovf_vm_template" "ovfRemote" {
  name              = "vND"
  disk_provisioning = "thin"
  datastore_id      = data.vsphere_datastore.vsphere_ds.id
  resource_pool_id  = data.vsphere_resource_pool.default.id
  host_system_id    = data.vsphere_host.host.id
  remote_ovf_url    = "http://aci-artifactory-001.insieme.local:8082/artifactory/atom-bld/releases/nd/v3.0.0.209/nd-dk9.3.0.0.209.ova"
  ovf_network_map = {
    "VM Network" : data.vsphere_network.vm_portgroup1.id
    "VM Network" : data.vsphere_network.vm_portgroup2.id
  }
}


## Deployment of VM from Remote OVF
resource "vsphere_virtual_machine" "vmFromRemoteOvf" {
  for_each             = var.vm_list
  name                 = each.value.vm_name
  datacenter_id        = data.vsphere_datacenter.vsphere_dc.id
  datastore_id         = data.vsphere_datastore.vsphere_ds.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = data.vsphere_resource_pool.default.id
  num_cpus             = data.vsphere_ovf_vm_template.ovfRemote.num_cpus
  num_cores_per_socket = data.vsphere_ovf_vm_template.ovfRemote.num_cores_per_socket
  memory               = data.vsphere_ovf_vm_template.ovfRemote.memory
  guest_id             = data.vsphere_ovf_vm_template.ovfRemote.guest_id
  firmware             = data.vsphere_ovf_vm_template.ovfRemote.firmware
  scsi_type            = data.vsphere_ovf_vm_template.ovfRemote.scsi_type
  nested_hv_enabled    = data.vsphere_ovf_vm_template.ovfRemote.nested_hv_enabled
  dynamic "network_interface" {
    for_each = data.vsphere_ovf_vm_template.ovfRemote.ovf_network_map
    content {
      network_id = network_interface.value
    }
  }
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    remote_ovf_url            = data.vsphere_ovf_vm_template.ovfRemote.remote_ovf_url
    disk_provisioning         = data.vsphere_ovf_vm_template.ovfRemote.disk_provisioning
    ovf_network_map           = {
      "Network 1" = data.vsphere_network.vm_portgroup1.id
      "Network 2" = data.vsphere_network.vm_portgroup2.id
    }
    #ovf_network_map           = data.vsphere_ovf_vm_template.ovfRemote.ovf_network_map
  }

  vapp {
    properties = {
      "dataDiskSizeApp"  = "500",
      "mgmt_ip" = each.value.vm_network_ip,
      "gw_ip"   = each.value.vm_network_gateway,
      "adminPassword"       = "ins3965!",
      "firstMaster"       = each.value.vm_firstMaster
    }
  }
  lifecycle {
    ignore_changes = [
      annotation,
      disk[0].io_share_count,
      disk[1].io_share_count,
      disk[2].io_share_count,
      vapp[0].properties,
    ]
  }
}