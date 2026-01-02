resource "azurerm_resource_group" "shared_services" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

