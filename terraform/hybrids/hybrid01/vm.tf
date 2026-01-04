module "hybrid01" {
  source = "../../modules/libvirt-hybrid-vm"

  name           = var.name
  pool           = var.pool
  base_image_url = var.base_image_url

  disk_size   = var.disk_size
  memory_mib  = var.memory_mib
  vcpus       = var.vcpus
  network_name = var.network_name
  autostart    = var.autostart

  # Minimal cloud-init: just create the SSH user and lock everything down
  cloud_init_userdata = <<-EOF
    #cloud-config
    hostname: ${var.name}
    users:
      - name: relay
        sudo: []
        shell: /bin/bash
        ssh_authorized_keys:
          - ${file("~/.ssh/id_rsa.pub")}
    disable_root: true
    ssh_pwauth: false
    package_update: true
    package_upgrade: true
  EOF

  cloud_init_network_config = ""
}

