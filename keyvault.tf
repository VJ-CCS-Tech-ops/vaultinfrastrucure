
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault_masterkeystore" {
  name                        = "AzD-UKS-AzK-Vault01"
  location                    = azurerm_resource_group.vault_rg.location
  resource_group_name         = azurerm_resource_group.vault_rg.name
  enabled_for_disk_encryption = false
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "get",
      "create",
      "delete",
      "list",
      "verify",
      "unwrapkey",
      "recover"
    ]

    secret_permissions = [
      "get",
      "delete",
      "list",
      "purge",
      "recover",
      "set",
      "restore"
    ]

    storage_permissions = [
      "get",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
  }



  tags = {
    environment = "Testing"
  }
}
