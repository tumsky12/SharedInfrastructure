locals {
  container_registry_name  = "cr${var.container_registry_resource_prefix}${var.unique_suffix_string}"
  container_registry_group = "rg-${var.container_registry_resource_prefix}-${var.resource_environment}"
}
