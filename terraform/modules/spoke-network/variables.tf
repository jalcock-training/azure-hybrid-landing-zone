# Region where the spoke network will be deployed
variable "location" {
  description = "Azure region for the spoke virtual network."
  type        = string
}

# Name of the spoke VNet (e.g., vnet-spoke-01)
variable "spoke_vnet_name" {
  description = "Name of the spoke virtual network."
  type        = string
}

# Address space for the spoke VNet (e.g., 10.1.0.0/16)
variable "spoke_vnet_address_space" {
  description = "Address space for the spoke virtual network."
  type        = list(string)
}

# Subnet prefixes for the spoke
variable "subnet_app_prefix" {
  description = "Address prefix for the app subnet."
  type        = string
}

variable "subnet_data_prefix" {
  description = "Address prefix for the data subnet."
  type        = string
}

variable "subnet_private_endpoints_prefix" {
  description = "Address prefix for the private-endpoints subnet."
  type        = string
}

# Resource group where the spoke VNet will be created
variable "resource_group_name" {
  description = "Name of the resource group for the spoke network."
  type        = string
}

# Hub VNet ID (needed for peering)
variable "hub_vnet_id" {
  description = "The ID of the hub virtual network for peering."
  type        = string
}

# Hub VNet name (needed for peering)
variable "hub_vnet_name" {
  description = "The name of the hub virtual network for peering."
  type        = string
}

# Tags applied to all spoke resources
variable "tags" {
  description = "A map of tags to apply to spoke network resources."
  type        = map(string)
}
