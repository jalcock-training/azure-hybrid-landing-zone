output "platform_resource_group_name" {
  description = "The name of the platform resource group."
  value       = azurerm_resource_group.platform.name
}

output "platform_resource_group_id" {
  description = "The ID of the platform resource group."
  value       = azurerm_resource_group.platform.id
}
