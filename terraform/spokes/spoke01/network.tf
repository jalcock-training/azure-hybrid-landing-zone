# -------------------------------------------------------------------
# Spoke network
# -------------------------------------------------------------------

module "spoke_network" {
  source = "../../modules/spoke-network"

  resource_group_name = var.resource_group_name
  location            = var.location
  prefix              = var.prefix

  spoke_vnet_name          = "vnet-spoke-01"
  spoke_vnet_address_space = ["10.1.0.0/16"]

  subnet_app_prefix               = "10.1.0.0/24"
  subnet_data_prefix              = "10.1.1.0/24"
  subnet_private_endpoints_prefix = "10.1.2.0/24"

  hub_vnet_id   = data.terraform_remote_state.hub.outputs.hub_vnet_id
  hub_vnet_name = data.terraform_remote_state.hub.outputs.hub_vnet_name

  tags = var.tags
}

