# -------------------------------------------------------------------
# Reference the hub_network module
# -------------------------------------------------------------------

module "hub_network" {
  source = "../modules/hub-network"

  resource_group_name = module.governance.platform_resource_group_name
  prefix              = var.prefix
  location            = var.location

  governance_dependencies = [
    module.governance.allowed_locations_id
  ]

  hub_vnet_name          = "vnet-hub"
  hub_vnet_address_space = ["10.0.0.0/16"]

  subnet_gateway_prefix           = "10.0.0.0/27"
  subnet_firewall_prefix          = "10.0.0.64/26"
  subnet_shared_services_prefix   = "10.0.1.0/24"
  subnet_aci_prefix               = "10.0.2.0/24"
  subnet_private_endpoints_prefix = "10.0.3.0/24"
  subnet_jumphost_prefix          = "10.0.4.0/24"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# -------------------------------------------------------------------
# Reference the spoke_network module
# -------------------------------------------------------------------

module "spoke_network" {
  source = "../modules/spoke-network"

  resource_group_name = module.governance.platform_resource_group_name
  location            = var.location

  governance_dependencies = [
    module.governance.allowed_locations_id
  ]

  spoke_vnet_name          = "vnet-spoke-01"
  spoke_vnet_address_space = ["10.1.0.0/16"]

  subnet_app_prefix               = "10.1.0.0/24"
  subnet_data_prefix              = "10.1.1.0/24"
  subnet_private_endpoints_prefix = "10.1.2.0/24"

  # Hub details for peering
  hub_vnet_id   = module.hub_network.hub_vnet_id
  hub_vnet_name = module.hub_network.hub_vnet_name

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}
