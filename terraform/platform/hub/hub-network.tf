module "hub_network" {
  source = "../../modules/hub-network"

  resource_group_name = var.resource_group_name
  prefix              = var.prefix
  location            = var.location

  hub_vnet_name          = "vnet-hub"
  hub_vnet_address_space = ["10.0.0.0/16"]

  subnet_gateway_prefix           = "10.0.0.0/27"
  subnet_firewall_prefix          = "10.0.0.64/26"
  subnet_shared_services_prefix   = "10.0.1.0/24"
  subnet_aci_prefix               = "10.0.2.0/24"
  subnet_private_endpoints_prefix = "10.0.3.0/24"
  subnet_jumphost_prefix          = "10.0.4.0/24"

  tags = var.tags
}

