# ------------------------------------------------------------
# Workload VM Module
# ------------------------------------------------------------

module "workload_vm" {

  providers = {
    azapi = azapi
  }

  source = "../../modules/workload-vm"

  # Location + RG
  location            = var.location
  resource_group_name = var.resource_group_name


  # Networking (from spoke network module)
  vnet_name          = module.spoke_network.spoke_vnet_name
  workload_subnet_id = module.spoke_network.subnet_ids["app"]

  # Key Vault (from shared services)
  kv_name      = data.terraform_remote_state.shared.outputs.key_vault_name
  key_vault_id = data.terraform_remote_state.shared.outputs.key_vault_id

  # Set the vm ssh public key
  jumphost_ssh_public_key = data.terraform_remote_state.hub.outputs.jump_public_key

  # Prefix for naming
  name_prefix = var.prefix

  # NSG rules (internal traffic allowed from the spoke)
  internal_cidrs = module.spoke_network.spoke_vnet_address_space
  jumphost_cidrs = data.terraform_remote_state.hub.outputs.subnet_cidrs["jumphost"]

  # Storage account details from shared-services
  storage_account_id     = data.terraform_remote_state.shared.outputs.storage_account_id
  storage_account_name   = data.terraform_remote_state.shared.outputs.storage_account_name

  # Pass the resource group names from shared services
  key_vault_resource_group_name   = data.terraform_remote_state.shared.outputs.shared_services_resource_group_name
  storage_resource_group_name     = data.terraform_remote_state.shared.outputs.shared_services_resource_group_name

  tags = var.tags
}
