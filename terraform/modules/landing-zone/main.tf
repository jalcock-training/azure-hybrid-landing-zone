/*
  Module: landing-zone
  Purpose: Creates the management group hierarchy and subscriptions
           that form the foundation of the landing zone.
*/

# NOTE: This module is currently subscription-scoped for free-tier compatibility.
# Future enterprise features (MG hierarchy, subscription vending) will be added in a separate project.

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Resource group added for core platform services since we don't have the 
# subscriptions and management groups

resource "azurerm_resource_group" "platform" {
  name     = "${var.prefix}-platform-rg"
  location = var.location

  tags = {
    environment = var.environment
    workload    = "platform"
    owner       = var.owner
  }
}

/*
  Baseline Policy Assignments
  ---------------------------
  These assignments use built‑in Azure Policies to enforce foundational
  governance across the Platform and LandingZones management groups.

  Future expansion:
  - Custom policies can be introduced later for more advanced governance
    scenarios (e.g., custom tag rules, custom naming enforcement, Arc-specific
    compliance, workload-specific controls).
*/

# ---------------------------------------------------------------------------
# Allowed Locations Policy
# ---------------------------------------------------------------------------

# Built‑in policy: Allowed locations
# This restricts resource deployment to approved regions.

resource "azurerm_policy_assignment" "allowed_locations" {
  name                 = "${var.prefix}-allowed-locations"
  display_name         = "Allowed Locations"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c" 
  scope                = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({
    listOfAllowedLocations = {
      #value = ["australiaeast", "australiasoutheast"]
      value = var.allowed_locations
    }
  })
  
  identity { 
    type = "SystemAssigned" 
  }
}

# ---------------------------------------------------------------------------
# Required Tags Policy
# ---------------------------------------------------------------------------

# Built‑in policy: Require specified tags
# Future expansion:
#   Replace with a custom policy definition if you want more complex
#   tag validation logic (e.g., regex validation, conditional tags).

resource "azurerm_policy_assignment" "required_tags" {
  name                 = "${var.prefix}-required-tags"
  display_name         = "Enforce Required Tags"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4f9e5b1d-65c9-4f3e-9b3e-1b3f2c4e0b1f"
  scope                = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({
    tagName = {
      value = "environment"
    }
  })

  identity { 
    type = "SystemAssigned" 
  }
}

# ---------------------------------------------------------------------------
# Enforced Naming Convention (Optional but recommended)
# ---------------------------------------------------------------------------

# Enforce Resource Naming Convention (built‑in example)
resource "azurerm_policy_assignment" "naming" {
  name                 = "${var.prefix}-naming-standards"
  display_name         = "Enforce Naming Standards"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0a914e76-4921-4c19-b460-a2d5c7f1e1c7"
  scope                = "/subscriptions/${var.subscription_id}"

  parameters = jsonencode({
    namePattern = {
      value = var.naming_pattern
    }
  })

  identity {
    type = "SystemAssigned"
  }
}

# -------------------------------------------------------------------
# Future Platform Resources (Networking, Key Vault, Monitoring, etc.)
# -------------------------------------------------------------------

# These will be added in Phase 2 and Phase 3.
# The structure is intentionally left ready for expansion.

# Example placeholder:
# module "networking" {
#   source = "./modules/networking"
#   subscription_id = var.subscription_id
#   location        = var.location
#   prefix          = var.prefix
# }

