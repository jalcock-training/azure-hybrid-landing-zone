# Expose the Platform management group ID for downstream modules
output "platform_management_group_id" {
  value = azurerm_management_group.platform.id
}

# Expose the Landing Zones management group ID for downstream modules
output "landingzones_management_group_id" {
  value = azurerm_management_group.landingzones.id
}

# Subscription ID used by networking, shared services, and policy modules
output "platform_subscription_id" {
  value = azapi_resource.platform_subscription.output["subscriptionId"]
}

# Subscription ID for workload deployments and application landing zones
output "workload_subscription_id" {
  value = azapi_resource.workload_subscription.output["subscriptionId"]
}

