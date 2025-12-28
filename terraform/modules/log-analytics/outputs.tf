# ------------------------------------------------------------
# Log Analytics Workspace Outputs
# ------------------------------------------------------------

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace (if deployed)."
  value       = try(azurerm_log_analytics_workspace.log_analytics[0].id, null)
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace (if deployed)."
  value       = try(azurerm_log_analytics_workspace.log_analytics[0].name, null)
}

output "log_analytics_workspace_workspace_id" {
  description = "Workspace ID (GUID) of the Log Analytics Workspace (if deployed)."
  value       = try(azurerm_log_analytics_workspace.log_analytics[0].workspace_id, null)
}

output "log_analytics_workspace_primary_shared_key" {
  description = "Primary shared key of the Log Analytics Workspace (if deployed)."
  value       = try(azurerm_log_analytics_workspace.log_analytics[0].primary_shared_key, null)
  sensitive   = true
}

output "workspace_id" {
  description = "Resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics[0].id
}
