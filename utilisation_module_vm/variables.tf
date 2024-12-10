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

