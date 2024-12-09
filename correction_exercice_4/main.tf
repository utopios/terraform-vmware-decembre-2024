variable "names" {
  description = "list of names"
  type = list(string)
  default = [ "toto", "tata", "titi" ]
}

locals {
  chaine = join(",", var.names)
}

output "size_list" {
  value = length(var.names)
}

output "result_join" {
  value = local.chaine
}