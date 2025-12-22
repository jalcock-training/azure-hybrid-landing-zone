# Create the platform resource group
resource "azurerm_resource_group" "platform" {
  name     = var.platform_resource_group_name
  location = var.location
  tags     = var.tags
}

# Apply subscription-level tags
resource "azurerm_subscription_tag" "subscription_tags" {
  subscription_id = var.subscription_id
  tags            = var.tags
}

# Allowed locations policy
resource "azurerm_policy_assignment" "allowed_locations" {
  name                 = "allowed-locations"
  display_name         = "Allowed Locations"
  scope                = "/subscriptions/${var.subscription_id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = [var.location]
    }
  })
}

# Required tags policy
resource "azurerm_policy_assignment" "required_tags" {
  name                 = "required-tags"
  display_name         = "Required Tags"
  scope                = "/subscriptions/${var.subscription_id}"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4f9f7b9b-0d1c-4d1d-8f3c-3b8f1e3c5f5a"

  parameters = jsonencode({
    tagName = {
      value = "Owner"
    }
  })
}
