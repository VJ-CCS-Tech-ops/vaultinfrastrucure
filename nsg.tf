resource "azurerm_network_security_group" "vault_nsg" {
  name                = "AzD-UKS-NSG01"
  location            = "${var.region}"
  resource_group_name = azurerm_resource_group.vault_rg.name

  tags = {
    region : "UK South"
    environment        = "Development"
    maintenance_window = "none"
    department         = "TechOps"
    ApplicationName    = "Vault"
    CostCenter         = "Technology Support"
    TechnicalContact   = "Vijay elangovan"
    Owner              = "Andrew Watts"
    DataClassification = "Official"
  }
}

resource "azurerm_network_security_rule" "security_rules" {

  count                       = "${length(var.inbound_port_ranges)}"
  name                        = "sg-rule-${count.index}"
  priority                    = "${count.index + 100}"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "${element(var.inbound_port_ranges, count.index)}"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vault_rg.name
  network_security_group_name = azurerm_network_security_group.vault_nsg.name
}
