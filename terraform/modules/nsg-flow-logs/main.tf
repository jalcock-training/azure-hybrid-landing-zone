# -------------------------------------------------------------------
# NSG Flow Logs Module (AzureRM v4)
# Enables NSG Flow Logs using Azure Monitor Diagnostic Settings.
# Applies to all NSG IDs passed in via nsg_ids.
# Sends flow logs to both Storage and Log Analytics.
# Network Watcher resources are no longer required in v4.
# -------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "nsg_flow_logs" {
  for_each = var.enable_nsg_flow_logs ? var.nsg_ids : {}

  name                       = "${var.prefix}-nsgflow-${each.key}"
  target_resource_id         = each.value

  storage_account_id         = var.storage_account_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "NetworkSecurityGroupFlowEvent"
  }

}

