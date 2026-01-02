# -------------------------------------------------------------------
# Shared Services
# -------------------------------------------------------------------

module "shared_services" {
  source = "../../modules/shared-services"

  location            = var.location
  resource_group_name = var.resource_group_name
  prefix              = var.prefix

  tags = var.tags

  # Enable only Key Vault
  enable_key_vault                  = true
  enable_key_vault_private_endpoint = true
  enable_storage_private_endpoints  = true

  # Key Vault network configuration
  key_vault_allowed_subnet_ids = [
    data.terraform_remote_state.hub.outputs.subnet_ids["shared_services"],
    data.terraform_remote_state.hub.outputs.subnet_ids["jumphost"]
  ]

  # Wired into the exported hub state
  key_vault_private_endpoint_subnet_id = data.terraform_remote_state.hub.outputs.private_endpoints_subnet_id

  hub_vnet_id = data.terraform_remote_state.hub.outputs.hub_vnet_id
}
