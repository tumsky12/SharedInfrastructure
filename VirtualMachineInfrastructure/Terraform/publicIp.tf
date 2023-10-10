resource "azurerm_public_ip" "pip" {
  name                = "${var.resource_prefix}-pip-${var.resource_environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"
}
