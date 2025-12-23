###############################################
# Create one NSG per subnet
###############################################

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnet_map
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

###############################################
# Create NSG rules for each NSG
###############################################

resource "azurerm_network_security_rule" "rules" {
  for_each = {
    for subnet_name, subnet_id in var.subnet_map :
    subnet_name => {
      subnet_name = subnet_name
      subnet_id   = subnet_id
    }
  }

  count = length(var.nsg_rules)

  name                        = "${var.nsg_rules[count.index].name}-${each.key}"
  priority                    = var.nsg_rules[count.index].priority
  direction                   = var.nsg_rules[count.index].direction
  access                      = var.nsg_rules[count.index].access
  protocol                    = var.nsg_rules[count.index].protocol
  source_port_range           = var.nsg_rules[count.index].source_port_range
  destination_port_range      = var.nsg_rules[count.index].destination_port_range
  source_address_prefix       = var.nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = var.nsg_rules[count.index].destination_address_prefix

  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
  resource_group_name         = var.resource_group_name
}

###############################################
# Associate NSGs with subnets
###############################################

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = var.subnet_map

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

###############################################
# Create one route table per subnet
###############################################

resource "azurerm_route_table" "rt" {
  for_each            = var.subnet_map
  name                = "${each.key}-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

###############################################
# Create routes for each route table
###############################################

resource "azurerm_route" "routes" {
  for_each = {
    for subnet_name, subnet_id in var.subnet_map :
    subnet_name => {
      subnet_name = subnet_name
      subnet_id   = subnet_id
    }
  }

  count = length(var.routes)

  name                   = "${var.routes[count.index].name}-${each.key}"
  address_prefix         = var.routes[count.index].address_prefix
  next_hop_type          = var.routes[count.index].next_hop_type
  route_table_name       = azurerm_route_table.rt[each.key].name
  resource_group_name    = var.resource_group_name
}

###############################################
# Associate route tables with subnets
###############################################

resource "azurerm_subnet_route_table_association" "rt_assoc" {
  for_each = var.subnet_map

  subnet_id      = each.value
  route_table_id = azurerm_route_table.rt[each.key].id
}
