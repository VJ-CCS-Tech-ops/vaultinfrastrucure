resource "azurerm_public_ip" "vault_pubip" {
  name                = "Vault-LBS01-PIP"
  location            = "${var.region}"
  resource_group_name = azurerm_resource_group.vault_rg.name
  allocation_method   = "Static"
}

resource "azurerm_lb" "vault_lb" {
  name                = "Vault-LBS"
  location            = "${var.region}"
  resource_group_name = azurerm_resource_group.vault_rg.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.vault_pubip.id
  }
}

resource "azurerm_lb_backend_address_pool" "vault_backendpool" {
  resource_group_name = azurerm_resource_group.vault_rg.name
  loadbalancer_id     = azurerm_lb.vault_lb.id
  name                = "vault-pool"
}

resource "azurerm_lb_probe" "vault_healthprobe" {
  resource_group_name = azurerm_resource_group.vault_rg.name
  loadbalancer_id     = azurerm_lb.vault_lb.id
  name                = "health-check"
  port                = "${var.vault_port}"
}

resource "azurerm_lb_rule" "example" {
  resource_group_name            = azurerm_resource_group.vault_rg.name
  loadbalancer_id                = azurerm_lb.vault_lb.id
  name                           = "loadbalance-vault"
  protocol                       = "Tcp"
  frontend_port                  = "${var.https_port}"
  backend_port                   = "${var.vault_port}"
  frontend_ip_configuration_name = "PublicIPAddress"
  disable_outbound_snat          = true
}

resource "azurerm_lb_outbound_rule" "example" {
  resource_group_name     = azurerm_resource_group.vault_rg.name
  loadbalancer_id         = azurerm_lb.vault_lb.id
  name                    = "Outbound-access"
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.vault_backendpool.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}
