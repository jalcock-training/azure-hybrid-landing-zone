# -------------------------------------------------------------------
# Reference the governance module
# -------------------------------------------------------------------

module "governance" {
  source = "../modules/governance"

  subscription_id              = var.subscription_id
  location                     = var.location
  platform_resource_group_name = "rg-platform"

  enable_governance_policies = false

  tags = {
    Environment = "dev"
    Owner       = "James"
    Project     = "AzureHybridLandingZone"
  }
}
