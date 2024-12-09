variable "var_2" {
  type = string
  description = "var 2"
}

variable "var_3" {
  type = bool
  default = false
  description = "var 3 bool"
}

variable "datacenter" {
  description = "The datacenter in vSphere to deploy to"
  type        = string
  default     = "dc-01"
}
variable "resource_pools" {
  description = "The resource pools to deploy VMs to"
  type        = list(string)
  default     = ["resource-pool-1", "resource-pool-2"]
}
variable "vm_tags" {
  description = "The tags to apply to virtual machines"
  type        = map(string)
  default     = { Owner = "DevOps", Environment = "Production" }
}