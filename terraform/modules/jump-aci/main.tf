# ------------------------------------------------------------
# ACI Jump Container (exec-only, no public IP)
# ------------------------------------------------------------
resource "azurerm_container_group" "jump" {
  name                = var.container_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  # Deploy into the hub shared-services subnet
  subnet_ids = [
    var.subnet_id
  ]

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.cpu_cores
    memory = var.memory_gb

    # No ports exposed — access only via `az container exec`
    ports {
      port     = 0
      protocol = "TCP"
    }

    # Keep container alive for exec sessions
    command = ["/bin/sh", "-c", "sleep infinity"]
  }

  restart_policy = "Never"

  tags = var.tags
}
