resource "azurerm_virtual_machine_extension" "vme" {
  name                 = "vm-extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings           = <<SETTINGS
    {
          "fileUris": ["${azurerm_storage_blob.sb_setup.url}"]
    }
  SETTINGS
  protected_settings = <<PROTECTED_SETTINGS
        {
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file ${local.download_and_run_schedule_script_name} -StorageAccountName ${data.azurerm_storage_account.sa.name} -ContainerName ${azurerm_storage_container.sc_extensions.name} -StorageAccountKey ${data.azurerm_storage_account.sa.primary_access_key}",
          "storageAccountName": "${data.azurerm_storage_account.sa.name}",
          "storageAccountKey": "${data.azurerm_storage_account.sa.primary_access_key}"
        }
    PROTECTED_SETTINGS  

}
