output "vm_id" {
  description = "The ID of the jumphost VM."
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  description = "The name of the jumphost VM."
  value       = azurerm_linux_virtual_machine.vm.name
}

output "private_ip" {
  description = "The private IP address of the jumphost VM."
  value       = azurerm_network_interface.nic.ip_configuration[0].private_ip_address
}

output "nic_id" {
  description = "The ID of the jumphost VM NIC."
  value       = azurerm_network_interface.nic.id
}

output "nsg_id" {
  description = "The ID of the NSG applied to the jumphost NIC."
  value       = azurerm_network_security_group.nsg.id
}
