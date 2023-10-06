resource "azurerm_storage_account" "sa" {
  name                     = "${var.resource_prefix}${var.resource_name}${var.resource_environment}${var.storage_account_numerical_suffix}"
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_role_assignment" "ra_sa_admin_current" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "ra_sa_admin_owner" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = module.constants.owners_group_id
}

# resource "azurerm_role_assignment" "ra_sa_user" {
#   scope                = azurerm_storage_account.sa.id
#   role_definition_name = "Storage Blob Data Reader"
#   principal_id         = module.constants.owners_group_id
# }