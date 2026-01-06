resource "azurerm_role_assignment" "hybrid_identity_kv_access" {
  scope                = data.azurerm_key_vault.shared.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azuread_service_principal.hybrid_identity.id
}

resource "azurerm_role_assignment" "hybrid_identity_storage_access" {
  scope                = data.terraform_remote_state.shared.outputs.storage_account_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azuread_service_principal.hybrid_identity.id
}

