resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_information.name
  resource_pool_id = var.pool_id
  datastore_id     = var.datastore_id
  num_cpus         = var.vm_information.num_cpus
  memory           = var.vm_information.memory
  guest_id         = var.vm_information.guest_id
  network_interface {
    network_id = var.network_id
  }
  disk {
    label = var.vm_information.disk.label
    size  = var.vm_information.disk.size
  }
  cdrom {
    datastore_id = var.datastore_id
    path = var.vm_information.path_iso
  }
  wait_for_guest_net_timeout = 0
}