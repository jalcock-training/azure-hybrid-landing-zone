# -------------------------------------------------------------------
# Reference the spoke_network_security module
# -------------------------------------------------------------------
module "spoke_network_security" {
  source = "../../modules/network-security"

  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_map = {
    app               = module.spoke_network.subnet_ids["app"]
    data              = module.spoke_network.subnet_ids["data"]
    private_endpoints = module.spoke_network.subnet_ids["private_endpoints"]
  }

  nsg_rules = [
    {
      name                       = "allow-vnet-inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "allow-azure-lb-inbound"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    },
    {
      name                       = "deny-all-inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-azure-lb-outbound"
      priority                   = 200
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "AzureLoadBalancer"
    },
    {
      name                       = "allow-vnet-outbound"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
  ]

  routes = []

  tags = var.tags

}
