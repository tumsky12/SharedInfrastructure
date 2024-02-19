resource "random_string" "random" {
  length  = 8
  numeric = false
  lower   = false
  special = false
}

resource "azurerm_container_registry" "cr" {
  name                = "crShared${random_string.random.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
}
