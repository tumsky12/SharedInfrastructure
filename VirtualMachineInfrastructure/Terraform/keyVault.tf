resource "azurerm_key_vault" "kv" {
  name                        = "${var.resource_prefix}-kv-vm-${var.resource_environment}"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true

  sku_name = "standard"
}

resource "azurerm_role_assignment" "ra_kv_admin" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "kvstemp" {
  name         = "admin-username"
  value        = local.shared_vm_admin_username
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_role_assignment.ra_kv_admin]
}

resource "azurerm_key_vault_secret" "kvs" {
  name         = "admin-password"
  value        = random_password.vm_password.result
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_role_assignment.ra_kv_admin]
}