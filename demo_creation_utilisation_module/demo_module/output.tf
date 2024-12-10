output "result_datacenter_id" {
  description = "Id of datacenter"
  value = data.vsphere_datacenter.datacenter.id
}