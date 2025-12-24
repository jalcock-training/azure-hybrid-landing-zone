/*
  Module: landing-zone
  Purpose: Creates the management group hierarchy and subscriptions
           that form the foundation of the landing zone.
*/

# NOTE: This module is currently subscription-scoped for free-tier compatibility.
# Future enterprise features (MG hierarchy, subscription vending) will be added in a separate project.

# Resource group added for core platform services since we don't have the 
# subscriptions and management groups

# ---------------------------------------------------------------------------
# Allowed Locations Policy
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Required Tags Policy
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Enforced Naming Convention (Optional but recommended)
# ---------------------------------------------------------------------------

# -------------------------------------------------------------------
# Future Platform Resources (Networking, Key Vault, Monitoring, etc.)
# -------------------------------------------------------------------

# -------------------------------------------------------------------
# Reference the governance module
# -------------------------------------------------------------------

module "governance" {
  source = "./modules/governance"

  subscription_id              = var.subscription_id
  location                     = var.location
  platform_resource_group_name = "rg-platform"
  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# -------------------------------------------------------------------
# Reference the hub_network module
# -------------------------------------------------------------------

module "hub_network" {
  source = "./modules/hub-network"

  resource_group_name          = module.governance.platform_resource_group_name
  location                     = var.location

  hub_vnet_name                = "vnet-hub"
  hub_vnet_address_space       = ["10.0.0.0/16"]

  subnet_gateway_prefix        = "10.0.0.0/27"
  subnet_firewall_prefix       = "10.0.0.64/26"
  subnet_shared_services_prefix = "10.0.1.0/24"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# -------------------------------------------------------------------
# Reference the spoke_network module
# -------------------------------------------------------------------

module "spoke_network" {
  source = "./modules/spoke-network"

  resource_group_name = module.governance.platform_resource_group_name
  location            = var.location

  spoke_vnet_name          = "vnet-spoke-01"
  spoke_vnet_address_space = ["10.1.0.0/16"]

  subnet_app_prefix               = "10.1.0.0/24"
  subnet_data_prefix              = "10.1.1.0/24"
  subnet_private_endpoints_prefix = "10.1.2.0/24"

  # Hub details for peering
  hub_vnet_id   = module.hub_network.hub_vnet_id
  hub_vnet_name = module.hub_network.hub_vnet_name

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

module "hub_network_security" {
  source = "./modules/network-security"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

  subnet_map = {
    shared_services = module.hub_network.subnet_ids["shared_services"]
    # GatewaySubnet and AzureFirewallSubnet are excluded because Azure
    # does not allow NSGs or route tables on these platform-managed subnets.
    #gateway         = module.hub_network.subnet_ids["gateway"]
    #firewall        = module.hub_network.subnet_ids["firewall"]
  }

  # Basic NSG rules (free-tier friendly)
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
      name                       = "allow-azure-lb"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    }
  ]

  # Hub routes (simple, future‑proof)
  routes = [
    {
      name           = "route-to-spoke"
      address_prefix = "10.1.0.0/16"
      next_hop_type  = "VnetLocal"
    }
  ]

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# ------------------------------------------------------------
# Jump ACI (exec-only container)
# ------------------------------------------------------------
module "jump_aci" {
  source = "./modules/jump-aci"

  location            = var.location
  resource_group_name = module.governance.resource_group_name
  subnet_id           = module.hub_network.subnet_ids["shared_services"]

  container_name  = "jump-aci"
  container_image = "mcr.microsoft.com/azure-cli"
  cpu_cores       = 1
  memory_gb       = 1

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# ------------------------------------------------------------
# Jumphost VM (Ubuntu 24.04 LTS)
# ------------------------------------------------------------
module "jumphost_vm" {
  source = "./modules/jumphost-vm"

  location            = var.location
  resource_group_name = module.governance.resource_group_name
  subnet_id           = module.hub_network.subnet_ids["shared_services"]

  admin_username = "azureuser"
  ssh_public_key = file("~/.ssh/id_rsa.pub")
  vm_size        = "Standard_B1s"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

