# -------------------------------------------------------------------
# Reference the hub_network_security module
# -------------------------------------------------------------------

module "hub_network_security" {
  source = "../../modules/network-security"

  location            = var.location
  resource_group_name = var.resource_group_name

  subnet_map = {
    shared_services   = module.hub_network.subnet_ids["shared_services"]
    aci               = module.hub_network.subnet_ids["aci"]
    private-endpoints = module.hub_network.private_endpoints_subnet_id

    # GatewaySubnet and AzureFirewallSubnet are excluded because Azure
    # does not allow NSGs or route tables on these platform-managed subnets.
    #gateway         = module.hub_network.subnet_ids["gateway"]
    #firewall        = module.hub_network.subnet_ids["firewall"]
  }

  # Basic NSG rules (free-tier friendly)
  nsg_rules = [

    # -----------------------------------------------------------------
    # Shared rules (apply to all hub subnets)
    # -----------------------------------------------------------------
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
    {
      name                       = "allow-azure-lb-outbound"
      priority                   = 220
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "AzureLoadBalancer"
    },

    {
      name                       = "allow-imds-outbound"
      priority                   = 230
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "169.254.169.254/32"
    },
    {
      name                       = "allow-azurecloud-outbound"
      priority                   = 240
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "AzureCloud"
    },



    # -----------------------------------------------------------------
    # Hardened rules for private-endpoints subnet
    # -----------------------------------------------------------------

    # Deny all inbound (catch-all)
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

    # Deny all outbound
    {
      name                       = "deny-all-outbound"
      priority                   = 4096
      direction                  = "Outbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  # Hub routes (simple, future‑proof)
  routes = [
    {
      name           = "route-to-spoke"
      address_prefix = "10.1.0.0/16"
      next_hop_type  = "VnetLocal"
    },
    {
      name           = "deny-internet"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "None"
    }
  ]

  tags = var.tags
}

