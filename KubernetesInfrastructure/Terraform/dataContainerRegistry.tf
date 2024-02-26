data "azurerm_container_registry" "cr" {
  name                = local.container_registry_name
  resource_group_name = local.container_registry_group
}
