variable "environment_variable" {
  description = "The environment variable"
  type = string
  #default = "dev"
  # Permet d'indiquer quand une variable est valide
  validation {
    condition = var.environment_variable == "prod" || var.environment_variable == "dev"
    error_message = "The environment variable must be prod or dev"
  }
}

variable "instance_type" {
    description = "type of resource"
    type = string
    #default = "small"
    validation {
    condition = var.instance_type == "small" || var.instance_type == "large"
    error_message = "The instance type must be small or large"
  }
}


# variable "instance_size" {
#   description = "size of resource"
#   default = var.instance_type == "small" ? "micro" : "big" 
# }

### pour avoir des variables calculées à l'execution du script terraform, on peut créer les variables dans un block locals
locals {
  size_instance = var.instance_type == "small" ? "micro" : "big" 
}

output "output_envrionment" {
  value = var.environment_variable
}

output "output_size" {
  value = local.size_instance
}