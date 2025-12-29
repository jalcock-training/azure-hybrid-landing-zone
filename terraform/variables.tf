# Azure subscription ID used for all deployments.
variable "subscription_id" {
  description = "The Azure subscription ID to deploy resources into."
  type        = string
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
  default     = "southeastasia"
}

variable "prefix" {
  description = "Prefix used for naming all resources."
  type        = string
  default     = "ahlz-dev"
}

variable "enable_diagnostics" {
  type        = bool
  description = "Enable or disable diagnostic settings for all resources."
  default     = true
}

variable "enable_activity_log_export" {
  type        = bool
  description = "Enable or disable Activity Log export."
  default     = true
}

variable "enable_nsg_flow_logs" {
  description = "Enable or disable NSG Flow Logs v2."
  type        = bool
  default     = true
}

# ------------------------------------------------------------
# Workload VM Variables
# ------------------------------------------------------------

variable "workload_certificate_name" {
  type        = string
  description = "Name of the certificate stored in Key Vault for the workload VM"
}

variable "workload_storage_container_name" {
  type        = string
  description = "Storage container holding workload static content"
}

variable "workload_vm_size" {
  type        = string
  default     = "Standard_D2as_v5"
}

variable "vm_admin_username" {
  type        = string
  default     = "azureuser"
}

