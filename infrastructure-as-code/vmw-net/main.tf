

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

resource "vsphere_host_port_group" "pg" {
  name                = "${var.vsphere_pg_name}"
  host_system_id      = "${data.vsphere_host.host.id}"
  virtual_switch_name = "vSwitch0"

  vlan_id = 4095

  allow_promiscuous = true
}

