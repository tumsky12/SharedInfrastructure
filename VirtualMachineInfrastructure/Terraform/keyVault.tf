module "kv" {
  source                  = "../../TerraformModules/KeyVault"
  resource_group_location = data.azurerm_resource_group.rg.location
  resource_prefix         = var.resource_prefix
  resource_group_name     = data.azurerm_resource_group.rg.name
  resource_name           = "kv-vm"
  resource_environment    = var.resource_environment
}

resource "azurerm_key_vault_secret" "kvs_admin_username" {
  name         = "admin-username"
  value        = local.shared_vm_admin_username
  key_vault_id = module.kv.key_vault_id

  depends_on = [module.kv]
}

resource "azurerm_key_vault_secret" "kvs_admin_password" {
  name         = "admin-password"
  value        = random_password.vm_password.result
  key_vault_id = module.kv.key_vault_id

  depends_on = [module.kv]
}
