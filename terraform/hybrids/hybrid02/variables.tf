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

