# Region where the hub network will be deployed
variable "location" {
  description = "Azure region for the hub virtual network."
  type        = string
}

# Name of the hub VNet (e.g., vnet-hub)
variable "hub_vnet_name" {
  description = "Name of the hub virtual network."
  type        = string
}

# Address space for the hub VNet (e.g., 10.0.0.0/16)
variable "hub_vnet_address_space" {
  description = "Address space for the hub virtual network."
  type        = list(string)
}

# Address prefix for the GatewaySubnet (must be a /27 or larger)
variable "subnet_gateway_prefix" {
  description = "Address prefix for the GatewaySubnet."
  type        = string
}

# Address prefix for the AzureFirewallSubnet (must be /26 or larger)
variable "subnet_firewall_prefix" {
  description = "Address prefix for the AzureFirewallSubnet."
  type        = string
}

# Address prefix for the shared-services subnet
variable "subnet_shared_services_prefix" {
  description = "Address prefix for the shared-services subnet."
  type        = string
}

# Address prefix for the aci subnet
variable "subnet_aci_prefix" {
  description = "Address prefix for the aci subnet."
  type        = string
}

# Address prefix for the private-endpoints subnet
variable "subnet_private_endpoints_prefix" {
  description = "Address prefix for the aci subnet."
  type        = string
}

# Resource group where the hub network will be created
variable "resource_group_name" {
  description = "Name of the resource group for the hub network."
  type        = string
}

# Standard tags applied to all hub network resources
variable "tags" {
  description = "A map of tags to apply to hub network resources."
  type        = map(string)
}

variable "governance_dependencies" {
  type = list(any)
}

variable "prefix" {
  description = "Prefix used for naming hub network resources."
  type        = string
}

