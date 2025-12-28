# Azure subscription ID used for all deployments.
variable "subscription_id" {
  description = "The Azure subscription ID to deploy resources into."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "southeastasia"
}

variable "prefix" {
  description = "Prefix used for naming all resources."
  type        = string
  default     = "ahlz-dev"
}

variable "enable_diagnostics" {
  type        = bool
  description = "Enable or disable diagnostic settings for all resources."
  default     = true
}

variable "enable_activity_log_export" {
  type        = bool
  description = "Enable or disable Activity Log export."
  default     = true
}

variable "enable_nsg_flow_logs" {
  description = "Enable or disable NSG Flow Logs v2."
  type        = bool
  default     = true
}

