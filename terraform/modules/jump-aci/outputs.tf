output "container_group_id" {
  description = "The ID of the ACI jump container group."
  value       = azurerm_container_group.jump.id
}

output "container_group_name" {
  description = "The name of the ACI jump container group."
  value       = azurerm_container_group.jump.name
}

output "container_group_location" {
  description = "The location of the ACI jump container group."
  value       = azurerm_container_group.jump.location
}
