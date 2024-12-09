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
output "from_template" {
    value = [for n in var.names : templatefile("${path.module}/example.tpl", {name = n})]
}