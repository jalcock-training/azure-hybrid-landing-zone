/*
  Module: landing-zone
  Purpose: Creates the management group hierarchy and subscriptions
           that form the foundation of the landing zone.
*/

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

# Management groups and separate subscriptions have been removed as I grapple 
# with the limitations of free tier Entra ID tenants. This will likely be 
# expanded in a future project or project variance under a pay as you go tier.
/*
resource "azurerm_management_group" "platform" {
  display_name = "${var.prefix}-platform"
  name         = "${var.prefix}-platform"
  parent_management_group_id = var.root_management_group_id
}

resource "azurerm_management_group" "landingzones" {
  display_name = "${var.prefix}-landingzones"
  name         = "${var.prefix}-landingzones"
  parent_management_group_id = var.root_management_group_id
}

# Azure subscriptions must be created using the azapi provider.
# The azurerm provider cannot create subscriptions.

resource "azapi_resource" "platform_subscription" {
  type      = "Microsoft.Subscription/subscriptions@2021-10-01"
  name      = var.platform_subscription_name

  body = jsonencode({
    displayName = var.platform_subscription_name
    billingScope = var.billing_scope
    workload = "Production"
  })

  response_export_values = ["subscriptionId"]
}

resource "azapi_resource" "workload_subscription" {
  type      = "Microsoft.Subscription/subscriptions@2021-10-01"
  name      = var.workload_subscription_name

  body = jsonencode({
    displayName = var.workload_subscription_name
    billingScope = var.billing_scope
    workload = "Production"
  })

  response_export_values = ["subscriptionId"]
}



# After creation, the subscription must be moved under the correct
# management group to inherit governance and policy.

resource "azurerm_management_group_subscription_association" "platform" {
  management_group_id = azurerm_management_group.platform.id
  subscription_id     = azapi_resource.platform_subscription.output["subscriptionId"]
}

resource "azurerm_management_group_subscription_association" "workload" {
  management_group_id = azurerm_management_group.landingzones.id
  subscription_id     = azapi_resource.workload_subscription.output["subscriptionId"]
}
*/

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

# Reduced project scope
/*
resource "azurerm_policy_assignment" "allowed_locations_platform" {
name                 = "${var.prefix}-allowed-locations-platform"
  display_name         = "Allowed Locations (Platform)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  scope                = azurerm_management_group.platform.id
*/

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

# Reduced project scope
/*
resource "azurerm_policy_assignment" "allowed_locations_landingzones" {
  name                 = "${var.prefix}-allowed-locations-landingzones"
  display_name         = "Allowed Locations (Landing Zones)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  scope                = azurerm_management_group.landingzones.id

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = ["australiaeast", "australiasoutheast"]
    }
  })
}
*/

# ---------------------------------------------------------------------------
# Required Tags Policy
# ---------------------------------------------------------------------------

# Built‑in policy: Require specified tags
# Future expansion:
#   Replace with a custom policy definition if you want more complex
#   tag validation logic (e.g., regex validation, conditional tags).

# Reduced project scope
/*
resource "azurerm_policy_assignment" "required_tags_platform" {
  name                 = "${var.prefix}-required-tags-platform"
  display_name         = "Required Tags (Platform)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4f9e5b1d-65c9-4f3e-9b3e-1b3f2c4e0b1f"
  scope                = azurerm_management_group.platform.id
*/

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

# Reduced project scope
/*
resource "azurerm_policy_assignment" "required_tags_landingzones" {
  name                 = "${var.prefix}-required-tags-landingzones"
  display_name         = "Required Tags (Landing Zones)"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4f9e5b1d-65c9-4f3e-9b3e-1b3f2c4e0b1f"
  scope                = azurerm_management_group.landingzones.id

  parameters = jsonencode({
    tagName = {
      value = "environment"
    }
  })

  identity { 
    type = "SystemAssigned" 
  }
}
*/

# Reduced project scope
/*
# ---------------------------------------------------------------------------
# Azure Security Benchmark (Optional but recommended)
# ---------------------------------------------------------------------------

# Built‑in initiative: Azure Security Benchmark v3
# This is a strong signal to recruiters that you understand governance maturity.
resource "azurerm_policy_assignment" "asb_platform" {
  name                 = "${var.prefix}-asb-platform"
  display_name         = "Azure Security Benchmark (Platform)"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/0c5c8d31-8c1e-4c2f-8c5b-3f5f1b0a6a5a"
  scope                = azurerm_management_group.platform.id
}

resource "azurerm_policy_assignment" "asb_landingzones" {
  name                 = "${var.prefix}-asb-landingzones"
  display_name         = "Azure Security Benchmark (Landing Zones)"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/0c5c8d31-8c1e-4c2f-8c5b-3f5f1b0a6a5a"
  scope                = azurerm_management_group.landingzones.id
}
*/

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

