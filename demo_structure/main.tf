variable "demo_condition" {
  description = "value of demo condition"
  type = bool
  default = true
}

output "out_condition" {
  value = var.demo_condition ? "La condition est vrai" : "La condition est fausse"
}


variable "list_of_strings" {
  description = "A list of strings"
  type        = list(string)
  default     = ["apple", "banana", "cherry"]
}
output "lengths_of_strings" {
  value = [for s in var.list_of_strings : length(s)]
}

variable "set_of_names" {
  description = "A set of names"
  type        = set(string)
  default     = ["Alice", "Bob", "Charlie"]
}
resource "null_resource" "example" {
  for_each = var.set_of_names
  #name = each.value
}

variable "name" {
  default = "world"
}
output "greeting" {
  value = "Hello, ${var.name}!"
}