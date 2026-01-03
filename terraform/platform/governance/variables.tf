variable "subscription_id" {
  description = "Subscription ID where governance policies and platform RG will be applied."
  type        = string
}

variable "location" {
  description = "Azure region for the platform resource group."
  type        = string
}

variable "tags" {
  description = "Tags to apply to governance-created resources."
  type        = map(string)
}

variable "prefix" {
  description = "Prefix for governance resources."
  type        = string
}

