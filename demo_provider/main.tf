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
  allow_unverified_ssl = true
}


## Récupération des informations sur la resource datacenter
data "vsphere_datacenter" "datacenter" {
  name = "Datacenter"
}


## Récupération des informations sur la resource network
data "vsphere_network" "network" {
  name = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

## Récupération des informations sur la resource host
data "vsphere_host" "host" {
    name = var.vsphere_server
    datacenter_id = data.vsphere_datacenter.datacenter.id
}


output "result_datacenter" {
  value = data.vsphere_datacenter.datacenter.name
}

output "result_vsphere_host" {
  value = data.vsphere_host.host.name
}

output "result_vsphere_network" {
  value = data.vsphere_network.network.type
}