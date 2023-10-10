data "azurerm_subnet" "sn" {
  name                 = local.shared_sub_net_name
  virtual_network_name = local.shared_virtual_network_name
  resource_group_name  = local.shared_resource_group_name
}