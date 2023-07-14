resource "azurerm_container_app_environment" "cae" {
  name                       = "${var.resource_prefix}-cae-${var.resource_suffix}"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}