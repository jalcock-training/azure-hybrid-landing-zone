variable "root_management_group_id" {
  description = "The ID of the root management group. Defaults to '00000000-0000-0000-0000-000000000000' which Azure resolves automatically."
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "prefix" {
  description = "Prefix used for naming management groups."
  type        = string
}

variable "platform_subscription_name" {
  description = "Display name for the platform subscription."
  type        = string
}

variable "workload_subscription_name" {
  description = "Display name for the workload subscription."
  type        = string
}

variable "billing_scope" {
  description = "The billing scope used when creating subscriptions (e.g. /providers/Microsoft.Billing/billingAccounts/xxxx:yyyy)."
  type        = string
}

