# Root module outputs for the Azure Hybrid Landing Zone.
# Additional outputs will be added as modules are implemented.

output "subscription_id" {
  description = "The Azure subscription ID used for all deployments."
  value       = var.subscription_id
}
