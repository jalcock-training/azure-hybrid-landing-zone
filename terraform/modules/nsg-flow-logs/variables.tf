# Prefix used for naming NSG Flow Log resources
variable "prefix" {
  description = "Prefix used for naming NSG Flow Log resources."
  type        = string
}

# Feature toggle to enable or disable NSG Flow Logs v2
variable "enable_nsg_flow_logs" {
  description = "Feature toggle to enable or disable NSG Flow Logs v2."
  type        = bool
  default     = true
}

# List of NSG IDs to enable Flow Logs for (shared-services now, app/data later)
variable "nsg_ids" {
  description = "Map of NSG names to their resource IDs."
  type        = map(string)
}

# Storage account ID used to store NSG Flow Logs
variable "storage_account_id" {
  description = "Storage account ID used to store NSG Flow Logs."
  type        = string
}

# Log Analytics workspace ID for Traffic Analytics
variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for Traffic Analytics."
  type        = string
}

