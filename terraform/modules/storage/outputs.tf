################################################
# Storage Account Outputs
################################################

output "storage_account_id" {
  description = "ID of the Storage Account (if deployed)."
  value       = try(azurerm_storage_account.storage_account[0].id, null)
}

output "storage_account_name" {
  description = "Name of the Storage Account (if deployed)."
  value       = try(azurerm_storage_account.storage_account[0].name, null)
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary Blob endpoint of the Storage Account (if deployed)."
  value       = try(azurerm_storage_account.storage_account[0].primary_blob_endpoint, null)
}

output "storage_account_primary_file_endpoint" {
  description = "Primary File endpoint of the Storage Account (if deployed)."
  value       = try(azurerm_storage_account.storage_account[0].primary_file_endpoint, null)
}

################################################
# Private Endpoint Outputs
################################################

output "private_endpoint_blob_id" {
  description = "ID of the Blob private endpoint (if deployed)."
  value       = try(azurerm_private_endpoint.private_endpoint_blob[0].id, null)
}

output "private_endpoint_file_id" {
  description = "ID of the File private endpoint (if deployed)."
  value       = try(azurerm_private_endpoint.private_endpoint_file[0].id, null)
}
