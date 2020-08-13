

resource "azurerm_virtual_network" "azure" {
  name                = "azurevnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.azure.location
  resource_group_name = azurerm_resource_group.azure.name
}

resource "azurerm_virtual_network" "onprem" {
  name                = "onpremvnet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.onprem.location
  resource_group_name = azurerm_resource_group.onprem.name
}
 
resource "azurerm_subnet" "prod" {
  name                 = "prodsubnet"
  resource_group_name  = azurerm_resource_group.azure.name
  virtual_network_name = azurerm_virtual_network.azure.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "isolated" {
  name                 = "isolatedsubnet"
  resource_group_name  = azurerm_resource_group.azure.name
  virtual_network_name = azurerm_virtual_network.azure.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_subnet" "onprem" {
  name                 = "onpremsubnet"
  resource_group_name  = azurerm_resource_group.onprem.name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefix       = "192.168.1.0/24"
}
