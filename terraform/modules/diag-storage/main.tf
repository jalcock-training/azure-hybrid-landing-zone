# ------------------------------------------------------------
# Diagnostics Storage Account (Hub-owned)
# ------------------------------------------------------------

resource "azurerm_storage_account" "diag" {
  name                     = "${var.prefix}diag${random_string.suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Required for NSG Flow Logs + Diagnostic Settings
  allow_blob_public_access = false
  min_tls_version          = "TLS1_2"

  tags = var.tags
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

# Optional but recommended: container for flow logs
resource "azurerm_storage_container" "flowlogs" {
  name                  = "flowlogs"
  storage_account_name  = azurerm_storage_account.diag.name
  container_access_type = "private"
}

