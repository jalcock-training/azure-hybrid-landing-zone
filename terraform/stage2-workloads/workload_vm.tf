# ------------------------------------------------------------
# Workload VM Module
# ------------------------------------------------------------

module "workload_vm" {

  providers = {
    azapi = azapi
  }

  source = "../modules/workload-vm"

  # Location + RG
  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

  # Networking (from spoke network module)
  vnet_name          = module.spoke_network.spoke_vnet_name
  workload_subnet_id = module.spoke_network.subnet_ids["app"]

  # Key Vault (from shared services)
  kv_name = module.shared_services.key_vault_name

  # Set the vm ssh public key
  vm_ssh_public_key = tls_private_key.jump.public_key_openssh

  # Prefix for naming
  name_prefix = var.prefix

  # NSG rules (internal traffic allowed from the spoke)
  internal_cidrs = module.spoke_network.spoke_vnet_address_space
  jumphost_cidrs = module.hub_network.shared_services_subnet_cidr

  # Storage account name
  storage_account_id     = module.storage.storage_account_id
  storage_account_name   = module.storage.storage_account_name

  # Tags (optional — remove if not needed)
  common_tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

