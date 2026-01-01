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

# ------------------------------------------------------------
# Variables from stage 1
# ------------------------------------------------------------
variable "platform_resource_group_name" { 
  type = string 
}

variable "spoke_vnet_name" { 
  type = string 
}

variable "spoke_subnet_ids" { 
  type = map(string) 
}

variable "key_vault_name" { 
  type = string 
}

variable "hub_subnet_ids" { 
  type = map(string) 
}

variable "storage_account_id" { 
  type = string 
}

variable "storage_account_name" { 
  type = string 
}

variable "jump_public_key" { 
  type = string 
}

variable "log_analytics_workspace_name" {
  type = string
}

variable "spoke_vnet_address_space" {
  type = list(string)
}

variable "shared_services_subnet_cidr" {
  type = list(string)
}

# Hub vnet
variable "hub_vnet_id" {
  type = string
}

# Key vault
variable "key_vault_id" {
  type = string
}

variable "key_vault_uri" {
  type = string
}

# Private DNS zones
variable "private_dns_zone_storage_blob_name" {
  type = string
}

variable "private_dns_zone_storage_file_name" {
  type = string
}

# Storage endpoints
variable "storage_account_primary_blob_endpoint" {
  type = string
}

variable "storage_account_primary_file_endpoint" {
  type = string
}

# Private endpoints
variable "storage_private_endpoint_blob_id" {
  type = string
}

variable "storage_private_endpoint_file_id" {
  type = string
}

# Log Analytics
variable "log_analytics_workspace_id" {
  type = string
}

variable "log_analytics_workspace_workspace_id" {
  type = string
}

variable "log_analytics_workspace_primary_shared_key" {
  type      = string
  sensitive = true
}

