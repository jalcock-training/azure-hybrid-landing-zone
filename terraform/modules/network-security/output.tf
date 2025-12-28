# ------------------------------------------------------------
# Network Security Outputs
# ------------------------------------------------------------

# Output all NSG IDs
output "nsg_ids" {
  description = "A map of subnet names to their associated NSG IDs."
  value = {
    for subnet_name, nsg in azurerm_network_security_group.nsg :
    subnet_name => nsg.id
  }
}

# Output all route table IDs
output "route_table_ids" {
  description = "A map of subnet names to their associated route table IDs."
  value = {
    for subnet_name, rt in azurerm_route_table.rt :
    subnet_name => rt.id
  }
}
