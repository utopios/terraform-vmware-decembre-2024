output "datastore_id" {
  value = data.vsphere_datastore.datastore.id
}
output "network_id" {
  value = data.vsphere_network.network.id
}
output "pool_id" {
  value = data.vsphere_host.host.resource_pool_id
}