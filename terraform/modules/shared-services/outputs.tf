# ------------------------------------------------------------
# Key Vault outputs
# ------------------------------------------------------------

output "key_vault_id" {
  description = "ID of the Key Vault (if deployed)."
  value       = try(azurerm_key_vault.key_vault[0].id, null)
}

output "key_vault_name" {
  description = "Name of the Key Vault (if deployed)."
  value       = try(azurerm_key_vault.key_vault[0].name, null)
}

output "key_vault_uri" {
  description = "Vault URI of the Key Vault (if deployed)."
  value       = try(azurerm_key_vault.key_vault[0].vault_uri, null)
}

# ------------------------------------------------------------
# DNS private zone outputs
# ------------------------------------------------------------

output "private_dns_zone_storage_blob_name" {
  description = "Private DNS zone name for blob storage."
  value       = try(azurerm_private_dns_zone.private_dns_zone_storage_blob[0].name, null)
}

output "private_dns_zone_storage_file_name" {
  description = "Private DNS zone name for file storage."
  value       = try(azurerm_private_dns_zone.private_dns_zone_storage_file[0].name, null)
}
