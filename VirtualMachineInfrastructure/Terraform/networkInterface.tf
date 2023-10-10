resource "azurerm_network_interface" "nic" {
  name                = "${var.resource_prefix}-nic-${var.resource_environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = data.azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}