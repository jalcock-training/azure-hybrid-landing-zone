terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstatejames123"
    container_name       = "tfstate"
    key                  = "hybrid01.tfstate"
    use_azuread_auth     = true
  }
}

