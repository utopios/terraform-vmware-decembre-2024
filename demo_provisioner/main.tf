resource "null_resource" "local_script" {
  provisioner "local-exec" {
    command = "echo Hello from local exec > out.txt"
  }
}