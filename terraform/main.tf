/*
  Module: landing-zone
  Purpose: Creates the management group hierarchy and subscriptions
           that form the foundation of the landing zone.
*/

# NOTE: This module is currently subscription-scoped for free-tier compatibility.
# Future enterprise features (MG hierarchy, subscription vending) will be added in a separate project.

# -------------------------------------------------------------------
# Reference the governance module
# -------------------------------------------------------------------

module "governance" {
  source = "./modules/governance"

  subscription_id              = var.subscription_id
  location                     = var.location
  platform_resource_group_name = "rg-platform"

  enable_governance_policies = false

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

  resource_group_name = module.governance.platform_resource_group_name
  prefix              = var.prefix
  location            = var.location

  governance_dependencies = [
    module.governance.allowed_locations_id
  ]

  hub_vnet_name          = "vnet-hub"
  hub_vnet_address_space = ["10.0.0.0/16"]

  subnet_gateway_prefix         = "10.0.0.0/27"
  subnet_firewall_prefix        = "10.0.0.64/26"
  subnet_shared_services_prefix = "10.0.1.0/24"
  subnet_aci_prefix             = "10.0.2.0/24"

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

  governance_dependencies = [
    module.governance.allowed_locations_id
  ]

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

# -------------------------------------------------------------------
# Reference the hub_network_security module
# -------------------------------------------------------------------

module "hub_network_security" {
  source = "./modules/network-security"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

  subnet_map = {
    shared_services = module.hub_network.subnet_ids["shared_services"]
    aci             = module.hub_network.subnet_ids["aci"]

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

# -------------------------------------------------------------------
# Reference the spoke_network_security module
# -------------------------------------------------------------------
module "spoke_network_security" {
  source = "./modules/network-security"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

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
      name                       = "deny-all-inbound"
      priority                   = 4096
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

  routes = []

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# ------------------------------------------------------------
# Generate SSH keypair for ACI → VM access
# ------------------------------------------------------------
resource "tls_private_key" "jump" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ------------------------------------------------------------
# Jump ACI
# ------------------------------------------------------------
module "jump_aci" {
  source = "./modules/jump-aci"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name
  subnet_id           = module.hub_network.subnet_ids["aci"]

  container_name  = "jump-aci"
  container_image = "mcr.microsoft.com/azure-cli:2.52.0"
  cpu_cores       = 1
  memory_gb       = 1

  # Pass private key securely into ACI
  private_key_pem = tls_private_key.jump.private_key_pem
  vm_name         = module.jumphost_vm.vm_name

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# ------------------------------------------------------------
# RBAC: Allow ACI to start/stop the VM
# ------------------------------------------------------------
resource "azurerm_role_assignment" "aci_vm_control" {
  scope                = module.jumphost_vm.vm_id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = module.jump_aci.identity_principal_id
}

# ------------------------------------------------------------
# Jumphost VM 
# ------------------------------------------------------------
module "jumphost_vm" {
  source = "./modules/jumphost-vm"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name
  subnet_id           = module.hub_network.subnet_ids["shared_services"]

  admin_username = "azureuser"
  # Inject public key generated by Terraform
  ssh_public_key = tls_private_key.jump.public_key_openssh

  vm_size = "Standard_D2as_v5"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# -------------------------------------------------------------------
# Shared Services
# -------------------------------------------------------------------

module "shared_services" {
  source = "./modules/shared-services"

  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name
  prefix              = "ahlz-dev"

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }

  # Enable only Key Vault for now
  enable_key_vault                  = true
  enable_key_vault_private_endpoint = true
  enable_storage_private_endpoints  = true

  # Key Vault network configuration
  key_vault_allowed_subnet_ids = [
    module.hub_network.subnet_ids["shared_services"]
  ]

  key_vault_private_endpoint_subnet_id = module.hub_network.subnet_ids["shared_services"]

  hub_vnet_id = module.hub_network.hub_vnet_id
}

# -------------------------------------------------------------------
# Storage
# -------------------------------------------------------------------

module "storage" {
  source = "./modules/storage"

  # Feature toggles
  enable_storage                   = true
  enable_storage_private_endpoints = true

  # Core settings
  prefix              = var.prefix
  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }

  # Networking
  allowed_subnet_ids         = [module.hub_network.subnet_ids["shared_services"]]
  private_endpoint_subnet_id = module.hub_network.subnet_ids["shared_services"]
  hub_vnet_id                = module.hub_network.hub_vnet_id

  # DNS zones (from shared-services)
  private_dns_zone_blob_name = module.shared_services.private_dns_zone_storage_blob_name
  private_dns_zone_file_name = module.shared_services.private_dns_zone_storage_file_name
}

# -------------------------------------------------------------------
# Log Analytics
# -------------------------------------------------------------------

module "log_analytics" {
  source = "./modules/log-analytics"

  # Feature toggle
  enable_log_analytics = true

  # Core settings
  prefix              = var.prefix
  location            = var.location
  resource_group_name = module.governance.platform_resource_group_name

  # Retention (default 30 days, override if needed)
  retention_in_days = 30

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}

# -------------------------------------------------------------------
# Key Vault Diagnostics
# -------------------------------------------------------------------

module "diagnostics_key_vault" {
  source = "./modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.shared_services.key_vault_id
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories    = ["AuditEvent"]
  metric_categories = ["AllMetrics"]
}

# -------------------------------------------------------------------
# Storage Diagnostics
# -------------------------------------------------------------------

module "diagnostics_storage" {
  source = "./modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.storage.storage_account_id
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = []

  metric_categories = ["AllMetrics"]
}

# -------------------------------------------------------------------
# Storage Diagnostics
# -------------------------------------------------------------------

module "diagnostics_hub_vnet" {
  source = "./modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.hub_network.hub_vnet_id
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = []

  metric_categories = ["AllMetrics"]
}

# -------------------------------------------------------------------
# NSG Diagnostics
# -------------------------------------------------------------------

module "diagnostics_nsg_shared_services" {
  source = "./modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id         = module.hub_network.nsg_ids["shared_services"]
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = [
    "NetworkSecurityGroupEvent",
    "NetworkSecurityGroupRuleCounter"
  ]

  metric_categories = []
}

# -------------------------------------------------------------------
# Activity Log Diagnostics
# -------------------------------------------------------------------

module "diagnostics_activity_log" {
  source = "./modules/diagnostic_settings"

  enable_diagnostics = true
  prefix             = var.prefix

  target_resource_id = "/subscriptions/${var.subscription_id}"
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = [
    "Administrative",
    "Security",
    "ServiceHealth",
    "Alert",
    "Recommendation",
    "Policy",
    "Autoscale",
    "ResourceHealth"
  ]

  metric_categories = []
}

# -------------------------------------------------------------------
# Diagnostics for NSGs
# -------------------------------------------------------------------

module "diagnostics_nsg_all" {
  source = "./modules/diagnostic_settings"

  for_each = module.hub_network.nsg_ids

  enable_diagnostics = true
  prefix             = "${var.prefix}-${each.key}"

  target_resource_id         = each.value
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id

  log_categories = [
    "NetworkSecurityGroupEvent",
    "NetworkSecurityGroupRuleCounter"
  ]

  metric_categories = []
}

# -------------------------------------------------------------------
# Activity Log
# -------------------------------------------------------------------

module "activity_log" {
  source = "./modules/activity-log"

  prefix                       = var.prefix
  subscription_id              = var.subscription_id
  log_analytics_workspace_id   = module.log_analytics.log_analytics_workspace_id
  enable_activity_log_export   = var.enable_activity_log_export
}

