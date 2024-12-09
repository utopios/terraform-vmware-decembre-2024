output "first_name_from_object" {
  description = "Result of attribute first_name of student var"
  value = var.student.first_name
}

output "grades" {
  value = var.grades
}

output "grades_from_object_student" {
  value = var.student.grades
}

