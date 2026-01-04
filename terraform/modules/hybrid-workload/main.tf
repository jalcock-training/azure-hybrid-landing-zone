# ------------------------------------------------------------
# Hybrid workload module
#
# Prepares Azure resources for an on‑prem VM:
# - generates PEM key + certificate
# - stores both in Key Vault
# - uploads workload content to Storage
# - creates a service principal for bootstrap
# - assigns RBAC for Key Vault + Storage access
# ------------------------------------------------------------

# ------------------------------------------------------------
# Generate private key
# ------------------------------------------------------------
resource "tls_private_key" "workload_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# ------------------------------------------------------------
# Generate self‑signed certificate
# ------------------------------------------------------------
resource "tls_self_signed_cert" "workload_cert" {
  private_key_pem = tls_private_key.workload_key.private_key_pem

  subject {
    common_name  = var.common_name
    organization = "Azure Hybrid Landing Zone"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth"
  ]
}

# ------------------------------------------------------------
# Store certificate and key in Key Vault
# ------------------------------------------------------------
resource "azurerm_key_vault_secret" "cert" {
  name         = "${var.name}-cert"
  value        = tls_self_signed_cert.workload_cert.cert_pem
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "key" {
  name         = "${var.name}-key"
  value        = tls_private_key.workload_key.private_key_pem
  key_vault_id = var.key_vault_id
}

# ------------------------------------------------------------
# Upload workload content to Storage
# ------------------------------------------------------------
resource "azurerm_storage_blob" "content" {
  name                   = "index.html"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source                 = var.content_file
}

# ------------------------------------------------------------
# Create service principal for hybrid VM bootstrap
# ------------------------------------------------------------
resource "azuread_application" "sp" {
  display_name = "${var.name}-sp"
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.sp.application_id
}

resource "azuread_application_password" "sp_secret" {
  application_object_id = azuread_application.sp.id
  display_name          = "bootstrap"
}

# ------------------------------------------------------------
# RBAC assignments for Key Vault + Storage access
# ------------------------------------------------------------
resource "azurerm_role_assignment" "kv_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_service_principal.sp.id
}

resource "azurerm_role_assignment" "storage_access" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azuread_service_principal.sp.id
}

