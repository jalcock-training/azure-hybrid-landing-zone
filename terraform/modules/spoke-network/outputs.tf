# Output the spoke VNet ID
output "spoke_vnet_id" {
  description = "The ID of the spoke virtual network."
  value       = azurerm_virtual_network.spoke.id
}

# Output the spoke VNet name
output "spoke_vnet_name" {
  description = "The name of the spoke virtual network."
  value       = azurerm_virtual_network.spoke.name
}

# Output the spoke VNet address space
output "spoke_vnet_address_space" {
  description = "The address space of the spoke virtual network."
  value       = azurerm_virtual_network.spoke.address_space
}

# Output subnet IDs for future modules (private endpoints, NSGs, etc.)
output "subnet_ids" {
  description = "A map of subnet names to their IDs."
  value = {
    app              = azurerm_subnet.app.id
    data             = azurerm_subnet.data.id
    private_endpoints = azurerm_subnet.private_endpoints.id
  }
}
