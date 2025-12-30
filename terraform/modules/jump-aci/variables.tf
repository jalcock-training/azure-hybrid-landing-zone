variable "container_name" {
  type        = string
  description = "Name of the ACI jump container"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the ACI container"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the ACI container"
}

variable "container_image" {
  type        = string
  description = "Container image to use for the jump ACI"
}

variable "cpu_cores" {
  type        = number
  description = "CPU cores for the container"
  default     = 1
}

variable "memory_gb" {
  type        = number
  description = "Memory (GB) for the container"
  default     = 1
}

variable "private_key_openssh" {
  type        = string
  description = "OpenSSH formatted private key used to SSH to the jumphost"
  sensitive   = true
}

variable "vm_name" {
  type        = string
  description = "Name of the jumphost VM to start/stop"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the container group"
  default     = {}
}

