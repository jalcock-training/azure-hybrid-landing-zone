# ------------------------------------------------------------
# Hub Network Diagnostics
# ------------------------------------------------------------

module "diagnostics_hub_vnet" {
  source = "../../modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.hub_network.hub_vnet_id
  log_analytics_workspace_id = data.terraform_remote_state.governance.outputs.log_analytics_workspace_id

  log_categories = []

  metric_categories = ["AllMetrics"]
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
  log_analytics_workspace_id = data.terraform_remote_state.governance.outputs.log_analytics_workspace_id

  log_categories = [
    "NetworkSecurityGroupEvent",
    "NetworkSecurityGroupRuleCounter"
  ]

  metric_categories = []
}

