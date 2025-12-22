# ------------------------------------------------------------
# This module requires the azapi module
# ------------------------------------------------------------

terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
    }
  }
}

# ------------------------------------------------------------
# Platform Resource Group
# ------------------------------------------------------------

resource "azurerm_resource_group" "platform" {
  name     = var.platform_resource_group_name
  location = var.location
  tags     = var.tags
}

# ------------------------------------------------------------
# Subscription‑level Tags
# ------------------------------------------------------------

resource "azapi_resource" "subscription_tags" {
  type      = "Microsoft.Resources/tags@2021-04-01"
  name      = "default"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      tags = var.tags
    }
  })
}

# ------------------------------------------------------------
# Allowed Locations Policy Assignment
# ------------------------------------------------------------

resource "azapi_resource" "allowed_locations" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "allowed-locations"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      displayName        = "Allowed Locations"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
      parameters = {
        listOfAllowedLocations = {
          value = [var.location]
        }
      }
    }
  })
}

# ------------------------------------------------------------
# Required Tags Policy Assignment
# ------------------------------------------------------------

resource "azapi_resource" "required_tags" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "required-tags"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      displayName        = "Enforce Required Tags"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62"
      parameters = {
        tagName = {
          value = "Owner"
        }
        tagValue = {
          value = "James"
        }
      }
    }
  })
}

