resource "azurerm_network_security_group" "nsg" {
  name                = "${var.resource_prefix}-nsg-${var.resource_environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "nsr" { #Todo: dont do this! vpn/ private connection instead
  name                        = "${var.resource_prefix}-nsr-rdp-${var.resource_environment}"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg
  network_security_group_name = azurerm_network_security_group.nsg.name
}