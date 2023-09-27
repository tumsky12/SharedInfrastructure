data "azurerm_network_interface" "nic" {
  name                = local.shared_network_interface_name
  resource_group_name = local.shared_resource_group_name
}