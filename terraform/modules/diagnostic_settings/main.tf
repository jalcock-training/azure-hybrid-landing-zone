# ------------------------------------------------------------
# Diagnostics Providers
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
# Diagnostic Settings 
# ------------------------------------------------------------

resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  count = var.enable_diagnostics ? 1 : 0

  name                       = "${var.prefix}-diagnostics"
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = var.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = var.metric_categories
    content {
      category = enabled_metric.value
    }
  }
}
