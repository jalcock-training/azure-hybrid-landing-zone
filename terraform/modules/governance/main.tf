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

# ------------------------------------------------------------
# Deny Key Vault public network access
# ------------------------------------------------------------
resource "azapi_resource" "deny_kv_public_network" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "deny-kv-public-network"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      displayName        = "Deny Key Vault Public Network Access"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/1f3afdf9-5fb1-42cc-9cca-8d06c1d5c4c"
      parameters = {
        effect = { value = "Deny" }
      }
    }
  })
}

# ------------------------------------------------------------
# Deny Storage public access
# ------------------------------------------------------------
resource "azapi_resource" "deny_storage_public_access" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "deny-storage-public-access"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      displayName        = "Deny Storage Public Access"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/d9a3c7d6-1f6b-4f8b-bb3f-1f3f3f3f3f3f"
      parameters = {
        effect = { value = "Deny" }
      }
    }
  })
}

# ------------------------------------------------------------
# Enforce TLS 1.2 on Storage
# ------------------------------------------------------------
resource "azapi_resource" "enforce_storage_tls12" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "enforce-storage-tls12"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      displayName        = "Enforce Storage TLS 1.2"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/8d8d8d8d-8d8d-8d8d-8d8d-8d8d8d8d8d8d"
      parameters = {
        effect = { value = "Deny" }
      }
    }
  })
}

# ------------------------------------------------------------
# Audit missing diagnostic settings
# ------------------------------------------------------------
resource "azapi_resource" "audit_diagnostics" {
  type      = "Microsoft.Authorization/policyAssignments@2021-06-01"
  name      = "audit-diagnostics"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      displayName        = "Audit Diagnostic Settings"
      policyDefinitionId = "/providers/Microsoft.Authorization/policyDefinitions/4d3f7d3f-4d3f-4d3f-4d3f-4d3f7d3f7d3f"
    }
  })
}
