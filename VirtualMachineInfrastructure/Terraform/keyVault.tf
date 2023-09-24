resource "azurerm_key_vault" "kv" {
  name                        = "${var.resource_prefix}-kv-${var.resource_environment}"
  location                    = data.azurerm_resource_group.rg.location
  resource_group_name         = data.azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true

  sku_name = "standard"
}

resource "azurerm_key_vault_secret" "kvs" {
  name         = "admin-password"
  value        = random_password.vm_password.result
  key_vault_id = azurerm_key_vault.kv.id

  #depends_on = [ azurerm_key_vault_access_policy.kvap ]
  #depends_on = [azurerm_role_assignment.ra_kv_admin]
}