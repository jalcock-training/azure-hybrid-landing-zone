output "private_dns_zone_storage_blob_name" {
  value = module.shared_services.private_dns_zone_storage_blob_name
}

output "private_dns_zone_storage_file_name" {
  value = module.shared_services.private_dns_zone_storage_file_name
}

output "key_vault_id" {
  value = module.shared_services.key_vault_id
}

output "storage_account_id" {
  value = module.storage.storage_account_id
}

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "key_vault_name" {
  value = module.shared_services.key_vault_name
}

output "key_vault_private_dns_zone_id" {
  value = module.shared_services.key_vault_private_dns_zone_id
}

output "private_dns_resource_group_name" {
  value = var.resource_group_name
}

output "storage_blob_private_dns_zone_id" {
  value = module.shared_services.private_dns_zone_storage_blob_id
}

output "storage_file_private_dns_zone_id" {
  value = module.shared_services.private_dns_zone_storage_file_id
}

output "shared_services_resource_group_name" {
  value = azurerm_resource_group.shared_services.name
}

