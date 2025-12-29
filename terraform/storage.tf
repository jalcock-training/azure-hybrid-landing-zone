# -------------------------------------------------------------------
# Storage
# -------------------------------------------------------------------

module "storage" {
  source = "./modules/storage"

  # Feature toggles
  enable_storage                   = true
  enable_storage_private_endpoints = true

  # Core settings
  prefix              = var.prefix
  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }

  # Networking
  allowed_subnet_ids         = [module.hub_network.subnet_ids["shared_services"]]
  private_endpoint_subnet_id = module.hub_network.private_endpoints_subnet_id
  hub_vnet_id                = module.hub_network.hub_vnet_id

  # DNS zones (from shared-services)
  private_dns_zone_blob_name = module.shared_services.private_dns_zone_storage_blob_name
  private_dns_zone_file_name = module.shared_services.private_dns_zone_storage_file_name
}
