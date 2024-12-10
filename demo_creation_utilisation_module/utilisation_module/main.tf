provider "vsphere" {
  user = var.vsphere_user
  password = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}

module "demo_module" {
  source = "../demo_module"
  vsphere_datacenter_name = "Datacenter"
}

output "result_module" {
  value = module.demo_module.result_datacenter_id
}