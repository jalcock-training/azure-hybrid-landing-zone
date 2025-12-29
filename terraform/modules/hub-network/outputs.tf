# Output the hub VNet ID
output "hub_vnet_id" {
  description = "The ID of the hub virtual network."
  value       = azurerm_virtual_network.hub.id
}

# Output the hub VNet name
output "hub_vnet_name" {
  description = "The name of the hub virtual network."
  value       = azurerm_virtual_network.hub.name
}

# Output the hub VNet address space
output "hub_vnet_address_space" {
  description = "The address space of the hub virtual network."
  value       = azurerm_virtual_network.hub.address_space
}

# Output subnet IDs for future modules (firewall, gateway, shared services)
output "subnet_ids" {
  description = "A map of subnet names to their IDs."
  value = {
    gateway         = azurerm_subnet.gateway.id
    firewall        = azurerm_subnet.firewall.id
    shared_services = azurerm_subnet.shared_services.id
    aci             = azurerm_subnet.aci.id
    jumphost        = azurerm_subnet.jumphost.id
  }
}

# Output the NSG IDs
output "nsg_ids" {
  value = {
    shared_services = azurerm_network_security_group.shared_services.id
  }
}

output "private_endpoints_subnet_id" {
  description = "The ID of the private-endpoints subnet."
  value       = azurerm_subnet.private_endpoints.id
}

output "shared_services_subnet_cidr" {
  description = "The CIDR prefix of the shared-services subnet."
  value       = azurerm_subnet.shared_services.address_prefixes
}
