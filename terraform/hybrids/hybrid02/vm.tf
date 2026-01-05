# ------------------------------------------------------------
# Render cloud-init with hybrid workload values
# ------------------------------------------------------------
locals {
  cloud_init_userdata = templatefile("${path.module}/cloud-init-hybrid02.yaml", {
    relay_public_key       = data.terraform_remote_state.hub.outputs.relay_public_key,
    AZ_TENANT_ID           = data.terraform_remote_state.hub.outputs.relay_tenant_id
    AZ_CLIENT_ID           = data.terraform_remote_state.hub.outputs.relay_client_id,
    AZ_CLIENT_SECRET       = data.terraform_remote_state.hub.outputs.relay_client_secret,
    KEY_VAULT_NAME         = data.azurerm_key_vault.shared.name,
    CERT_SECRET_NAME       = "hybrid02-cert",
    KEY_SECRET_NAME        = "hybrid02-key",
    STORAGE_ACCOUNT_NAME   = data.azurerm_storage_account.shared.name,
    STORAGE_CONTAINER_NAME = "workload-content",
  })

  relay_public_key  = data.terraform_remote_state.hub.outputs.relay_public_key
  relay_private_key = data.terraform_remote_state.hub.outputs.relay_private_key

  base_image_url    = "http://${var.libvirt_host}/cloud-images/jammy-server-cloudimg-amd64.img"
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
  base_image_url = local.base_image_url

  disk_size   = 20 * 1024 * 1024 * 1024  # 20 GiB in bytes
  memory_mib  = 2048
  vcpus       = 2
  network_name = "default"
  autostart    = true

  cloud_init_network_config = templatefile("${path.module}/network-hybrid02.yaml", {})

  cloud_init_userdata = local.cloud_init_userdata
}

