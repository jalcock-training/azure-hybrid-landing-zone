# ------------------------------------------------------------
# Subscription Outputs
# ------------------------------------------------------------

output "subscription_id" {
  description = "The Azure subscription ID used for all deployments."
  value       = var.subscription_id
}

# ------------------------------------------------------------
# Hub Network Outputs
# ------------------------------------------------------------

output "hub_vnet_id" {
  description = "ID of the hub virtual network."
  value       = module.hub_network.hub_vnet_id
}

output "hub_subnet_ids" {
  description = "Map of subnet IDs in the hub network."
  value       = module.hub_network.subnet_ids
}

# ------------------------------------------------------------
# Shared Services Outputs (Key Vault + DNS)
# ------------------------------------------------------------

output "key_vault_id" {
  description = "ID of the Key Vault (if deployed)."
  value       = try(module.shared_services.key_vault_id, null)
}

output "key_vault_name" {
  description = "Name of the Key Vault (if deployed)."
  value       = try(module.shared_services.key_vault_name, null)
}

output "key_vault_uri" {
  description = "URI of the Key Vault (if deployed)."
  value       = try(module.shared_services.key_vault_uri, null)
}

output "private_dns_zone_storage_blob_name" {
  description = "Name of the Private DNS Zone for Blob storage."
  value       = try(module.shared_services.private_dns_zone_storage_blob_name, null)
}

output "private_dns_zone_storage_file_name" {
  description = "Name of the Private DNS Zone for File storage."
  value       = try(module.shared_services.private_dns_zone_storage_file_name, null)
}

# ------------------------------------------------------------
# Storage Outputs
# ------------------------------------------------------------

output "storage_account_id" {
  description = "ID of the Storage Account (if deployed)."
  value       = try(module.storage.storage_account_id, null)
}

output "storage_account_name" {
  description = "Name of the Storage Account (if deployed)."
  value       = try(module.storage.storage_account_name, null)
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary Blob endpoint (if deployed)."
  value       = try(module.storage.storage_account_primary_blob_endpoint, null)
}

output "storage_account_primary_file_endpoint" {
  description = "Primary File endpoint (if deployed)."
  value       = try(module.storage.storage_account_primary_file_endpoint, null)
}

# ------------------------------------------------------------
# Private Endpoint Outputs
# ------------------------------------------------------------

output "storage_private_endpoint_blob_id" {
  description = "ID of the Blob private endpoint (if deployed)."
  value       = try(module.storage.private_endpoint_blob_id, null)
}

output "storage_private_endpoint_file_id" {
  description = "ID of the File private endpoint (if deployed)."
  value       = try(module.storage.private_endpoint_file_id, null)
}

# ------------------------------------------------------------
# Log Analytics Outputs
# ------------------------------------------------------------

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics Workspace (if deployed)."
  value       = try(module.log_analytics.log_analytics_workspace_id, null)
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics Workspace (if deployed)."
  value       = try(module.log_analytics.log_analytics_workspace_name, null)
}

output "log_analytics_workspace_workspace_id" {
  description = "Workspace ID (GUID) of the Log Analytics Workspace (if deployed)."
  value       = try(module.log_analytics.log_analytics_workspace_workspace_id, null)
}

output "log_analytics_workspace_primary_shared_key" {
  description = "Primary shared key of the Log Analytics Workspace (if deployed)."
  value       = try(module.log_analytics.log_analytics_workspace_primary_shared_key, null)
  sensitive   = true
}

# ------------------------------------------------------------
# Workload VM Outputs
# ------------------------------------------------------------

output "workload_vm_private_ip" {
  value = module.workload_vm.vm_private_ip
}

output "workload_vm_identity_principal_id" {
  value = module.workload_vm.vm_identity_principal_id
}

