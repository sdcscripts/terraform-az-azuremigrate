resource "azurerm_network_interface" "hyperv" {
  name                = "hyperv-nic"
  location            = azurerm_resource_group.onprem.location
  resource_group_name = azurerm_resource_group.onprem.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.onprem.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hyperv.id
    
  }
}

resource "azurerm_public_ip" "hyperv" {
  name                = "hypervpublicip"
  location            = azurerm_resource_group.onprem.location
  resource_group_name = azurerm_resource_group.onprem.name
  allocation_method   = "Static"
  domain_name_label   = "hyperv-${random_id.randomIdVM.hex}"
}

resource "random_id" "randomIdVM" {
    
        byte_length = 4
}
 
resource "azurerm_windows_virtual_machine" "hyperv" {
  name                = "hyperv-vm"
  resource_group_name = azurerm_resource_group.onprem.name
  location            = azurerm_resource_group.onprem.location
  size                = "Standard_D4s_v3"
  admin_username      = var.vm_admin_user
  admin_password      = var.vm_admin_pwd
  network_interface_ids = [
    azurerm_network_interface.hyperv.id
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

# After follow hyper-v set up, download VHD eval and optionally set up internet on the nested VM if req. https://github.com/charlieding/Virtualization-Documentation/tree/live/hyperv-tools/Nested
