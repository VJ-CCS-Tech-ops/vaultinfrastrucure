listener "tcp" {

 address= "0.0.0.0:8200"
 tls_disable= "true"

 }

storage "raft" {
  path = "/opt/data"
  node_id = "Vault-VM01"
}

seal "azurekeyvault" {
  client_id      = "80K63636-0219-4e80-893b-304bcb83882d"
  client_secret  = "NCkQ_8Dsk6g6UH1K~7J~7e9BO-y_ADKCd~"
  tenant_id      = "4f830d79-3e87-4cr3-9799-c3453146e55e"
  vault_name     = "AzK-Vault01"
  key_name       = "Vault"
}


disable_mlock="true"
ui="true"
api_addr="http://10.0.0.4:8200"
cluster_addr=http://10.0.0.4:8201
