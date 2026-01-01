# ------------------------------------------------------------
# Module Variables
# ------------------------------------------------------------

variable "location" {
  type = string
}

variable "resource_group_name" {
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

variable "common_tags" {
  type = map(string)
}

variable "storage_account_id" {
  type = string
}

variable "storage_account_name" {
  type = string
}

