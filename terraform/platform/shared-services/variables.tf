variable "resource_group_name" {
  type        = string
  description = "Resource group for shared services."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "prefix" {
  type        = string
  description = "Naming prefix."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
}

