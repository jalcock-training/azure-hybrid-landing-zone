output "governance_dependencies" {
  value = []
}

output "log_analytics_workspace_id" {
  value = module.log_analytics.log_analytics_workspace_id
}

output "diag_storage_account_id" {
  value = module.diag_storage.storage_account_id
}

output "diag_storage_account_name" {
  value = module.diag_storage.storage_account_name
}

