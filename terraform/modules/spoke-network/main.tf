# ------------------------------------------------------------
# Spoke Network Module
# ------------------------------------------------------------

# Create the spoke virtual network
resource "azurerm_virtual_network" "spoke" {
  name                = var.spoke_vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.spoke_vnet_address_space
  tags                = var.tags
}

# App subnet
resource "azurerm_subnet" "app" {
  name                 = "app"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.subnet_app_prefix]
}

# Data subnet
resource "azurerm_subnet" "data" {
  name                 = "data"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.subnet_data_prefix]
}

# Private Endpoints subnet
resource "azurerm_subnet" "private_endpoints" {
  name                 = "private-endpoints"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = [var.subnet_private_endpoints_prefix]
}

# Spoke key vault private endpoint
resource "azurerm_private_endpoint" "key_vault_spoke" {
  count = var.key_vault_id != null && var.key_vault_private_dns_zone_id != null ? 1 : 0

  name                = "${var.prefix}-pe-keyvault-spoke"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "keyvault-connection-spoke"
    private_connection_resource_id = var.key_vault_id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "${var.prefix}-keyvault-dns-zone-group-spoke"

    private_dns_zone_ids = [
      var.key_vault_private_dns_zone_id
    ]
  }

  tags = var.tags
}

# Private DNS zone for spoke key vault
resource "azurerm_private_dns_zone_virtual_network_link" "key_vault_spoke_link" {
  count = var.key_vault_private_dns_zone_id != null ? 1 : 0

  name                  = "${var.prefix}-kv-dns-link-spoke"
  resource_group_name   = var.private_dns_resource_group_name
  private_dns_zone_name = "privatelink.vaultcore.azure.net"
  virtual_network_id    = azurerm_virtual_network.spoke.id

  registration_enabled = false
  tags                 = var.tags
}

# Private endpoint for storage blob
resource "azurerm_private_endpoint" "storage_blob_spoke" {
  count = var.storage_account_id != null && var.storage_blob_private_dns_zone_id != null ? 1 : 0

  name                = "${var.prefix}-pe-blob-spoke"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "blob-connection-spoke"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "${var.prefix}-blob-dns-zone-group-spoke"

    private_dns_zone_ids = [
      var.storage_blob_private_dns_zone_id
    ]
  }

  tags = var.tags
}

# Spoke private dns for storage blob endpoint link
resource "azurerm_private_dns_zone_virtual_network_link" "storage_blob_spoke_link" {
  count = var.storage_blob_private_dns_zone_id != null ? 1 : 0

  name                  = "${var.prefix}-blob-dns-link-spoke"
  resource_group_name   = var.private_dns_resource_group_name
  private_dns_zone_name = "privatelink.blob.core.windows.net"
  virtual_network_id    = azurerm_virtual_network.spoke.id

  registration_enabled = false
  tags                 = var.tags
}


# Private endpoint for storage file
resource "azurerm_private_endpoint" "storage_file_spoke" {
  count = var.storage_account_id != null && var.storage_file_private_dns_zone_id != null ? 1 : 0

  name                = "${var.prefix}-pe-file-spoke"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.private_endpoints.id

  private_service_connection {
    name                           = "file-connection-spoke"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "${var.prefix}-file-dns-zone-group-spoke"

    private_dns_zone_ids = [
      var.storage_file_private_dns_zone_id
    ]
  }

  tags = var.tags
}

# Spoke private dns link for storage file endpoint
resource "azurerm_private_dns_zone_virtual_network_link" "storage_file_spoke_link" {
  count = var.storage_file_private_dns_zone_id != null ? 1 : 0

  name                  = "${var.prefix}-file-dns-link-spoke"
  resource_group_name   = var.private_dns_resource_group_name
  private_dns_zone_name = "privatelink.file.core.windows.net"
  virtual_network_id    = azurerm_virtual_network.spoke.id

  registration_enabled = false
  tags                 = var.tags
}



# Spoke -> Hub peering
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "${var.spoke_vnet_name}-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id

  allow_forwarded_traffic = true
  allow_gateway_transit   = false
  allow_virtual_network_access = true
}

# Hub -> Spoke peering
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "${var.hub_vnet_name}-to-${var.spoke_vnet_name}"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id

  allow_forwarded_traffic = true
  allow_gateway_transit   = false
  allow_virtual_network_access = true
}
