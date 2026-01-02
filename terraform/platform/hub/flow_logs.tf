# ------------------------------------------------------------
# NSG Flow Logs
# ------------------------------------------------------------

module "nsg_flow_logs" {
  count = var.enable_nsg_flow_logs ? 1 : 0

  source = "../../modules/nsg-flow-logs"

  prefix                     = var.prefix
  enable_nsg_flow_logs       = var.enable_nsg_flow_logs

  # Only shared-services NSG exists today
  nsg_ids                    = module.hub_network.nsg_ids

  # Hub-owned diagnostics storage
  storage_account_id         = module.diag_storage.storage_account_id

  # Hub-owned Log Analytics workspace
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  tags = var.tags
}
