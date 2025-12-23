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
  location                     = "australiaeast"
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

  resource_group_name          = module.governance.platform_rg_name
  location                     = var.location

  hub_vnet_name                = "vnet-hub"
  hub_vnet_address_space       = ["10.0.0.0/16"]

  subnet_gateway_prefix        = "10.0.0.0/27"
  subnet_firewall_prefix       = "10.0.0.32/26"
  subnet_shared_services_prefix = "10.0.1.0/24"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

