output "diagnostic_setting_id" {
  description = "ID of the diagnostic setting (if deployed)."
  value       = try(azurerm_monitor_diagnostic_setting.diagnostic[0].id, null)
}
