variable "datastore_id" {
  type = string
}
variable "pool_id" {
  type = string
}
variable "network_id" {
  type = string
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
    path_iso = string
  })
}