data "azurerm_public_ip" "pip" {
  name                = local.shared_public_ip_name
  resource_group_name = local.shared_resource_group_name
}