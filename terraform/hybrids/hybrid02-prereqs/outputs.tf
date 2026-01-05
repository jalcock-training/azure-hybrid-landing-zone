output "cert_secret_name" {
  value = azurerm_key_vault_secret.cert.name
}

output "key_secret_name" {
  value = azurerm_key_vault_secret.key.name
}

