# ------------------------------------------------------------
# Render cloud-init with hybrid workload values
# ------------------------------------------------------------
locals {
  cloud_init_userdata = templatefile("${path.module}/cloud-init.yaml", {
    AZ_TENANT_ID           = data.azurerm_client_config.current.tenant_id
    AZ_CLIENT_ID           = module.hybrid_workload.client_id
    AZ_CLIENT_SECRET       = module.hybrid_workload.client_secret
    KEY_VAULT_NAME         = data.azurerm_key_vault.shared.name
    CERT_SECRET_NAME       = module.hybrid_workload.cert_secret_name
    KEY_SECRET_NAME        = module.hybrid_workload.key_secret_name
    STORAGE_ACCOUNT_NAME   = module.hybrid_workload.storage_account_name
    STORAGE_CONTAINER_NAME = module.hybrid_workload.storage_container_name
  })
}

# ------------------------------------------------------------
# Hybrid KVM VM
# ------------------------------------------------------------

module "hybrid_vm" {
  source = "../../modules/libvirt-hybrid-vm"

  providers = {
    libvirt = libvirt
  }

  name         = "ahlz-hybrid02-dev-workload"
  pool         = "default"
  base_image_url = "file:///var/lib/libvirt/images/ubuntu-22.04-minimal-cloudimg-amd64.img"

  disk_size   = 20 * 1024 * 1024 * 1024  # 20 GiB in bytes
  memory_mib  = 2048
  vcpus       = 2
  network_name = "default"
  autostart    = true

  cloud_init_userdata       = local.cloud_init_userdata
  cloud_init_network_config = "" # or your rendered net config if you add it later
}

