variable "enable_diagnostics" {
  description = "Enable diagnostic settings for the target resource."
  type        = bool
  default     = false
}

variable "prefix" {
  description = "Prefix for naming diagnostic settings."
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the Azure resource to apply diagnostic settings to."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace to send logs to."
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable for the resource."
  type        = list(string)
  default     = []
}

variable "metric_categories" {
  description = "List of metric categories to enable for the resource."
  type        = list(string)
  default     = []
}
