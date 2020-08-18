resource "azurerm_network_interface" "physicalvm" {
  name                = "physicalvm-nic"
  location            = azurerm_resource_group.onprem.location
  resource_group_name = azurerm_resource_group.onprem.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.onprem.id
    private_ip_address_allocation = "Dynamic"
    
  }
}

resource "azurerm_windows_virtual_machine" "physicalvm" {
  name                = "physicalvm-vm"
  resource_group_name = azurerm_resource_group.onprem.name
  location            = azurerm_resource_group.onprem.location
  size                = "Standard_D2_v2"
  admin_username      = var.vm_admin_user
  admin_password      = var.vm_admin_pwd
  network_interface_ids = [
    azurerm_network_interface.physicalvm.id
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
}
