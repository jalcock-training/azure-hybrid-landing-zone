# Map of NSG Flow Log resource IDs, keyed by NSG name
output "nsg_flow_log_ids" {
  description = "Diagnostic setting IDs for NSG Flow Logs."
  value       = { for k, v in azurerm_monitor_diagnostic_setting.nsg_flow_logs : k => v.id }
}

