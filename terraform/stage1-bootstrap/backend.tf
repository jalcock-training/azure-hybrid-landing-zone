terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "stage1.terraform.tfstate"
    use_azuread_auth     = true
  }
}

