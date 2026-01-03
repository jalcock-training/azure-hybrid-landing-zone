variable "resource_group_name" {
  description = "Resource group for spoke01 resources."
  type        = string
}

variable "location" {
  description = "Azure region for spoke01 resources."
  type        = string
}

variable "prefix" {
  description = "Prefix for spok01 names."
  type        = string
}

variable "tags" {
  description = "Tags to apply to spoke01 resources."
  type        = map(string)
}

variable "subscription_id" {
  type = string
}
