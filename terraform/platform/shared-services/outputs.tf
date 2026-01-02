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

