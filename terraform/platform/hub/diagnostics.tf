# ------------------------------------------------------------
# Log Analytics
# ------------------------------------------------------------


module "log_analytics" {
  source = "../../modules/log-analytics"

  # Core settings
  prefix              = var.prefix
  location            = var.location
  resource_group_name = var.resource_group_name
  enable_log_analytics         = true

  # Retention (default 30 days, override if needed)
  retention_in_days = 30

  tags = var.tags
}

# ------------------------------------------------------------
# Hub Network Diagnostics
# ------------------------------------------------------------

module "diagnostics_hub_vnet" {
  source = "../../modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.hub_network.hub_vnet_id
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = []

  metric_categories = ["AllMetrics"]
}

# ------------------------------------------------------------
# NSG Diagnostics
# ------------------------------------------------------------

module "diagnostics_nsg_shared_services" {
  source = "../../modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.hub_network.nsg_ids["shared_services"]
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = [
    "NetworkSecurityGroupEvent",
    "NetworkSecurityGroupRuleCounter"
  ]

  metric_categories = []
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

# ------------------------------------------------------------
# Diagnostics for NSGs
# ------------------------------------------------------------

module "diagnostics_nsg_all" {
  source = "../../modules/diagnostic_settings"

  for_each = module.hub_network.nsg_ids

  enable_diagnostics = true
  prefix             = "${var.prefix}-${each.key}"

  target_resource_id         = each.value
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = [
    "NetworkSecurityGroupEvent",
    "NetworkSecurityGroupRuleCounter"
  ]

  metric_categories = []
}
