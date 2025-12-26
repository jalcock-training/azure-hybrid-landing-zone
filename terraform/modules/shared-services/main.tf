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

###############################################
# Optional Log Analytics Workspace
###############################################

resource "azurerm_log_analytics_workspace" "this" {
  count = var.enable_log_analytics ? 1 : 0

  name                = "${var.prefix}-law"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_analytics_retention_days

  tags = var.tags
}

###############################################
# Optional Azure Key Vault (secure by default)
###############################################

resource "azurerm_key_vault" "this" {
  count = var.enable_key_vault ? 1 : 0

  name                = "${var.prefix}-kv"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # Security defaults
  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  # Network lockdown
  public_network_access_enabled = false

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Deny"
    virtual_network_subnet_ids = var.key_vault_allowed_subnet_ids
    ip_rules                   = []
  }

  # Access policies are intentionally not managed here to avoid
  # conflicts with RBAC-based access. This module focuses on platform security.
  enable_rbac_authorization = true

  tags = var.tags
}

###############################################
# Optional Private Endpoint for Key Vault
###############################################

resource "azurerm_private_endpoint" "key_vault" {
  count = var.enable_key_vault && var.enable_key_vault_private_endpoint ? 1 : 0

  name                = "${var.prefix}-pe-kv"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.key_vault_private_endpoint_subnet_id

  private_service_connection {
    name                           = "kv-connection"
    private_connection_resource_id = azurerm_key_vault.this[0].id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  tags = var.tags
}
