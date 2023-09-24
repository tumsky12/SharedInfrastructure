resource "azurerm_network_security_group" "nsg" {
  name                = "${var.resource_prefix}-nsg-${var.resource_environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}