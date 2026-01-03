# Resource group for governance logs and diagnostics
resource "azurerm_resource_group" "governance" {
  name     = "rg-governance"
  location = var.location
  tags     = var.tags
}

