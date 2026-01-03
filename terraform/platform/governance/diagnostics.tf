# ------------------------------------------------------------
# Log Analytics
# ------------------------------------------------------------


module "log_analytics" {
  source = "../../modules/log-analytics"

  # Core settings
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.governance.name
  enable_log_analytics         = true

  # Retention (default 30 days, override if needed)
  retention_in_days = 30

  tags = var.tags
}

# ------------------------------------------------------------
# Activity Log Diagnostics
# ------------------------------------------------------------

module "diagnostics_activity_log" {
  source = "../../modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = [
    "Administrative",
    "Security",
    "ServiceHealth",
    "Alert",
    "Recommendation",
    "Policy",
    "Autoscale",
    "ResourceHealth"
  ]

  metric_categories = []
}

