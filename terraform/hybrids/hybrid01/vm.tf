locals {
  relay_public_key  = data.terraform_remote_state.hub.outputs.relay_public_key
  relay_private_key = data.terraform_remote_state.hub.outputs.relay_private_key
  base_image_url    = "http://${var.libvirt_host}/cloud-images/jammy-server-cloudimg-amd64.img"
}


module "hybrid01" {
  source = "../../modules/libvirt-hybrid-vm"

  name           = var.name
  pool           = var.pool
  base_image_url = local.base_image_url
  disk_size      = var.disk_size
  memory_mib     = 1024 * 1024
  vcpus          = var.vcpus
  network_name   = var.network_name
  autostart      = var.autostart

  cloud_init_userdata = templatefile("${path.module}/cloud-init-hybrid01.yaml", {
    relay_public_key = local.relay_public_key
    relay_private_key = local.relay_private_key
  })

  cloud_init_network_config = templatefile("${path.module}/network-hybrid01.yaml", {})
}

