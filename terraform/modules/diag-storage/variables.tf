variable "prefix" {
  type        = string
  description = "Prefix used for naming the diagnostics storage account."
}

variable "location" {
  type        = string
  description = "Azure region for the diagnostics storage account."
}

variable "resource_group_name" {
  type        = string
  description = "Resource group where the diagnostics storage account will be created."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the diagnostics storage account."
}

