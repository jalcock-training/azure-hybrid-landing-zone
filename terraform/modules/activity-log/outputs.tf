# Output the diagnostic setting ID (useful for debugging or chaining)
output "activity_log_diagnostic_setting_id" {
  value       = azurerm_monitor_diagnostic_setting.activity_log[*].id
  description = "ID of the Activity Log diagnostic setting."
}
