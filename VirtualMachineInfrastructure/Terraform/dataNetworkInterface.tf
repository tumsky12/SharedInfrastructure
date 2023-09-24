data "azurerm_network_interface" "nic" {
  name = local.shared_resource_group_name
  resource_group_name = local.sharednetwork_interface_name
}