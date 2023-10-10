locals {
  shared_resource_group_name    = "${var.resource_prefix}-rg-${var.resource_environment}"
  shared_network_interface_name = "${var.resource_prefix}-nic-${var.resource_environment}"
  shared_public_ip_name         = "${var.resource_prefix}-pip-${var.resource_environment}"
  shared_vm_admin_username      = "adminuser"
}