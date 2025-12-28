# ------------------------------------------------------------
# Shared Services Providers
# ------------------------------------------------------------

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }
}

data "azurerm_client_config" "current" {}

# ------------------------------------------------------------
# Azure Key Vault
# ------------------------------------------------------------

resource "azurerm_key_vault" "key_vault" {
  count = var.enable_key_vault ? 1 : 0

  name                = "${var.prefix}-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  public_network_access_enabled = false

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = var.key_vault_allowed_subnet_ids
    ip_rules                   = []
  }

  rbac_authorization_enabled = true

  tags = var.tags
}

# ------------------------------------------------------------
# Private Endpoint for Key Vault
# ------------------------------------------------------------

resource "azurerm_private_endpoint" "private_endpoint_key_vault" {
  count = var.enable_key_vault && var.enable_key_vault_private_endpoint ? 1 : 0

  name                = "${var.prefix}-pe-keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.key_vault_private_endpoint_subnet_id

  private_service_connection {
    name                           = "keyvault-connection"
    private_connection_resource_id = azurerm_key_vault.key_vault[0].id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# ------------------------------------------------------------
# Private DNS Zone for Key Vault
# ------------------------------------------------------------

resource "azurerm_private_dns_zone" "private_dns_zone_key_vault" {
  count = var.enable_key_vault_private_endpoint ? 1 : 0

  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# ------------------------------------------------------------
# Link Key Vault DNS Zone to Hub VNet
# ------------------------------------------------------------

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_key_vault_link" {
  count = var.enable_key_vault_private_endpoint ? 1 : 0

  name                  = "${var.prefix}-keyvault-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_key_vault[0].name
  virtual_network_id    = var.hub_vnet_id

  registration_enabled = false
  tags = var.tags

  depends_on = [
    azurerm_private_dns_zone.private_dns_zone_key_vault
  ]
}

# ------------------------------------------------------------
# Private DNS Zone for Storage (Blob)
# ------------------------------------------------------------

resource "azurerm_private_dns_zone" "private_dns_zone_storage_blob" {
  count = var.enable_storage_private_endpoints ? 1 : 0

  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# ------------------------------------------------------------
# Private DNS Zone for Storage (File)
# ------------------------------------------------------------

resource "azurerm_private_dns_zone" "private_dns_zone_storage_file" {
  count = var.enable_storage_private_endpoints ? 1 : 0

  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# ------------------------------------------------------------
# Storage private endpoint
# ------------------------------------------------------------

resource "azurerm_private_endpoint" "storage_blob" {
  count               = var.enable_storage_private_endpoints ? 1 : 0
  name                = "${var.prefix}-pe-storage-blob"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.storage_private_endpoint_subnet_id

  private_service_connection {
    name                           = "storage-blob-connection"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage_file" {
  count               = var.enable_storage_private_endpoints ? 1 : 0
  name                = "${var.prefix}-pe-storage-file"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.storage_private_endpoint_subnet_id

  private_service_connection {
    name                           = "storage-file-connection"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  tags = var.tags
}
