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

data "vsphere_datastore" "datastore" {
  name          = var.datastore_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_network" "network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_information.name
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = var.vm_information.num_cpus
  memory           = var.vm_information.memory
  guest_id         = var.vm_information.guest_id
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = var.vm_information.disk.label
    size  = var.vm_information.disk.size
  }
  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path = var.vm_information.path_iso
  }
  wait_for_guest_net_timeout = 0
}