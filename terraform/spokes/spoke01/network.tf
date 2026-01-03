module "spoke_network" {
  source = "../../modules/spoke-network"

  depends_on = [
    azurerm_resource_group.spoke01
  ]

  # Required core inputs
  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix

  spoke_vnet_name          = "vnet-spoke-01"
  spoke_vnet_address_space = ["10.1.0.0/16"]

  subnet_app_prefix               = "10.1.0.0/24"
  subnet_data_prefix              = "10.1.1.0/24"
  subnet_private_endpoints_prefix = "10.1.2.0/24"

  # Hub dependencies (from remote state)
  hub_vnet_id             = data.terraform_remote_state.hub.outputs.hub_vnet_id
  hub_vnet_name           = data.terraform_remote_state.hub.outputs.hub_vnet_name
  hub_resource_group_name = data.terraform_remote_state.hub.outputs.hub_resource_group_name

  # Shared services (Key Vault + Storage)
  key_vault_id                    = data.terraform_remote_state.shared.outputs.key_vault_id
  key_vault_private_dns_zone_id   = data.terraform_remote_state.shared.outputs.key_vault_private_dns_zone_id
  storage_account_id              = data.terraform_remote_state.shared.outputs.storage_account_id
  storage_blob_private_dns_zone_id = data.terraform_remote_state.shared.outputs.storage_blob_private_dns_zone_id
  storage_file_private_dns_zone_id = data.terraform_remote_state.shared.outputs.storage_file_private_dns_zone_id


  # Private DNS zones live in shared-services RG
  private_dns_resource_group_name = data.terraform_remote_state.shared.outputs.private_dns_resource_group_name

  tags = var.tags
}

