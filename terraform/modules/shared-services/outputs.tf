################################################
# Log Analytics outputs
################################################

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace (if deployed)."
  value       = try(azurerm_log_analytics_workspace.log_analytics_workspace[0].id, null)
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace (if deployed)."
  value       = try(azurerm_log_analytics_workspace.log_analytics_workspace[0].name, null)
}

################################################
# Key Vault outputs
################################################

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
