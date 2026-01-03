# ------------------------------------------------------------
# Governance Diagnostics Storage Account
# ------------------------------------------------------------

module "diag_storage" {
  source = "../../modules/diag-storage"

  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.governance.name

  tags = var.tags
}

