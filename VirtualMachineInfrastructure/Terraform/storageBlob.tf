resource "azurerm_storage_blob" "sb" {
  for_each = fileset("${path.module}/Scripts/Extensions", "*")

  name                   = each.key
  storage_account_name   = data.azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc_extensions.name
  type                   = "Block"
  source                 = "${path.module}/Scripts/Extensions/${each.key}"
}

resource "azurerm_storage_blob" "sb_setup" {
  name                   = local.download_and_run_schedule_script_name
  storage_account_name   = data.azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc_extension_setup.name
  type                   = "Block"
  source                 = "${path.module}/Scripts/${local.download_and_run_schedule_script_name}"
}
