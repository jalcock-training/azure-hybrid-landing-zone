output "id" {
  description = "Libvirt domain ID"
  value       = libvirt_domain.vm.id
}

output "name" {
  description = "VM name"
  value       = libvirt_domain.vm.name
}

