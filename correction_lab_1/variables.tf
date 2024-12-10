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

variable "vsphere_vswitch_information" {
    description = "Information of virtual switch"
    type = object({
      name = string
      network_adapters = list(string)
      active_nics = list(string)
      standby_nics = list(string)
    })
    
}

variable "vsphere_port_list_group" {
  type = set(string)
  description = "List of port group"
}

variable "vsphere_port_group_extra_group" {
  description = "extra group port"
  type = bool
  default = false
}

variable "vsphere_port_group_extra_group_name" {
  description = "extra group port name"
  type = string
  default = "Name Of Extra group"
}