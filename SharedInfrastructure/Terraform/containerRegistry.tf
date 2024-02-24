resource "azurerm_container_registry" "cr" {
  name                = "cr${var.resource_prefix}${var.unique_suffix_string}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}
