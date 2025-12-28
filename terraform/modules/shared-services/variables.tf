################################################
# Core settings
################################################

variable "location" {
  description = "Azure region where shared services will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for shared services."
  type        = string
}

variable "prefix" {
  description = "Prefix used for naming shared service resources (e.g., ahlz-dev)."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all shared service resources."
  type        = map(string)
}

################################################
# Feature toggles
################################################

variable "enable_log_analytics" {
  description = "Whether to deploy a Log Analytics workspace."
  type        = bool
  default     = false
}

variable "enable_key_vault" {
  description = "Whether to deploy a secure Azure Key Vault."
  type        = bool
  default     = false
}

variable "enable_key_vault_private_endpoint" {
  description = "Whether to create a private endpoint for Key Vault."
  type        = bool
  default     = false
}

variable "enable_storage_private_endpoints" {
  description = "Enable private DNS zones for Storage private endpoints."
  type        = bool
  default     = false
}

################################################
# Log Analytics configuration
################################################

variable "log_analytics_sku" {
  description = "SKU for Log Analytics workspace."
  type        = string
  default     = "PerGB2018"
}

variable "log_analytics_retention_days" {
  description = "Retention period (in days) for Log Analytics."
  type        = number
  default     = 30
}

################################################
# Key Vault networking
################################################

variable "key_vault_allowed_subnet_ids" {
  description = "List of subnet IDs that are allowed to access Key Vault (via VNet integration)."
  type        = list(string)
  default     = []
}

variable "key_vault_private_endpoint_subnet_id" {
  description = "Subnet ID used for the Key Vault private endpoint when enabled."
  type        = string
  default     = ""
}

variable "hub_vnet_id" {
  description = "Hub VNet ID for DNS zone linking."
  type        = string
}


################################################
# Storage networking
################################################

variable "storage_private_endpoint_subnet_id" {
  description = "Subnet ID for Storage private endpoints."
  type        = string
}

variable "storage_account_id" {
  description = "ID of the Storage Account for private endpoints."
  type        = string
}

