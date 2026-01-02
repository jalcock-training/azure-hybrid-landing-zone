resource_group_name = "rg-hub"
location            = "southeastasia"
prefix              = "ahlz-dev"

tags = {
  Environment = "dev"
  Owner       = "James"
  Project     = "AzureHybridLandingZone"
}

subscription_id              = "66ca4a38-9f37-4a03-a931-744566662dd0"
tfstate_storage_account_name = "tfstatejames123"
tfstate_resource_group_name  = "rg-tfstate"
enable_nsg_flow_logs         = true

