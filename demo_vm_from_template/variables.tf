variable "vsphere_user" {
  description = "vsphere user"
  type = string
}


variable "vsphere_password" {
  description = "vsphere password"
  type = string
}

variable "vsphere_server_address" {
  description = "vsphere address"
  type = string
  # A ne pas faire
  default = "192.168.29.131"
}

variable "vsphere_datacenter_name" {
  description = "vsphere datacenter name"
  type = string
  default = "Datacenter"
}

variable "vsphere_network_name" {
  description = "vsphere network name"
  type = string
  default = "VM Network"
}

variable "vsphere_host_name" {
  description = "vsphere host name"
  type = string
  default = "192.168.29.130"
}

variable "vsphere_datastore_name" {
  type = string
  description = "Datastore name"
  default = "datastore1"
}

variable "vsphere_vm_information" {
  type = object({
    name = string
    disk_size = number
    disk_label = string
    template = string
  })
  default = {
    name = "vmihab"
    disk_label = "diskihab"
    disk_size = 10
    template = "ubuntu"
  }
}

# variable "vsphere_vm_ssh_info" {
#   type = object({
#     ssh_username = string
#     public_key = string
#   })
# }