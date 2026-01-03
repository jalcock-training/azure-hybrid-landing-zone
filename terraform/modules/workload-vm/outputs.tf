# ------------------------------------------------------------
# Module Outputs
# ------------------------------------------------------------

output "workload_private_ip" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "workload_identity_principal_id" {
  value = azurerm_linux_virtual_machine.workload.identity[0].principal_id
}

output "certificate_name" {
  value = azurerm_key_vault_secret.workload_cert.name
}

output "private_key_name" {
  value = azurerm_key_vault_secret.workload_key.name
}

output "storage_container_name" {
  value = azurerm_storage_container.workload_content.name
}

