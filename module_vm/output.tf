output "default_ip_address" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "guest_ip_addresses" {
  value = vsphere_virtual_machine.vm.guest_ip_addresses
}