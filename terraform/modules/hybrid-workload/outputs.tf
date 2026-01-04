output "tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "client_id" {
  value = azuread_application.sp.application_id
}

output "client_secret" {
  value     = azuread_application_password.sp_secret.value
  sensitive = true
}

output "cert_secret_name" {
  value = azurerm_key_vault_secret.cert.name
}

output "key_secret_name" {
  value = azurerm_key_vault_secret.key.name
}

output "storage_account_name" {
  value = var.storage_account_name
}

output "storage_container_name" {
  value = var.storage_container_name
}

