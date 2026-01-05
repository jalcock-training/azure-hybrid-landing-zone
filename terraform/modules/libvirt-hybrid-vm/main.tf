terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "= 0.9.1"
    }
  }
}

###############################################
# Cloud-init seed ISO
###############################################

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

###############################################
# VM Domain (minimal, stable, boots reliably)
###############################################

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

    #########################################
    # Root disk — direct file, no volumes
    #########################################
    disks = [
      {
        source = {
          file = {
            file = "/var/lib/libvirt/images/jammy-server-cloudimg-amd64.img"
          }
        }
        target = {
          dev = "sda"
          bus = "sata"
        }
      },

      #########################################
      # Cloud-init ISO
      #########################################
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

    #########################################
    # Network interface
    #########################################
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

  running   = true
  autostart = var.autostart
}

