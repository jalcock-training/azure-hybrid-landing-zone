data "terraform_remote_state" "hub" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "hub.tfstate"
  }
}

locals {
  jumphost_identity_principal_id = data.terraform_remote_state.hub.outputs.jumphost_identity_principal_id
}
