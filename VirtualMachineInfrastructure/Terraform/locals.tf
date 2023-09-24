locals {
  shared_resource_group_name = "${var.resource_prefix}-rg-${var.resource_environment}"
  sharednetwork_interface_name = "${var.resource_prefix}-nic-${var.resource_environment}"
}