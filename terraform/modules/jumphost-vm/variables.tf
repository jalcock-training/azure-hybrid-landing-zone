# Location where the VM and NIC will be deployed
variable "location" {
  description = "Azure region for the jumphost VM."
  type        = string
}

# Resource group for the VM and NIC
variable "resource_group_name" {
  description = "Resource group in which to deploy the jumphost VM."
  type        = string
}

# Subnet ID where the VM NIC will be placed
variable "subnet_id" {
  description = "Subnet ID for the jumphost VM NIC."
  type        = string
}

# Admin username for the VM
variable "admin_username" {
  description = "Admin username for the jumphost VM."
  type        = string
  default     = "azureuser"
}

# SSH public key for authentication
variable "ssh_public_key" {
  description = "SSH public key for VM login."
  type        = string
}

# SSH public key for authentication
variable "ssh_private_key" {
  description = "SSH private key for VM login."
  type        = string
}

# VM size (small and cheap by default)
variable "jumphost_size" {
  description = "Size of the jumphost VM."
  type        = string
  default     = "Standard_D2as_v5"
}

# Tags applied to all resources
variable "tags" {
  description = "Tags to apply to jumphost VM resources."
  type        = map(string)
  default     = {}
}

variable "subscription_id" {
  type = string
}

