# ------------------------------------------------------------
# Module Variables
# ------------------------------------------------------------

variable "location" {
  type = string
}

variable "resource_group_name" {
  description = "Resource group where the workload VM and related resources will be deployed."
  type = string
}

variable "vnet_name" {
  type = string
}

variable "workload_subnet_id" {
  type = string
}

variable "kv_name" {
  type = string
}

variable "jumphost_admin_username" {
  type    = string
  default = "azureuser"
}

variable "jumphost_ssh_public_key" {
  type = string
}

variable "workload_size" {
  type    = string
  default = "Standard_D2as_v5"
}

variable "name_prefix" {
  type = string
}

variable "jumphost_cidrs" {
  type = list(string)
}

variable "internal_cidrs" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "storage_account_id" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault used for certificate storage and RBAC assignments."
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "Resource group where the Key Vault is located."
  type        = string
}

variable "storage_resource_group_name" {
  description = "Resource group where the Storage Account is located."
  type        = string
}

variable "storage_container_name" {}
