variable "vsphere_datacenter_name" {
  description = "vsphere datacenter name"
  type = string
  default = "Datacenter"
}

variable "vsphere_host_name" {
  description = "vsphere host name"
  type = string
  default = "5.135.138.197"
}

variable "network_name" {
  type = string
  description = "Network name"
  default = "VM Network"
}


variable "datastore_name" {
  type = string
  description = "datastore name"
  default = "datastore1"
}
