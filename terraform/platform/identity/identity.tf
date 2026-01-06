resource "azuread_application" "hybrid_identity" {
  display_name = "ahlz-hybrid-identity"
}

resource "azuread_service_principal" "hybrid_identity" {
  client_id = azuread_application.hybrid_identity.client_id
}

resource "azuread_application_password" "hybrid_identity" {
  application_id = azuread_application.hybrid_identity.id
  display_name   = "hybrid-identity-secret"
}

