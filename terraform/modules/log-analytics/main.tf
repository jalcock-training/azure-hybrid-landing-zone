# ------------------------------------------------------------
# Log Analytics Providers
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

# ------------------------------------------------------------
# Log Analytics Workspace
# ------------------------------------------------------------

resource "azurerm_log_analytics_workspace" "log_analytics" {
  count = var.enable_log_analytics ? 1 : 0

  name                = "${var.prefix}-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = var.retention_in_days

  tags = var.tags
}

