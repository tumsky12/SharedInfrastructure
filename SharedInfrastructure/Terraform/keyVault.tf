module "kv" {
  source                  = "../../../CoreTerraformModules/Modules/KeyVault"
  resource_group_location = azurerm_resource_group.rg.location
  resource_prefix         = var.resource_prefix
  resource_group_name     = azurerm_resource_group.rg.name
  resource_name           = "kv"
  resource_environment    = var.resource_environment
  key_vault_suffix        = var.unique_suffix_int
}

resource "azurerm_key_vault_secret" "kvs_cr_login_server" {
  name         = "cr-login-server"
  value        = azurerm_container_registry.cr.login_server
  key_vault_id = module.kv.key_vault_id

  depends_on = [module.kv]
}

resource "azurerm_key_vault_secret" "kvs_cr_admin_login" {
  name         = "cr-admin-login"
  value        = azurerm_container_registry.cr.login_server
  key_vault_id = module.kv.key_vault_id

  depends_on = [module.kv]
}

resource "azurerm_key_vault_secret" "kvs_cr_admin_password" {
  name         = "cr-admin-password"
  value        = azurerm_container_registry.cr.login_server
  key_vault_id = module.kv.key_vault_id

  depends_on = [module.kv]
}
