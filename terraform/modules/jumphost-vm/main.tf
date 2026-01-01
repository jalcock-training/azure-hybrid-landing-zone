# ------------------------------------------------------------
# Jump Host VM Module
# ------------------------------------------------------------

# ------------------------------------------------------------
# Network Interface
# ------------------------------------------------------------
resource "azurerm_network_interface" "nic" {
  name                = "jumphost-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# ------------------------------------------------------------
# Network Security Group (internal SSH in and outbound internet)
# ------------------------------------------------------------
resource "azurerm_network_security_group" "nsg" {
  name                = "jumphost-nic-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh-from-vnet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-jhvm-internet-outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  tags = var.tags
}

# Add roles to the identity to be able to pull data from the subscription resources
resource "azurerm_role_assignment" "jumphost_contributor" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "jumphost_network" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "jumphost_policy" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Resource Policy Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

resource "azurerm_role_assignment" "jumphost_tags" {
  scope                = "/subscriptions/${var.subscription_id}"
  role_definition_name = "Tag Contributor"
  principal_id         = azurerm_linux_virtual_machine.vm.identity[0].principal_id
}

# Attach NSG to NIC
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# ------------------------------------------------------------
# Jumphost VM (Ubuntu 24.04 LTS)
# ------------------------------------------------------------
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "jumphost"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  custom_data = base64encode(templatefile("${path.module}/cloud-init-jump.yaml", {
    admin_username = var.admin_username
    private_key    = var.ssh_private_key
  }))

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "jumphost-osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
