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
  default = "http://localhost/cloud-images/ubuntu-22.04-minimal-cloudimg-amd64.img"
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

