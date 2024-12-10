variable "vsphere_user" {
  description = "vsphere user"
  type = string
}


variable "vsphere_password" {
  description = "vsphere password"
  type = string
}

variable "vsphere_server" {
  type = string
}
variable "vsphere_allow_unverified_ssl" {
  type = bool
  default = true
}

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

variable "vm_information" {
  type = object({
    name = string
    num_cpus = number
    memory = number
    guest_id = string
    disk = object({
      label = string
      size = number 
    })
  })
}