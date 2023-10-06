module "sa" {
  source                  = "../../TerraformModules/StorageAccount"
  resource_group_location = data.azurerm_resource_group.rg.location
  resource_prefix         = var.resource_prefix
  resource_group_name     = data.azurerm_resource_group.rg.name
  resource_name           = "sa"
  resource_environment    = var.resource_environment
}