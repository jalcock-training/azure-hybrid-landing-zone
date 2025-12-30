# ------------------------------------------------------------
# ACI Jump Container (exec-only, no public IP)
# ------------------------------------------------------------
resource "azurerm_container_group" "jump" {
  name                = var.container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  subnet_ids = [var.subnet_id]

  ip_address_type = "Private"
  dns_name_label  = null

  identity {
    type = "SystemAssigned"
  }

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.cpu_cores
    memory = var.memory_gb

    ports {
      port     = 80
      protocol = "TCP"
    }

    secure_environment_variables = {
      SSH_PRIVATE_KEY_B64 = base64encode(var.private_key_openssh)
      VM_NAME             = var.vm_name
      RESOURCE_GROUP      = var.resource_group_name
    }
  }

  restart_policy = "Never"

  tags = var.tags
}

