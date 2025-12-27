################################################
# Feature Toggles
################################################

variable "enable_storage" {
  description = "Enable deployment of the Storage Account and related resources."
  type        = bool
  default     = false
}

variable "enable_storage_private_endpoints" {
  description = "Enable private endpoints and DNS links for the Storage Account."
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
  description = "Resource group where the Storage Account will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all Storage resources."
  type        = map(string)
  default     = {}
}

################################################
# Network + Access Control
################################################

variable "allowed_subnet_ids" {
  description = "List of subnet IDs allowed to access the Storage Account."
  type        = list(string)
  default     = []
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID where private endpoints will be deployed."
  type        = string
}

variable "hub_vnet_id" {
  description = "ID of the hub virtual network for DNS zone linking."
  type        = string
}

################################################
# DNS Zones
################################################

variable "private_dns_zone_blob_name" {
  description = "Name of the Private DNS Zone for blob storage."
  type        = string
}

variable "private_dns_zone_file_name" {
  description = "Name of the Private DNS Zone for file storage."
  type        = string
}

