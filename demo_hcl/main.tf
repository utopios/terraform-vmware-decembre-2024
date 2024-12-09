# Le premier block => provider à utiliser
# provider "nom_provider" {
#   ### Configuration du provider 
# }

# Un Block de variables
# Un Ensemble de variables
variable "var_1" {
  description = "first var"
  type = string
  default = "default value"
}

#Block => gestion de ressources

# resource "type" "name" {
#   ### Configuration
# }

# Block => gestion de sortie.
output "output_var_1" {
  value = var.var_1
}


output "selected_datacenter" {
  value = var.datacenter
}
output "selected_resource_pools" {
  value = var.resource_pools
}
output "vm_common_tags" {
  value = var.vm_tags
}