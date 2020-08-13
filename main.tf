terraform {
required_version = "~> 0.12.0"
}

provider "azurerm" {
features {}
version = "~> 2.0.0"
}

resource "azurerm_resource_group" "azure" {
  name     = "azureside"
  location = "UK South"
}

resource "azurerm_resource_group" "onprem" {
  name     = "customerside"
  location = "UK South"
}