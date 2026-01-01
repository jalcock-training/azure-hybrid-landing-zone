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
  resource_group_name = var.platform_resource_group_name


  # Networking (from spoke network module)
  vnet_name          = var.spoke_vnet_name
  workload_subnet_id = var.spoke_subnet_ids["app"]

  # Key Vault (from shared services)
  kv_name = var.key_vault_name
  key_vault_id = var.key_vault_id

  # Set the vm ssh public key
  jumphost_ssh_public_key = var.jump_public_key

  # Prefix for naming
  name_prefix = var.prefix

  # NSG rules (internal traffic allowed from the spoke)
  internal_cidrs = var.spoke_vnet_address_space
  jumphost_cidrs = var.shared_services_subnet_cidr

  # Storage account name
  storage_account_id     = var.storage_account_id
  storage_account_name   = var.storage_account_name

  # Tags (optional — remove if not needed)
  common_tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}
