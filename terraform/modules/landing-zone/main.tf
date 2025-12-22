/*
  Module: landing-zone
  Purpose: Creates the management group hierarchy and subscriptions
           that form the foundation of the landing zone.
*/

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

