# ------------------------------------------------------------
# Render cloud-init with hybrid workload values
# ------------------------------------------------------------
locals {
  cloud_init_userdata = templatefile("${path.module}/cloud-init.yaml", {
    AZ_TENANT_ID           = module.hybrid_workload.tenant_id
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

  name                 = "ahlz-hybrid01-dev-workload"
  pool                 = "default"
  base_image           = "/var/lib/libvirt/images/ubuntu-22.04.qcow2"
  memory               = 2048
  vcpus                = 2
  network_name         = "default"
  autostart            = true
  cloud_init_userdata  = local.cloud_init_userdata
  cloud_init_network_config = ""
}

