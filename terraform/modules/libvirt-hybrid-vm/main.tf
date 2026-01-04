# ------------------------------------------------------------
# libvirt-hybrid-vm module
#
# Creates a KVM VM with cloud-init on the local libvirt host.
# ------------------------------------------------------------

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "~> 0.7"
    }
  }
}

# ------------------------------------------------------------
# Base disk image
# ------------------------------------------------------------
resource "libvirt_volume" "base_image" {
  name   = "${var.name}-base"
  pool   = var.pool
  source = var.base_image
  format = "qcow2"
}

# ------------------------------------------------------------
# VM disk
# ------------------------------------------------------------
resource "libvirt_volume" "vm_disk" {
  name           = "${var.name}.qcow2"
  pool           = var.pool
  base_volume_id = libvirt_volume.base_image.id
  format         = "qcow2"
}

# ------------------------------------------------------------
# cloud-init ISO
# ------------------------------------------------------------
resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "${var.name}-cloudinit.iso"
  pool           = var.pool
  user_data      = var.cloud_init_userdata
  network_config = var.cloud_init_network_config
}

# ------------------------------------------------------------
# VM domain
# ------------------------------------------------------------
resource "libvirt_domain" "vm" {
  name   = var.name
  memory = var.memory
  vcpu   = var.vcpus

  autostart = var.autostart

  network_interface {
    network_name = var.network_name
  }

  disk {
    volume_id = libvirt_volume.vm_disk.id
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit.id

  graphics {
    type        = "spice"
    listen_type = "none"
  }

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }
}

