# Pull hub outputs
data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "hub.tfstate"
  }
}

# Pull shared-services outputs
data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "shared-services.tfstate"
  }
}

