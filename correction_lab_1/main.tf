terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.10.0"
    }
  }
}

provider "vsphere" {
  user = var.vsphere_user
  password = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}


data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter_name
}

data "vsphere_host" "host" {
  name          = var.vsphere_host_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_host_virtual_switch" "switch" {
  name           = var.vsphere_vswitch_information.name
  host_system_id = data.vsphere_host.host.id

  network_adapters = var.vsphere_vswitch_information.network_adapters

  active_nics  = var.vsphere_vswitch_information.active_nics
  standby_nics = var.vsphere_vswitch_information.standby_nics
}


resource "vsphere_host_port_group" "pg_ihab" {
  name                = each.value
  host_system_id      = data.vsphere_host.host.id
  #virtual_switch_name = var.vsphere_vswitch_information.name
  virtual_switch_name = vsphere_host_virtual_switch.switch.name
  for_each = var.vsphere_port_list_group
  #depends_on = [ vsphere_host_virtual_switch.switch ]
}

resource "vsphere_host_port_group" "pg_ihab_extra_group" {
  count = var.vsphere_port_group_extra_group ? 1 : 0
  name                = var.vsphere_port_group_extra_group_name
  host_system_id      = data.vsphere_host.host.id
  virtual_switch_name = vsphere_host_virtual_switch.switch.name
}