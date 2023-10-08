resource "azurerm_windows_virtual_machine" "vm" {
  name                = "${var.resource_prefix}-vm-${var.resource_environment}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = "Standard_B1s"
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
