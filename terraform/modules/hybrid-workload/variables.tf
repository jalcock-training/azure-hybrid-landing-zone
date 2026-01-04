variable "name" {
  description = "Base name for hybrid workload"
  type        = string
}

variable "common_name" {
  description = "CN for certificate"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "storage_account_id" {
  description = "Storage account ID"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name"
  type        = string
}

variable "storage_container_name" {
  description = "Blob container name"
  type        = string
}

variable "content_file" {
  description = "Path to index.html"
  type        = string
}

