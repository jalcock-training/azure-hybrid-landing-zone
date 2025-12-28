# -------------------------------------------------------------------
# Activity Log Export
# Sends subscription-level Activity Logs to Log Analytics.
# This captures control-plane operations such as RBAC changes,
# resource creation/deletion, policy assignments, and admin actions.
# -------------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  count = var.enable_activity_log_export ? 1 : 0

  name               = "${var.prefix}-activity-log"
  target_resource_id = "/subscriptions/${var.subscription_id}"

  # Send all supported Activity Log categories to Log Analytics
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "Administrative"
    enabled  = true
  }

  log {
    category = "Security"
    enabled  = true
  }

  log {
    category = "ServiceHealth"
    enabled  = true
  }

  log {
    category = "Alert"
    enabled  = true
  }

  log {
    category = "Recommendation"
    enabled  = true
  }

  log {
    category = "Policy"
    enabled  = true
  }

  log {
    category = "ResourceHealth"
    enabled  = true
  }
}

