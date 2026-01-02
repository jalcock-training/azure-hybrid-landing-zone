# ------------------------------------------------------------
# Hub Diagnostics Storage Account
# ------------------------------------------------------------

module "diag_storage" {
  source = "../../modules/diag-storage"

  prefix              = var.prefix
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

