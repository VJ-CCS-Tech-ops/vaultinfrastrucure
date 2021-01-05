resource "azurerm_subnet" "vaultsubnet" {
  name                 = "AzD-UKS-SB01"
  resource_group_name  = azurerm_resource_group.vault_rg.name
  virtual_network_name = azurerm_virtual_network.vault_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}
