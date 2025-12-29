# -------------------------------------------------------------------
# Shared Services
# -------------------------------------------------------------------

module "shared_services" {
  source = "../modules/shared-services"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name
  prefix              = "ahlz-dev"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }

  # Enable only Key Vault for now
  enable_key_vault                  = true
  enable_key_vault_private_endpoint = true
  enable_storage_private_endpoints  = true

  # Key Vault network configuration
  key_vault_allowed_subnet_ids = [
    module.hub_network.subnet_ids["shared_services"]
  ]

  key_vault_private_endpoint_subnet_id   = module.hub_network.private_endpoints_subnet_id

  hub_vnet_id = module.hub_network.hub_vnet_id

  # Make sure modules are built in the correct order
  depends_on = [
    module.governance,
    module.hub_network
  ]

}
