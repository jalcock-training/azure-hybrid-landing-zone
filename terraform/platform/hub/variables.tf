variable "resource_group_name" {
  description = "Resource group for hub network resources."
  type        = string
}

variable "location" {
  description = "Azure region for hub resources."
  type        = string
}

variable "prefix" {
  description = "Prefix for hub resource names."
  type        = string
}

variable "tags" {
  description = "Tags to apply to hub resources."
  type        = map(string)
}

variable "subscription_id" {}
variable "tfstate_storage_account_name" {}
variable "tfstate_resource_group_name" {}

variable "enable_nsg_flow_logs" {
  type        = bool
  description = "Enable NSG Flow Logs for hub NSGs."
  default     = false
}

