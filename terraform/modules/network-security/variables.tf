# Location for all NSGs and route tables
variable "location" {
  description = "Azure region where network security resources will be deployed."
  type        = string
}

# Resource group where NSGs and route tables will be created
variable "resource_group_name" {
  description = "Resource group for NSGs, route tables, and associations."
  type        = string
}

# Map of subnet names to subnet IDs
# Example:
# {
#   app              = "/subscriptions/.../subnets/app"
#   data             = "/subscriptions/.../subnets/data"
#   private_endpoints = "/subscriptions/.../subnets/private-endpoints"
# }
variable "subnet_map" {
  description = "A map of subnet names to their subnet IDs."
  type        = map(string)
}

# List of NSG rules to apply to each NSG
# Example:
# [
#   {
#     name                       = "allow-vnet-inbound"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "*"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "VirtualNetwork"
#     destination_address_prefix = "VirtualNetwork"
#   }
# ]
variable "nsg_rules" {
  description = "List of NSG rule objects to apply to each NSG."
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

# List of routes for route tables
# Example:
# [
#   {
#     name           = "route-to-hub"
#     address_prefix = "10.0.0.0/16"
#     next_hop_type  = "VirtualNetwork"
#   }
# ]
variable "routes" {
  description = "List of route objects for route tables."
  type = list(object({
    name           = string
    address_prefix = string
    next_hop_type  = string
  }))
}

# Tags applied to all NSGs and route tables
variable "tags" {
  description = "Tags to apply to all network security resources."
  type        = map(string)
}

