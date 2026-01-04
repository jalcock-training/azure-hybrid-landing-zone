output "id" {
  description = "Libvirt domain ID"
  value       = libvirt_domain.vm.id
}

output "name" {
  description = "VM name"
  value       = libvirt_domain.vm.name
}

output "ip_addresses" {
  description = "Reported IP addresses (if available)"
  value       = libvirt_domain.vm.network_interface[0].addresses
}

