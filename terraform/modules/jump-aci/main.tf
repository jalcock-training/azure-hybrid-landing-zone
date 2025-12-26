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

  ip_address_type     = "Private"
  dns_name_label  = null

  container {
    name   = var.container_name
    image  = var.container_image
    cpu    = var.cpu_cores
    memory = var.memory_gb

    ports {
      port     = 80
      protocol = "TCP"
    }

    commands = ["/bin/sh", "-c", <<EOF
az login --identity --allow-no-subscriptions
apt-get update
apt-get install -y openssh-client
mkdir -p /root/.ssh
echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
echo "$ENTRYPOINT_SCRIPT" > /entrypoint.sh
chmod +x /entrypoint.sh
/bin/sh /entrypoint.sh
EOF
  ]

    secure_environment_variables = {
      SSH_PRIVATE_KEY    = var.private_key_pem
      VM_NAME            = var.vm_name
      RESOURCE_GROUP     = var.resource_group_name
      ENTRYPOINT_SCRIPT  = file("${path.module}/entrypoint.sh")
    }
  }

  restart_policy = "Never"

  tags = var.tags

  identity {
    type = "SystemAssigned"
  }
}
