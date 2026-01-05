# -------------------------------------------------------------------
# Create the pre-requisite keys for hybrid02
# -------------------------------------------------------------------

# Generate the key
resource "tls_private_key" "hybrid02_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Generate the cert
resource "tls_self_signed_cert" "hybrid02_cert" {
  private_key_pem = tls_private_key.hybrid02_key.private_key_pem

  subject {
    common_name  = "ahlz-hybrid02-endpoint"
    organization = "Azure Hybrid Landing Zone"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth"
  ]
}

# Upload to Key Vault
resource "azurerm_key_vault_secret" "cert" {
  name         = "hybrid02-cert"
  value        = tls_self_signed_cert.hybrid02_cert.cert_pem
  key_vault_id = data.azurerm_key_vault.shared.id
}

resource "azurerm_key_vault_secret" "key" {
  name         = "hybrid02-key"
  value        = tls_private_key.hybrid02_key.private_key_pem
  key_vault_id = data.azurerm_key_vault.shared.id
}

