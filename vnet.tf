resource "azurerm_virtual_network" "vault_vnet" {
  name                = "VN01"
  address_space       = ["10.0.0.0/16"]
  location            = "${var.region}"
  resource_group_name = azurerm_resource_group.vault_rg.name

  tags = {
    region : "UK South"
    environment        = "Development"
    maintenance_window = "none"
    ApplicationName    = "Vault"
    TechnicalContact   = "Vijay elangovan"
    DataClassification = "Official"
  }
}
