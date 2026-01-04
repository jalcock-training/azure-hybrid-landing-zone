
# ------------------------------------------------------------
# Shared services: Key Vault + Storage (from remote state)
# ------------------------------------------------------------

data "azurerm_key_vault" "shared" {
  name                = data.terraform_remote_state.shared.outputs.key_vault_name
  resource_group_name = data.terraform_remote_state.shared.outputs.key_vault_rg
}

data "azurerm_storage_account" "shared" {
  name                = data.terraform_remote_state.shared.outputs.storage_account_name
  resource_group_name = data.terraform_remote_state.shared.outputs.storage_account_rg
}

