# ------------------------------------------------------------
# Module Outputs
# ------------------------------------------------------------

output "vm_private_ip" {
  value = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "vm_identity_principal_id" {
  value = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

output "certificate_name" {
  value = azurerm_key_vault_certificate.workload_cert.name
}

