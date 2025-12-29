# ------------------------------------------------------------
# Activity Log
# ------------------------------------------------------------

module "activity_log" {
  source = "../modules/activity-log"

  prefix                       = var.prefix
  subscription_id              = var.subscription_id
  log_analytics_workspace_id   = module.log_analytics.log_analytics_workspace_id
  enable_activity_log_export   = var.enable_activity_log_export

  # Make sure modules are built in the correct order
  depends_on = [
    module.log_analytics,
  ]
}
