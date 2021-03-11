resource "azurerm_resource_group" "vault_rg" {
  name     = "Vault"
  location = "${var.region}"

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
