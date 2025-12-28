# Map of NSG Flow Log resource IDs, keyed by NSG name
output "nsg_flow_log_ids" {
  description = "Map of NSG Flow Log resource IDs, keyed by NSG name."
  value       = { for k, v in azurerm_network_watcher_flow_log.flow_logs : k => v.id }
}
