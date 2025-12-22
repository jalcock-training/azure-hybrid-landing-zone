resource "azurerm_management_group" "platform" {
  display_name = "${var.prefix}-platform"
  name         = "${var.prefix}-platform"
  parent_management_group_id = var.root_management_group_id
}

resource "azurerm_management_group" "landingzones" {
  display_name = "${var.prefix}-landingzones"
  name         = "${var.prefix}-landingzones"
  parent_management_group_id = var.root_management_group_id
}

