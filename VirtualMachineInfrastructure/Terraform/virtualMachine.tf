resource "azurerm_windows_virtual_machine" "vm" {
  name                = "${var.resource_prefix}-vm-${var.resource_environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  #size                = "Standard_B1s"  # vCPU : 1 RAM: 1 DataDisks: 2 MaxIOPs:  320 TempStorage:  4 Price: ~$11.50
  #size                = "Standard_B1ms" # vCPU : 1 RAM: 2 DataDisks: 2 MaxIOPs:  640 TempStorage:  4 Price: ~$20.15
  #size                = "Standard_B2s"  # vCPU : 2 RAM: 4 DataDisks: 4 MaxIOPs: 1280 TempStorage:  8 Price: ~$40.30
  size                = "Standard_B2ms" # vCPU : 2 RAM: 8 DataDisks: 4 MaxIOPs: 1920 TempStorage: 16 Price: ~$74.46
  admin_username      = local.shared_vm_admin_username
  admin_password      = random_password.vm_password.result
  network_interface_ids = [
    data.azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  winrm_listener {
    protocol        = "Https"
    certificate_url = azurerm_key_vault_certificate.kvc.secret_id
  }

  secret {
    certificate {
      store = "My"
      url   = azurerm_key_vault_certificate.kvc.secret_id
    }
    key_vault_id = azurerm_key_vault_certificate.kvc.key_vault_id
  }

}
