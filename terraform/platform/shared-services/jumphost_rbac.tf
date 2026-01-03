resource "azurerm_role_assignment" "jumphost_kv_cert_officer" {
  scope                = module.shared_services.key_vault_id
  role_definition_name = "Key Vault Certificates Officer"
  principal_id         = local.jumphost_identity_principal_id
}

resource "azurerm_role_assignment" "jumphost_kv_secrets_officer" {
  scope                = module.shared_services.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = local.jumphost_identity_principal_id
}

#
# Key Vault RBAC
#

# Allow the hub jumphost identity to create role assignments *on the Key Vault only*
resource "azurerm_role_assignment" "jumphost_kv_user_access_admin" {
  scope                = module.shared_services.key_vault_id
  role_definition_name = "User Access Administrator"
  principal_id         = local.jumphost_identity_principal_id
}

# Allow the hub jumphost identity to manage the Key Vault resource itself
resource "azurerm_role_assignment" "jumphost_kv_contributor" {
  scope                = module.shared_services.key_vault_id
  role_definition_name = "Contributor"
  principal_id         = local.jumphost_identity_principal_id
}

#
# Storage Account RBAC
#

# Allow the hub jumphost identity to create role assignments *on the Storage Account only*
resource "azurerm_role_assignment" "jumphost_storage_user_access_admin" {
  scope                = module.storage.storage_account_id
  role_definition_name = "User Access Administrator"
  principal_id         = local.jumphost_identity_principal_id
}

# Allow the hub jumphost identity to manage the Storage Account resource itself
resource "azurerm_role_assignment" "jumphost_storage_contributor" {
  scope                = module.storage.storage_account_id
  role_definition_name = "Contributor"
  principal_id         = local.jumphost_identity_principal_id
}

