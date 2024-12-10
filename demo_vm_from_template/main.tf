terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.5.1"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
  }
}

provider "tls" {
  
}

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "local_file" "private_key" {
  content = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/ssh_key"
}

locals {
  vsphere_vm_ssh_info = {
    ssh_username = "admin"
    public_key = tls_private_key.ssh_key.public_key_openssh
  }
}

provider "vsphere" {
    user = var.vsphere_user
    password = var.vsphere_password
    vsphere_server = var.vsphere_server_address
    allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}



data "vsphere_network" "network" {
  name = var.vsphere_network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_host" "host" {
    name = var.vsphere_host_name
    datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_vm_information.template
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_vm_information.name
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label            = var.vsphere_vm_information.disk_label
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "hello-world"
        domain    = "example.com"
      }
      network_interface {
        ipv4_address = "172.16.11.10"
        ipv4_netmask = 24
      }
      ipv4_gateway = "172.16.11.1"
    }
  }
  extra_config = {
    "guestinfo.userdata" = base64encode(templatefile("${path.module}/templates/userdata.yml", local.vsphere_vm_ssh_info))
  }

  depends_on = [ tls_private_key.ssh_key ]
}