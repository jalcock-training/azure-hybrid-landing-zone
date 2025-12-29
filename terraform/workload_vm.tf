# ------------------------------------------------------------
# Workload VM Module
# ------------------------------------------------------------

module "workload_vm" {
  source = "./modules/workload-vm"

  # Location + RG
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  # Networking
  vnet_name            = module.network.vnet_name
  workload_subnet_name = module.network.workload_subnet_name

  # Key Vault + Certificate
  kv_name      = module.shared_services.key_vault_name
  kv_cert_name = var.workload_certificate_name

  # Storage
  storage_account_name   = module.shared_services.storage_account_name
  storage_container_name = var.workload_storage_container_name

  # VM configuration
  vm_admin_username = var.vm_admin_username
  vm_ssh_public_key = var.ssh_public_key
  vm_size           = var.workload_vm_size
  name_prefix       = var.name_prefix

  # NSG rules
  jumphost_cidrs = [
    module.jumphost.subnet_cidr
  ]

  internal_cidrs = [
    module.network.hub_address_space,
    module.network.spoke_address_space
  ]

  # Tags
  common_tags = var.common_tags
}

# ------------------------------------------------------------
# Workload Storage Container
# ------------------------------------------------------------

resource "azurerm_storage_container" "workload_content" {
  name                  = var.workload_storage_container_name
  storage_account_name  = module.shared_services.storage_account_name
  container_access_type = "private"
}

