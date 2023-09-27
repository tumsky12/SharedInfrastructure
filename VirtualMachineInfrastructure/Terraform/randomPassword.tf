resource "random_password" "vm_password" {
  length  = 32
  special = true
}
