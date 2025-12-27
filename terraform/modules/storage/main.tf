terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0"
    }
  }
}

###############################################
# Secure Storage Account (Optional)
###############################################

resource "azurerm_storage_account" "storage_account" {
  count = var.enable_storage ? 1 : 0

  # Storage account names must be globally unique, lowercase, alphanumeric only
  name                     = "${replace(var.prefix, "-", "")}storage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security defaults
  min_tls_version           = "TLS1_2"
  shared_access_key_enabled = false

  # Encryption
  infrastructure_encryption_enabled = true

  # Network lockdown
  public_network_access_enabled = false

  network_rules {
    default_action             = "Deny"
    bypass                     = ["AzureServices"]
    ip_rules                   = []
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  # Soft delete for blob data
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

###############################################
# Private Endpoints (Blob + File)
###############################################

resource "azurerm_private_endpoint" "private_endpoint_blob" {
  count = var.enable_storage && var.enable_storage_private_endpoints ? 1 : 0

  name                = "${var.prefix}-pe-storage-blob"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "storage-blob-connection"
    private_connection_resource_id = azurerm_storage_account.storage_account[0].id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "private_endpoint_file" {
  count = var.enable_storage && var.enable_storage_private_endpoints ? 1 : 0

  name                = "${var.prefix}-pe-storage-file"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "storage-file-connection"
    private_connection_resource_id = azurerm_storage_account.storage_account[0].id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  tags = var.tags
}

###############################################
# DNS Zone Links (Blob + File)
###############################################

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link_blob" {
  count = var.enable_storage_private_endpoints ? 1 : 0

  name                  = "${var.prefix}-storage-blob-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_blob_name
  virtual_network_id    = var.hub_vnet_id

  registration_enabled = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link_file" {
  count = var.enable_storage_private_endpoints ? 1 : 0

  name                  = "${var.prefix}-storage-file-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_file_name
  virtual_network_id    = var.hub_vnet_id

  registration_enabled = false
}
