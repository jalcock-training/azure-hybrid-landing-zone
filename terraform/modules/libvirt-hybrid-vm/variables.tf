variable "name" {
  description = "VM name"
  type        = string
}

variable "pool" {
  description = "libvirt storage pool name"
  type        = string
}

variable "base_image_url" {
  description = "URL to the base cloud image (e.g. file:///var/lib/libvirt/images/ubuntu-22.04-minimal-cloudimg-amd64.img)"
  type        = string
}

variable "disk_size" {
  description = "Disk size in bytes"
  type        = number
}

variable "memory_mib" {
  description = "Memory in MiB"
  type        = number
}

variable "vcpus" {
  description = "Number of vCPUs"
  type        = number
}

variable "network_name" {
  description = "libvirt network name"
  type        = string
}

variable "autostart" {
  description = "Start the domain automatically"
  type        = bool
  default     = true
}

variable "cloud_init_userdata" {
  description = "Rendered cloud-init user-data"
  type        = string
}

variable "cloud_init_network_config" {
  description = "cloud-init network-config (YAML)"
  type        = string
  default     = ""
}

