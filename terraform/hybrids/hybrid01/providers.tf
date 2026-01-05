terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "= 0.9.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "libvirt" {
  uri = "qemu+ssh://${var.libvirt_user}@${var.libvirt_host}/system"
}

