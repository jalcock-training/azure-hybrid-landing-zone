variable "autostart" {
  type    = bool
  default = false
}

variable "name" {
  type    = string
  default = "ahlz-hybrid01-endpoint"
}

variable "pool" {
  type    = string
  default = "default"
}

variable "base_image_url" {
  type    = string
  default = ""
}

variable "disk_size" {
  type    = number
  default = 10 * 1024 * 1024 * 1024
}

variable "memory_mib" {
  type    = number
  default = 1024
}

variable "vcpus" {
  type    = number
  default = 1
}

variable "network_name" {
  type    = string
  default = "default"
}

variable "subscription_id" {
  type = string
}

variable "libvirt_host" {
  type        = string
  description = "Hostname or IP of the libvirt/KVM server"
}

variable "libvirt_user" {
  type        = string
  description = "SSH user for libvirt"
}

