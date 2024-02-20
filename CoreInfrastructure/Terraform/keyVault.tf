resource "random_integer" "random" {
  min = 10000
  max = 99999
}

module "kv" {
  source                  = "../../../CoreTerraformModules/Modules/KeyVault"
  resource_group_location = azurerm_resource_group.rg.location
  resource_prefix         = var.resource_prefix
  resource_group_name     = azurerm_resource_group.rg.name
  resource_name           = "kv"
  resource_environment    = var.resource_environment
  key_vault_suffix        = random_integer.random.result
}
