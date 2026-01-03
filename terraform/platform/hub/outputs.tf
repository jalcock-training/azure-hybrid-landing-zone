output "hub_vnet_id" {
  value = module.hub_network.hub_vnet_id
}

output "hub_vnet_name" {
  value = module.hub_network.hub_vnet_name
}

output "subnet_ids" {
  value = module.hub_network.subnet_ids
}

output "private_endpoints_subnet_id" {
  value = module.hub_network.private_endpoints_subnet_id
}

output "subnet_cidrs" {
  value = module.hub_network.subnet_cidrs
}

output "jumphost_identity_principal_id" {
  value = module.jumphost_vm.identity_principal_id
}

output "hub_resource_group_name" {
  value = azurerm_resource_group.hub.name
}

output "jump_public_key" {
  value = tls_private_key.jump.public_key_openssh
}

output "nsg_ids" {
  value = module.hub_network_security.nsg_ids
}

