resource "azurerm_storage_container" "sc_extensions" {
  name                 = "vm-extension-scripts"
  storage_account_name = data.azurerm_storage_account.sa.name
}

resource "azurerm_storage_container" "sc_extension_setup" {
  name                 = "vm-extension-setup"
  storage_account_name = data.azurerm_storage_account.sa.name
}
