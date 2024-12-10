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

# ----------------------------------------
# Création du datastore cluster fonctionne avec vcenter
# ----------------------------------------

# resource "vsphere_datastore_cluster" "production_datastore_cluster" {
#   name          = var.vsphere_datastore_cluster_name
#   datacenter_id = data.vsphere_datacenter.datacenter.id
#   sdrs_enabled  = true
# }

output "datacenter" {
  value = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_nas_datastore" "datastore" {
  name            = var.datastore_nfs_name
  host_system_ids = [data.vsphere_host.host.id]

  type         = "NFS"
  remote_hosts = var.datastore_nfs_remote
  remote_path  = var.datastore_nfs_remote_path
}

# -------------------------------
# Application de la politique de stockage (pour les environnements de test)
# -------------------------------
resource "vsphere_vm_storage_policy" "test_storage_policy" {
  name            = "Test-Storage-Policy"
  description     = "Politique de stockage pour les VMs de test"
  tag_rules {
    tag_category = ""
    tags = [""]

  }
}

# -------------------------------
# Application de la politique de stockage (pour les environnements de production)
# -------------------------------
resource "vsphere_vm_storage_policy" "production_storage_policy" {
  name            = "Production-Storage-Policy"
  description     = "Politique de stockage pour les VMs de production"
  tag_rules {
    tag_category = ""
    tags = [""]

  }
}