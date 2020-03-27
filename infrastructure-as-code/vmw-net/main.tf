

# Declares the VMWare provider 
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "datacenter" {
  name = "PacketDatacenter"
}

data "vsphere_host" "host" {
  name          = "10.100.0.2"
  datacenter_id = "${data.vsphere_datacenter.datacenter.id}"
}

resource "vsphere_host_virtual_switch" "switch" {
  name           = "vSwitchTerraformTest"
  host_system_id = "${data.vsphere_host.host.id}"

  network_adapters = ["vmnic0", "vmnic1"]

  active_nics    = ["vmnic0"]
  standby_nics   = ["vmnic1"]
  teaming_policy = "failover_explicit"

  allow_promiscuous      = false
  allow_forged_transmits = false
  allow_mac_changes      = false

  shaping_enabled           = true
  shaping_average_bandwidth = 50000000
  shaping_peak_bandwidth    = 100000000
  shaping_burst_size        = 1000000000
}

