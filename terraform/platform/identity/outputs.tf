output "hybrid_identity_client_id" {
  value = azuread_application.hybrid_identity.client_id
}

output "hybrid_identity_client_secret" {
  value     = azuread_application_password.hybrid_identity.value
  sensitive = true
}

output "hybrid_identity_tenant_id" {
  value = azuread_service_principal.hybrid_identity.application_tenant_id
}

