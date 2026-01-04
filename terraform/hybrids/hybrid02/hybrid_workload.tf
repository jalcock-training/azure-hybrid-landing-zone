module "hybrid_workload" {
  source = "../../modules/hybrid-workload"

  name                    = "ahlz-hybrid02-dev-workload"
  common_name             = "ahlz-hybrid02-dev-workload"
  key_vault_id            = data.azurerm_key_vault.shared.id
  storage_account_id      = data.azurerm_storage_account.shared.id
  storage_account_name    = data.azurerm_storage_account.shared.name
  storage_container_name  = "workload-content"
  content_file            = "${path.module}/content/index.html"
}

