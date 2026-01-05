locals {
  relay_public_key = data.terraform_remote_state.hub.outputs.relay_public_key
}

module "hybrid01" {
  source = "../../modules/libvirt-hybrid-vm"

  name           = var.name
  pool           = var.pool
  base_image_url = var.base_image_url
  disk_size      = var.disk_size
  memory_mib     = 1024 * 1024
  vcpus          = var.vcpus
  network_name   = var.network_name
  autostart      = var.autostart

  cloud_init_userdata = templatefile("${path.module}/cloud-init-hybrid01.yaml", {
    relay_public_key = local.relay_public_key
  })

  cloud_init_network_config = ""
}

