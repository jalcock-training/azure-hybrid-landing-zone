################################################
# Log Analytics outputs
################################################

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace (if deployed)."
  value       = length(azurerm_log_analytics_workspace.this) > 0 ? azurerm_log_analytics_workspace.this[0].id : null
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace (if deployed)."
  value       = length(azurerm_log_analytics_workspace.this) > 0 ? azurerm_log_analytics_workspace.this[0].name : null
}

################################################
# Key Vault outputs
################################################

output "key_vault_id" {
  description = "ID of the Key Vault (if deployed)."
  value       = length(azurerm_key_vault.this) > 0 ? azurerm_key_vault.this[0].id : null
}

output "key_vault_name" {
  description = "Name of the Key Vault (if deployed)."
  value       = length(azurerm_key_vault.this) > 0 ? azurerm_key_vault.this[0].name : null
}

output "key_vault_uri" {
  description = "Vault URI of the Key Vault (if deployed)."
  value       = length(azurerm_key_vault.this) > 0 ? azurerm_key_vault.this[0].vault_uri : null
}
