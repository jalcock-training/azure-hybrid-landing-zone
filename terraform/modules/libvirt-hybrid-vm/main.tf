terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "= 0.9.1"
    }
  }
}

# ------------------------------------------------------------
# Cloud-init seed ISO
# ------------------------------------------------------------

resource "libvirt_cloudinit_disk" "seed" {
  name = "${var.name}-cloudinit"

  user_data = var.cloud_init_userdata

  meta_data = <<-EOF
    instance-id: ${var.name}
    local-hostname: ${var.name}
  EOF

  network_config = var.cloud_init_network_config
}

# Upload cloud-init ISO into the pool
resource "libvirt_volume" "seed_volume" {
  name = "${var.name}-cloudinit.iso"
  pool = var.pool

  create = {
    content = {
      url = libvirt_cloudinit_disk.seed.path
    }
  }
}

# ------------------------------------------------------------
# Pull the base image
# ------------------------------------------------------------

resource "libvirt_volume" "base_image" {
  name   = "${var.name}-base.qcow2"
  pool   = var.pool

  create = {
    content = {
      url = var.base_image_url
    }
  }
}


# ------------------------------------------------------------
# VM domain
# ------------------------------------------------------------

resource "libvirt_domain" "vm" {
  name   = var.name
  memory = var.memory_mib
  vcpu   = var.vcpus
  type   = "kvm"

  os = {
    type = "hvm"
    arch = "x86_64"
  }

  features = {
    acpi = true
  }

  devices = {
    # --------------------------------------------------------
    # Root disk — direct file, virtio bus
    # --------------------------------------------------------
    disks = [
      {
        source = {
          volume = {
            pool   = libvirt_volume.base_image.pool
            volume = libvirt_volume.base_image.name
          }
        }
        driver = {
          name = "qemu"
          type = "qcow2"
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
      },

      # ------------------------------------------------------
      # Cloud-init ISO
      # ------------------------------------------------------
      {
        device = "cdrom"
        source = {
          volume = {
            pool   = libvirt_volume.seed_volume.pool
            volume = libvirt_volume.seed_volume.name
          }
        }
        target = {
          dev = "sdb"
          bus = "sata"
        }
      }
    ]

    # --------------------------------------------------------
    # Network interface
    # --------------------------------------------------------
    interfaces = [
      {
        type  = "network"
        model = {
          type = "virtio"
        }
        source = {
          network = {
            network = var.network_name
          }
        }
      }
    ]
  }

  running   = false
  autostart = var.autostart
}

