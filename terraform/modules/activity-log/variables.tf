# Prefix for naming resources
variable "prefix" {
  type        = string
  description = "Prefix used for naming Activity Log export resources."
}

# Subscription ID for the target subscription
variable "subscription_id" {
  type        = string
  description = "Subscription ID where Activity Logs will be exported from."
}

# Log Analytics workspace ID
variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace ID to receive Activity Logs."
}

# Feature toggle for enabling Activity Log export
variable "enable_activity_log_export" {
  type        = bool
  description = "Enable or disable Activity Log export."
  default     = true
}
