variable "name" {
  description = "VM name"
  type        = string
}

variable "pool" {
  description = "libvirt storage pool name"
  type        = string
}

variable "base_image" {
  description = "Path or URL to cloud image (e.g. Ubuntu qcow2)"
  type        = string
}

variable "memory" {
  description = "Memory in MiB"
  type        = number
  default     = 2048
}

variable "vcpus" {
  description = "Number of vCPUs"
  type        = number
  default     = 2
}

variable "network_name" {
  description = "libvirt network name"
  type        = string
}

variable "autostart" {
  description = "Autostart VM with libvirtd"
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

