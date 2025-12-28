# ------------------------------------------------------------
# Hub Network Module
# ------------------------------------------------------------

# Create the hub virtual network
resource "azurerm_virtual_network" "hub" {
  name                = var.hub_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.hub_vnet_address_space
  tags                = var.tags

  depends_on = [
    var.governance_dependencies
  ]
}

# GatewaySubnet (required name for Azure gateways)
resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.subnet_gateway_prefix]
}

# AzureFirewallSubnet (required name for Azure Firewall)
resource "azurerm_subnet" "firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.subnet_firewall_prefix]
}

# Shared services subnet
resource "azurerm_subnet" "shared_services" {
  name                 = "shared-services"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.subnet_shared_services_prefix]

  # Service endpoints
  service_endpoints = [
    "Microsoft.KeyVault",
    "Microsoft.Storage"
  ]
}

# Private endpoints subnet
resource "azurerm_subnet" "private_endpoints" {
  name                 = "private-endpoints"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.subnet_private_endpoints_prefix]
}

# ACI subnet
resource "azurerm_subnet" "aci" {
  name                 = "aci"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = [var.subnet_aci_prefix]

  delegation {
    name = "aci-delegation"

    service_delegation {
      name = "Microsoft.ContainerInstance/containerGroups"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Define shared services NSG
resource "azurerm_network_security_group" "shared_services" {
  name                = "${var.prefix}-nsg-shared-services"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}


