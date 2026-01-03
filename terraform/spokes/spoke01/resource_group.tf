resource "azurerm_resource_group" "spoke01" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

