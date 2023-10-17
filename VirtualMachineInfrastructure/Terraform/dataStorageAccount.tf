data "azurerm_storage_account" "sa" {
  name                = local.shared_storage_account
  resource_group_name = local.shared_resource_group_name
}