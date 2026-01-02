variable "resource_group_name" {
  description = "Resource group for hub network resources."
  type        = string
}

variable "location" {
  description = "Azure region for hub resources."
  type        = string
}

variable "prefix" {
  description = "Prefix for hub resource names."
  type        = string
}

variable "tags" {
  description = "Tags to apply to hub resources."
  type        = map(string)
}

variable "key_vault_id" { 
  type = string 
}

