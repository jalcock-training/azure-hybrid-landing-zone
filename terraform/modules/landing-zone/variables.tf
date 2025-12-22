# The ID of the tenant root management group.
# Azure resolves this automatically when set to all zeros.
variable "root_management_group_id" {
  description = "The ID of the root management group. Defaults to '00000000-0000-0000-0000-000000000000' which Azure resolves automatically."
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

# Prefix applied to all management group names (e.g., "ahlz").
variable "prefix" {
  description = "Prefix used for naming management groups."
  type        = string
}

# Display name for the Platform subscription.
variable "platform_subscription_name" {
  description = "Display name for the platform subscription."
  type        = string
}

# Display name for the Workload subscription.
variable "workload_subscription_name" {
  description = "Display name for the workload subscription."
  type        = string
}

# Billing scope used when creating subscriptions.
# Format example:
# /providers/Microsoft.Billing/billingAccounts/12345:67890
variable "billing_scope" {
  description = "The billing scope used when creating subscriptions (e.g. /providers/Microsoft.Billing/billingAccounts/xxxx:yyyy)."
  type        = string
}

