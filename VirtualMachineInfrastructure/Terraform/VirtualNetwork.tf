resource "azurerm_virtual_network" "net" {
  name                = "${var.resource_prefix}-net-${var.resource_suffix}"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}