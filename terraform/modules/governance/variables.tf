# Location for the platform resource group
variable "location" {
  description = "Azure region for the platform resource group."
  type        = string
}

# Name of the platform resource group
variable "platform_resource_group_name" {
  description = "Name of the resource group that hosts shared services."
  type        = string
}

# Subscription ID for policy assignments
variable "subscription_id" {
  description = "The subscription ID where governance will be applied."
  type        = string
}

# Standard tags applied at the subscription level
variable "tags" {
  description = "A map of tags to apply to the subscription and resource group."
  type        = map(string)
}
