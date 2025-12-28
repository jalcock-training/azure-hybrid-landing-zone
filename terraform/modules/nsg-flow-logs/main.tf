# -------------------------------------------------------------------
# NSG Flow Logs v2 Module
# Creates Flow Logs for any NSG IDs passed in.
# Supports Flow Analytics (Traffic Analytics) to Log Analytics.
# -------------------------------------------------------------------

resource "azurerm_network_watcher_flow_log" "flow_logs" {
  for_each = var.enable_nsg_flow_logs ? toset(var.nsg_ids) : []

  name                 = "${var.prefix}-flowlog-${each.key}"
  network_watcher_name = var.network_watcher_name
  resource_group_name  = var.network_watcher_rg
  target_resource_id   = each.value

  enabled = true

  storage_account_id = var.storage_account_id

  # Flow Logs v2 with Traffic Analytics
  flow_analytics_configuration {
    enabled       = true
    workspace_id  = var.log_analytics_workspace_id
    traffic_analytics_interval = 10
  }

  retention_policy {
    enabled = false
  }
}
