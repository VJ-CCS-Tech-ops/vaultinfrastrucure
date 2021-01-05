
resource "azurerm_network_interface" "vault_nic" {
  for_each            = toset("${var.vm_names}")
  name                = each.value
  location            = "${var.region}"
  resource_group_name = azurerm_resource_group.vault_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vaultsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vault_vm" {
  for_each            = toset("${var.vm_names}")
  name                = each.value
  resource_group_name = azurerm_resource_group.vault_rg.name
  location            = azurerm_resource_group.vault_rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.vault_nic[each.key].id,
  ]
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.8"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }




}
