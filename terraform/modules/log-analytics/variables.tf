################################################
# Feature Toggles
################################################

variable "enable_log_analytics" {
  description = "Enable deployment of the Log Analytics Workspace."
  type        = bool
  default     = false
}

################################################
# Core Settings
################################################

variable "prefix" {
  description = "Prefix used for naming all resources."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the Log Analytics Workspace will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Log Analytics Workspace."
  type        = map(string)
  default     = {}
}

################################################
# Retention
################################################

variable "retention_in_days" {
  description = "Number of days to retain logs in the Log Analytics Workspace. Up to 31 days is free."
  type        = number
  default     = 30
}
