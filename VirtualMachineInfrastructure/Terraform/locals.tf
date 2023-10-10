locals {
  shared_resource_group_name  = "${var.resource_prefix}-rg-${var.resource_environment}"
  shared_virtual_network_name = "${var.resource_prefix}-net-${var.resource_environment}"
  shared_sub_net_name         = "subnet"
  shared_vm_admin_username    = "adminuser"
}