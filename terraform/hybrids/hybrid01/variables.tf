variable "name" {
  type        = string
  description = "Name of the SSH relay VM"
  default     = "ahlz-hybrid01-endpoint"
}

variable "pool" {
  type        = string
  description = "Libvirt storage pool"
  default     = "default"
}

variable "base_image_url" {
  type        = string
  description = "URL to the Ubuntu minimal cloud image"
  default     = "file:///var/lib/libvirt/images/ubuntu-22.04-minimal-cloudimg-amd64.img"
}

variable "disk_size" {
  type        = number
  description = "Disk size in bytes"
  default     = 10 * 1024 * 1024 * 1024
}

variable "memory_mib" {
  type        = number
  description = "Memory in MiB"
  default     = 1024
}

variable "vcpus" {
  type        = number
  description = "Number of vCPUs"
  default     = 1
}

variable "network_name" {
  type        = string
  description = "Libvirt network name"
  default     = "default"
}

variable "autostart" {
  type        = bool
  default     = true
}

