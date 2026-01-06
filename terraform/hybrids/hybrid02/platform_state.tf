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

# Pull shared-services outputs
data "terraform_remote_state" "identity" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "identity.tfstate"
  }
}

# Pull hybrid02-prereqs outputs
data "terraform_remote_state" "hybrid02_prereqs" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "hybrid02-prereqs.tfstate"
  }
}

