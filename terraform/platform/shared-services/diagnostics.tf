# ------------------------------------------------------------
# Key Vault Diagnostics
# ------------------------------------------------------------

module "diagnostics_key_vault" {
  source = "../../modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.shared_services.key_vault_id
  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id


  log_categories    = ["AuditEvent"]
  metric_categories = ["AllMetrics"]
}

# ------------------------------------------------------------
# Storage Diagnostics
# ------------------------------------------------------------

module "diagnostics_storage" {
  source = "../../modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.storage.storage_account_id
  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id

  log_categories = []

  metric_categories = [
    "Capacity",
    "Transaction",
  ]

}

