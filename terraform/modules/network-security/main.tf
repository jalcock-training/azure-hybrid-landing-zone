# ------------------------------------------------------------
# Create one NSG per subnet
# ------------------------------------------------------------

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnet_map
  name                = "${each.key}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# ------------------------------------------------------------
# Create NSG rules for each subnet
# ------------------------------------------------------------

locals {
  nsg_rule_matrix = {
    for subnet_name, subnet_id in var.subnet_map :
    subnet_name => [
      for rule in var.nsg_rules :
      {
        subnet_name = subnet_name
        rule        = rule
      }
    ]
  }

  nsg_rule_flat = flatten([
    for subnet_name, rules in local.nsg_rule_matrix :
    [
      for r in rules :
      {
        key          = "${r.subnet_name}-${r.rule.name}"
        subnet_name  = r.subnet_name
        rule         = r.rule
      }
    ]
  ])
}

resource "azurerm_network_security_rule" "rules" {
  for_each = {
    for item in local.nsg_rule_flat :
    item.key => item
  }

  name                        = each.value.rule.name
  priority                    = each.value.rule.priority
  direction                   = each.value.rule.direction
  access                      = each.value.rule.access
  protocol                    = each.value.rule.protocol
  source_port_range           = each.value.rule.source_port_range
  destination_port_range      = each.value.rule.destination_port_range
  source_address_prefix       = each.value.rule.source_address_prefix
  destination_address_prefix  = each.value.rule.destination_address_prefix

  network_security_group_name = azurerm_network_security_group.nsg[each.value.subnet_name].name
  resource_group_name         = var.resource_group_name
}

# ------------------------------------------------------------
# Associate NSGs with subnets
# ------------------------------------------------------------

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = var.subnet_map

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

# ------------------------------------------------------------
# Create one route table per subnet
# ------------------------------------------------------------

resource "azurerm_route_table" "rt" {
  for_each            = var.subnet_map
  name                = "${each.key}-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# ------------------------------------------------------------
# Create routes for each subnet
# ------------------------------------------------------------

locals {
  route_matrix = {
    for subnet_name, subnet_id in var.subnet_map :
    subnet_name => [
      for route in var.routes :
      {
        subnet_name = subnet_name
        route       = route
      }
    ]
  }

  route_flat = flatten([
    for subnet_name, routes in local.route_matrix :
    [
      for r in routes :
      {
        key          = "${r.subnet_name}-${r.route.name}"
        subnet_name  = r.subnet_name
        route        = r.route
      }
    ]
  ])
}

resource "azurerm_route" "routes" {
  for_each = {
    for item in local.route_flat :
    item.key => item
  }

  name                = each.value.route.name
  address_prefix      = each.value.route.address_prefix
  next_hop_type       = each.value.route.next_hop_type
  route_table_name    = azurerm_route_table.rt[each.value.subnet_name].name
  resource_group_name = var.resource_group_name
}

# ------------------------------------------------------------
# Associate route tables with subnets
# ------------------------------------------------------------

resource "azurerm_subnet_route_table_association" "rt_assoc" {
  for_each = var.subnet_map

  subnet_id      = each.value
  route_table_id = azurerm_route_table.rt[each.key].id
}
