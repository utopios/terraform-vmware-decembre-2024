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
