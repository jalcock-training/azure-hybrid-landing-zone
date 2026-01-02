resource "azurerm_role_assignment" "jumphost_kv_cert_officer" {
  scope                = module.shared_services.key_vault_id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = data.terraform_remote_state.hub.outputs.jumphost_identity_principal_id
}

resource "azurerm_role_assignment" "jumphost_kv_secrets_officer" {
  scope                = module.shared_services.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.terraform_remote_state.hub.outputs.jumphost_identity_principal_id
}

