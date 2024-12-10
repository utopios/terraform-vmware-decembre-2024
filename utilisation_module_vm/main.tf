provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}

module "data_information" {
  source = "../module_data_vmware"
}

module "vm_module" {
  source = "git::https://github.com/utopios/vm_terraform_vmware.git"
  vm_information = {
    name     = "Ihab"
    num_cpus = 1
    memory   = 1024
    guest_id = "ubuntu64Guest"
    disk = {
      label = "Disk vm ihab"
      size  = 40
    }
    path_iso = "iso/ubuntu-24.04.1-desktop-amd64.iso"
  }
  network_id = module.data_information.network_id
  pool_id = module.data_information.pool_id
  datastore_id = module.data_information.datastore_id
}
