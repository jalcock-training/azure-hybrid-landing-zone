terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "= 0.9.1"
    }
  }
}

# Base image volume (copy from Ubuntu minimal cloud image)
resource "libvirt_volume" "base_image" {
  name = "${var.name}-base.qcow2"
  pool = var.pool

  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = var.base_image_url
    }
  }
}


# Writable VM disk, backed by the base image
resource "libvirt_volume" "vm_disk" {
  name     = "${var.name}.qcow2"
  pool     = var.pool
  capacity = var.disk_size

  target = {
    format = {
      type = "qcow2"
    }
  }

  backing_store = {
    path = libvirt_volume.base_image.path

    format = {
      type = "qcow2"
    }
  }
}


# Cloud-init seed ISO (local file representation)
resource "libvirt_cloudinit_disk" "seed" {
  name = "${var.name}-cloudinit"

  user_data = var.cloud_init_userdata

  meta_data = <<-EOF
    instance-id: ${var.name}
    local-hostname: ${var.name}
  EOF

  network_config = var.cloud_init_network_config
}

# Upload the cloud-init ISO into the pool
resource "libvirt_volume" "seed_volume" {
  name = "${var.name}-cloudinit.iso"
  pool = var.pool

  create = {
    content = {
      url = libvirt_cloudinit_disk.seed.path
    }
  }
}

# Headless VM domain
resource "libvirt_domain" "vm" {
  name   = var.name
  memory = var.memory_mib * 1024 * 1024
  vcpu   = var.vcpus
  type   = "kvm"

  os = {
    type    = "hvm"
    arch    = "x86_64"
    machine = "q35"
  }

  features = {
    acpi = true
  }

  devices = {
    disks = [
      {
        # Root disk
        source = {
          volume = {
            pool   = libvirt_volume.vm_disk.pool
            volume = libvirt_volume.vm_disk.name
          }
        }
        target = {
          dev = "vda"
          bus = "virtio"
        }
      },
      {
        # cloud-init ISO
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

