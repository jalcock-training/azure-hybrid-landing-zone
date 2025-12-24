variable "location" {
  description = "Azure region for the ACI jump container."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group in which to deploy the ACI jump container."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the ACI jump container."
  type        = string
}

variable "container_name" {
  description = "Name of the ACI jump container."
  type        = string
  default     = "jump-aci"
}

variable "container_image" {
  description = "Container image to use for the jump container."
  type        = string
  default     = "mcr.microsoft.com/azure-cli"
}

variable "cpu_cores" {
  description = "Number of CPU cores for the ACI instance."
  type        = number
  default     = 1
}

variable "memory_gb" {
  description = "Memory (in GB) for the ACI instance."
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to apply to ACI resources."
  type        = map(string)
  default     = {}
}

variable "private_key_pem" {
  description = "The private SSH key used by the ACI container to access the jumphost VM."
  type        = string
}
